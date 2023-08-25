*&---------------------------------------------------------------------*
*& Include          ZOT_23_P_SAS_ALV_CLS
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.

    METHODS set_fcat.
    METHODS get_data.
    METHODS set_layout.
    METHODS start_of_selection.
    METHODS display_alv.
*    METHODS POPUP.

    METHODS handle_double_click
      FOR EVENT double_click OF cl_gui_alv_grid

      IMPORTING
        e_row
        e_column
        es_row_no.

    METHODS get_sel_rows
      IMPORTING io_alv                 TYPE REF TO cl_gui_alv_grid
      RETURNING VALUE(rt_seleced_rows) TYPE lvc_t_roid.

    METHODS handle_buttonclick
      FOR EVENT button_click OF cl_gui_alv_grid

      IMPORTING
        es_col_id
        es_row_no.

    METHODS handle_hotspot_click
      FOR EVENT hotspot_click OF cl_gui_alv_grid

      IMPORTING
        e_row_id
        e_column_id.

    METHODS handle_toolbar
      FOR EVENT toolbar OF cl_gui_alv_grid

      IMPORTING
        e_object
        e_interactive.

    METHODS handle_user_command
      FOR EVENT user_command OF cl_gui_alv_grid

      IMPORTING
        e_ucomm.

ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.

  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'zot_23_s_sas_main1'   "main1 üst alv'yi temsil etmekte
      CHANGING
        ct_fieldcat      = gt_fcat.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'zot_23_s_sas_main2'    "main2 alt alv'yi temsil etmekte
      CHANGING
        ct_fieldcat      = gt_fcat2.


    LOOP AT gt_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>).
      CASE <lfs_fcat>-fieldname.
        WHEN 'VBELN'.
          <lfs_fcat>-hotspot = abap_true.
      ENDCASE.
    ENDLOOP.

    LOOP AT gt_fcat2 ASSIGNING FIELD-SYMBOL(<lfs_fcat2>).
      CASE <lfs_fcat2>-fieldname.
        WHEN 'NETPR_GUNCEL'.
          <lfs_fcat2>-edit = abap_true.
        WHEN 'DISPLAY_LOG'.
          <lfs_fcat2>-coltext = TEXT-001.
          <lfs_fcat2>-style = cl_gui_alv_grid=>mc_style_button.
          <lfs_fcat2>-icon = abap_true.
        WHEN 'VBELN'.
          <lfs_fcat2>-hotspot = abap_true.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_data.
    SELECT vbrk~vbeln,
           vbrk~bukrs,
           vbrk~fkdat,
           vbrk~fkart,
           vbrk~kunrg,
           vbrk~fktyp,
           vbrk~vkorg,
           vbrk~vtweg,
           vbrk~kunrg,
           vbrk~netwr,
           vbrk~waerk
      FROM vbrk
      INTO TABLE @gt_main1
      WHERE vbrk~vbeln IN @s_vbeln
      AND   vbrk~fkdat IN @s_fkdat
      AND   vbrk~fkart IN @s_fkart
      AND   vbrk~kunrg IN @s_kunrg.

  ENDMETHOD.

  METHOD set_layout.
    CLEAR: gs_layout.
    gs_layout-zebra = abap_true.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-stylefname = 'CELL_STYLE'.   "netpr güncel editable için
    gs_layout-ctab_fname = 'CELL_COLOR'.

  ENDMETHOD.

  METHOD start_of_selection.
    go_event_receiver->get_data( ).
    go_event_receiver->set_fcat( ).
    go_event_receiver->set_layout( ).
    go_event_receiver->display_alv( ).
  ENDMETHOD.

  METHOD display_alv.
    IF go_alv IS INITIAL.
      CREATE OBJECT go_cont
        EXPORTING
          container_name = 'CC_ALV'.

      CREATE OBJECT go_splitter
        EXPORTING
          parent  = go_cont
          rows    = 2
          columns = 1.

      CALL METHOD go_splitter->get_container
        EXPORTING
          row       = 1
          column    = 1
        RECEIVING
          container = go_gui1.

      CALL METHOD go_splitter->get_container
        EXPORTING
          row       = 2
          column    = 1
        RECEIVING
          container = go_gui2.

      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_gui1.

      CREATE OBJECT go_alv2
        EXPORTING
          i_parent = go_gui2.

      CREATE OBJECT go_event_receiver.
      SET HANDLER go_event_receiver->handle_double_click FOR go_alv.
      SET HANDLER go_event_receiver->handle_hotspot_click FOR go_alv.

      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
          is_layout       = gs_layout
        CHANGING
          it_outtab       = gt_main1
          it_fieldcatalog = gt_fcat.


      CALL METHOD go_alv->register_edit_event
        EXPORTING
          i_event_id = cl_gui_alv_grid=>mc_evt_modified.

    ELSE.
      CALL METHOD go_alv->refresh_table_display( ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_double_click.
    DATA: ls_cell TYPE lvc_s_styl.

    CLEAR: gt_main2.
    READ TABLE gt_main1 INTO gs_main1 INDEX e_row-index.
    SELECT vbrp~vbeln,
           vbrp~posnr,
           vbrp~fkimg,
           vbrp~vrkme,
           vbrp~meins,
           vbrk~waerk,
           vbrp~ntgew,
           vbrp~brgew,
           vbrp~netwr,
           vbrp~matnr,
           vbrp~arktx
      FROM vbrp
      INNER JOIN vbrk
            ON vbrk~vbeln EQ vbrp~vbeln
      WHERE vbrp~vbeln EQ @gs_main1-vbeln
      INTO CORRESPONDING FIELDS OF TABLE @gt_main2.

*      SELECT *
*        FROM zot_23_t_log
*        INTO CORRESPONDING FIELDS of TABLE @gt_log.
    SELECT *
            FROM zot_23_t_log
*        WHERE zot_23_t_log~
            INTO CORRESPONDING FIELDS OF TABLE @gt_log_pop
            ORDER BY zot_23_t_log~time_f.

**************update the edited cell**********************

    LOOP AT gt_main2 ASSIGNING FIELD-SYMBOL(<fs_main2>).

      <fs_main2>-display_log = '@96@'. "log görüntüle ikonunun kodu

      READ TABLE gt_log_pop INTO DATA(ls_main2)  WITH KEY vbeln = <fs_main2>-vbeln
                                                      posnr = <fs_main2>-posnr.
      <fs_main2>-netpr_guncel = ls_main2-netpr_guncel.


      CASE <fs_main2>-netpr_guncel.
        WHEN '0'.   " Değer 0 ise beyaz renk
          CLEAR: gs_cell_color.
        WHEN OTHERS.   " Değer 0 değilse kırmızı renk
          gs_cell_color-fname = 'NETPR_GUNCEL'.
          gs_cell_color-color-col = '6'.  "rengi belirler
          gs_cell_color-color-int = '1'.
          gs_cell_color-color-inv = '0'.
          APPEND gs_cell_color TO <fs_main2>-cell_color.
      ENDCASE.

**********NETPR Hesaplama - NETPR Güncel editable*******
      <fs_main2>-netpr = <fs_main2>-netwr / <fs_main2>-fkimg.
      IF <fs_main2>-netpr LT 100.
        ls_cell-fieldname = 'NETPR_GUNCEL'.
        ls_cell-style = cl_gui_alv_grid=>mc_style_disabled.
        APPEND ls_cell TO <fs_main2>-cell_style.
      ENDIF.

    ENDLOOP.
********************************************************

    SET HANDLER go_event_receiver->handle_buttonclick FOR go_alv2.
    SET HANDLER go_event_receiver->handle_hotspot_click FOR go_alv2.
    SET HANDLER go_event_receiver->handle_toolbar FOR go_alv2.
    SET HANDLER go_event_receiver->handle_user_command FOR go_alv2.

    CALL METHOD go_alv2->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_main2
        it_fieldcatalog = gt_fcat2.


  ENDMETHOD.

  METHOD get_sel_rows.
    CALL METHOD io_alv->get_selected_rows
      IMPORTING
        et_row_no = rt_seleced_rows.
  ENDMETHOD.

  METHOD handle_buttonclick.

    READ TABLE gt_log ASSIGNING FIELD-SYMBOL(<fs_log>) INDEX es_row_no-row_id.
    IF sy-subrc = 0.
      gs_log = <fs_log>.
      LOOP AT gt_log ASSIGNING FIELD-SYMBOL(<fs_pop>) WHERE vbeln EQ gs_log-vbeln AND posnr EQ gs_log-posnr.
        APPEND <fs_pop> TO gt_log_pop.
        COMMIT WORK.
      ENDLOOP.
    ENDIF.

    IF gt_log_pop IS INITIAL.
      MESSAGE 'Log bulunamadı!.' TYPE 'I'.
    ELSE.
      MESSAGE 'Log bulundu.' TYPE 'S'.
    ENDIF.


    DATA: ls_selfield TYPE slis_selfield.
    CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
      EXPORTING
        i_title          = 'Log Görüntüleme'
        i_selection      = abap_true
        i_zebra          = abap_true
        i_tabname        = 'ZOT_23_T_LOG'
        i_structure_name = 'ZOT_23_T_LOG'
      IMPORTING
        es_selfield      = ls_selfield
      TABLES
        t_outtab         = gt_log_pop
      EXCEPTIONS
        program_error    = 1
        OTHERS           = 2.


  ENDMETHOD.

  METHOD handle_hotspot_click.
    READ TABLE gt_main1 ASSIGNING FIELD-SYMBOL(<fs_hotmain1>) INDEX e_row_id-index.
    IF sy-subrc EQ 0.
      CASE e_row_id.
        WHEN 'VBELN'.
          SET PARAMETER ID 'VF' FIELD <fs_hotmain1>-vbeln.
          CALL TRANSACTION 'VF03' AND SKIP FIRST SCREEN.
      ENDCASE.
    ENDIF.

    READ TABLE gt_main2 ASSIGNING FIELD-SYMBOL(<fs_hotmain2>) INDEX e_row_id-index.
    IF sy-subrc EQ 0.
      CASE e_column_id.
        WHEN 'VBELN'.
          SET PARAMETER ID 'VF' FIELD <fs_hotmain2>-vbeln.  "bununla birlikte yazarsak seçilen vbeln için olan vf03 ekranını direkt getirir
          CALL TRANSACTION 'VF03' AND SKIP FIRST SCREEN. "bunu yaparsak sadece vf03 ekranını açar manuel olarak vbelnini yazarsın
      ENDCASE.
    ENDIF.

  ENDMETHOD.


  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.
    ls_toolbar-function = '&SAVE_B'.
    ls_toolbar-text = 'Fiyat Kaydet'.
    ls_toolbar-icon = '@2L@'.
    ls_toolbar-quickinfo = 'Fiyat Kaydetme'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    ls_toolbar-function = '&SAS_B'.
    ls_toolbar-text = 'SAS Oluştur'.
    ls_toolbar-icon = '@0Y@'.
    ls_toolbar-quickinfo = 'SAS Oluşturma'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN '&SAVE_B'.

        DATA: lt_selected_data TYPE TABLE OF zot_23_s_sas_main2,
              ls_selected_data LIKE LINE OF lt_selected_data,
              ls_log_entry     TYPE zot_23_t_log.

        LOOP AT get_sel_rows( go_alv2 ) ASSIGNING FIELD-SYMBOL(<fs_row>).
          READ TABLE gt_main2 ASSIGNING FIELD-SYMBOL(<fs_main2>) INDEX <fs_row>-row_id.
          IF sy-subrc = 0.
            APPEND <fs_main2> TO lt_selected_data.
            COMMIT WORK.
          ENDIF.
        ENDLOOP.

        LOOP AT lt_selected_data INTO ls_selected_data.
          CLEAR ls_log_entry.

          " Log tablosu alanlarını doldur
          ls_log_entry-vbeln = ls_selected_data-vbeln.
          ls_log_entry-posnr = ls_selected_data-posnr.
          ls_log_entry-netpr = ls_selected_data-netpr.
          ls_log_entry-netpr_guncel = ls_selected_data-netpr_guncel.
          ls_log_entry-user_f = sy-uname.
          ls_log_entry-date_f = sy-datum.
          ls_log_entry-time_f = sy-uzeit.

          " Log tablosuna ekle
          INSERT INTO zot_23_t_log VALUES ls_log_entry.
          COMMIT WORK. "Anında işlemi yapması için
        ENDLOOP.

        IF ls_log_entry IS INITIAL.
          MESSAGE 'Seçilen satırlar kaydedilmedi!.' TYPE 'I'.
        ELSE.
          MESSAGE 'Seçilen satırlar kaydedildi.' TYPE 'S'.
        ENDIF.


      WHEN '&SAS_B'.
*        go_event_receiver->popup( ).
*
*        SELECT ekko~ekorg,
*               ekko~ekgrp,
*               werks~werks,
*               lgort~lgort
*          FROM ekko
*          INTO TABLE @gt_main3
*          WHERE ekko~ekorg IN @s_ekorg
*          AND   ekko~ekgrp IN @s_ekgrp
*          AND   werks~werks IN @s_werks
*          AND   lgort~lgort IN @s_lgort.



    ENDCASE.
  ENDMETHOD.

*  METHOD popup.
*    TYPES: BEGIN OF ty_ehe,
*       s_ekorg TYPE ekko-ekorg,
*                s_ekgrp TYPE ekko-ekgrp,
*                s_werks TYPE werks-werks,  "WERKS_D
*                s_lgort TYPE lgort-lgort,
*      END OF ty_ehe.
*
*      DATA: lt_ehe TYPE TABLE OF ty_ehe.
*
*  CALL FUNCTION 'POPUP_GET_VALUES'
*    EXPORTING
**     NO_VALUE_CHECK        = ' '
*      popup_title           = 'Ehe'
**     START_COLUMN          = '5'
**     START_ROW             = '5'
**   IMPORTING
**     RETURNCODE            =
*    tables
*      fields                = lt_ehe
**   EXCEPTIONS
**     ERROR_IN_FIELDS       = 1
**     OTHERS                = 2
*            .
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.




*    ENDMETHOD.

ENDCLASS.
