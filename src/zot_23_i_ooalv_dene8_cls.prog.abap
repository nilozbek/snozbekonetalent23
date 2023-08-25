*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE8_CLS
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.

*    METHODS handle_top_of_page
*      FOR EVENT top_of_page OF cl_gui_alv_grid
*
*      IMPORTING
*        e_dyndoc_id
*        table_index.

*    METHODS handle_hotspot_click
*      FOR EVENT hotspot_click OF cl_gui_alv_grid
*
*      IMPORTING
*        e_row_id
*        e_column_id.

*    METHODS handle_double_click
*      FOR EVENT double_click OF cl_gui_alv_grid
*
*      IMPORTING
*        e_row
*        e_column
*        es_row_no.

*    METHODS handle_data_changed
*      FOR EVENT data_changed OF cl_gui_alv_grid
*
*      IMPORTING
*        er_data_changed
*        e_onf4
*        e_onf4_before
*        e_onf4_after
*        e_ucomm.


*    METHODS handle_onf4
*      FOR EVENT onf4 OF cl_gui_alv_grid
*
*      IMPORTING
*        e_fieldname
*        e_fieldvalue
*        er_event_data
*        es_row_no
*        et_bad_cells
*        e_display.

*    METHODS handle_buttonclick
*      FOR EVENT button_click OF cl_gui_alv_grid
*
*      IMPORTING
*        es_col_id
*        es_row_no.

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
*  METHOD handle_top_of_page.
*    DATA: lv_text TYPE sdydo_text_element.
*
*    lv_text = 'FLIGHT DETAILS'.
*
*    CALL METHOD go_docu->add_text
*      EXPORTING
*        text      = lv_text
*        sap_style = cl_dd_document=>heading.
*
*    CALL METHOD go_docu->new_line.
*    CLEAR: lv_text.
*
*    CONCATENATE 'User: ' sy-uname INTO lv_text SEPARATED BY space.
*
*    CALL METHOD go_docu->add_text
*      EXPORTING
*        text         = lv_text
*        sap_color    = cl_dd_document=>list_positive  "renk veriyor
*        sap_fontsize = cl_dd_document=>medium.   "yazının boyutunu belirtiyor
*
*    CALL METHOD go_docu->display_document
*      EXPORTING
*        parent = go_sub1.
*
*  ENDMETHOD.

*  METHOD handle_hotspot_click.
**    DATA: lv_mess TYPE char200.
**
**    READ TABLE gt_scarr INTO gs_scarr INDEX e_row_id-index.  "index hangi satırımı tuttuğumun verisi
**    IF sy-subrc EQ 0.
**      CASE e_column_id.
**        WHEN 'CARRID'.
**          CONCATENATE 'Tıklanan kolon' e_column_id 'değeri' gs_scarr-carrid   INTO lv_mess SEPARATED BY space.
**          MESSAGE lv_mess TYPE 'I'.
**        WHEN 'CARRNAME'.
**          CONCATENATE 'Tıklanan kolon' e_column_id 'değeri' gs_scarr-carrname INTO lv_mess SEPARATED BY space.
**          MESSAGE lv_mess TYPE 'I'.
**        WHEN 'CURRCODE'.
**          CONCATENATE 'Tıklanan kolon' e_column_id 'değeri' gs_scarr-currcode INTO lv_mess SEPARATED BY space.
**          MESSAGE lv_mess TYPE 'I'.
**        WHEN 'URL'.
**          CONCATENATE 'Tıklanan kolon' e_column_id 'değeri' gs_scarr-url      INTO lv_mess SEPARATED BY space.
**          MESSAGE lv_mess TYPE 'I'.
**      ENDCASE.
**    ENDIF.
*  ENDMETHOD.

*  METHOD handle_double_click.
*
*    DATA: lv_mess TYPE char200.
*
**    READ TABLE gt_scarr INTO gs_scarr INDEX es_row_no-row_id.
*    READ TABLE gt_scarr INTO gs_scarr INDEX e_row-index.
*    IF sy-subrc EQ 0.
*      CASE e_column.
*        WHEN 'CARRID'.
*          CONCATENATE 'Tıklanan kolon' e_column-fieldname 'değeri' gs_scarr-carrid   INTO lv_mess SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.
*        WHEN 'CARRNAME'.
*          CONCATENATE 'Tıklanan kolon' e_column-fieldname 'değeri' gs_scarr-carrname INTO lv_mess SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.
*        WHEN 'CURRCODE'.
*          CONCATENATE 'Tıklanan kolon' e_column-fieldname 'değeri' gs_scarr-currcode INTO lv_mess SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.
*        WHEN 'URL'.
*          CONCATENATE 'Tıklanan kolon' e_column-fieldname 'değeri' gs_scarr-url      INTO lv_mess SEPARATED BY space.
*          MESSAGE lv_mess TYPE 'I'.
*      ENDCASE.
*    ENDIF.
*  ENDMETHOD.

*  METHOD handle_data_changed.
*    DATA: ls_modi TYPE lvc_s_modi,
*          lv_mess TYPE char200.
*
*    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
*
*      READ TABLE gt_scarr INTO gs_scarr INDEX ls_modi-row_id.
*      IF sy-subrc EQ 0.
*        CONCATENATE ls_modi-fieldname 'Eski değeri=>' gs_scarr-carrname 'yeni değeri=>' ls_modi-value INTO lv_mess SEPARATED BY space.
*      ENDIF.
*      MESSAGE lv_mess TYPE 'I'.
*    ENDLOOP.
*  ENDMETHOD.

*  METHOD handle_onf4.
*    TYPES: BEGIN OF lty_value_tab,
*             carrname TYPE s_carrname,
*           END OF  lty_value_tab.
*
*    DATA: lt_value_tab TYPE TABLE OF  lty_value_tab,
*          ls_value_tab TYPE  lty_value_tab.
*
*    DATA: lt_return_tab TYPE TABLE OF ddshretval,
*          ls_return_tab TYPE ddshretval.
*
*    CLEAR: ls_value_tab.
*    ls_value_tab-carrname = 'Uçuş 1'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*    CLEAR: ls_value_tab.
*    ls_value_tab-carrname = 'Uçuş 2'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*    CLEAR: ls_value_tab.
*    ls_value_tab-carrname = 'Uçuş 3'.
*    APPEND ls_value_tab TO lt_value_tab.
*
*    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*      EXPORTING
*        retfield     = 'CARRNAME'
*        window_title = 'Carrname F4'         "açılan Serach helpin başlığı
*        value_org    = 'S'  "Burası C idi biz S yaptık
*      TABLES
*        value_tab    = lt_value_tab
*        return_tab   = lt_return_tab.
*
*    READ TABLE lt_return_tab INTO ls_return_tab WITH KEY fieldname = 'F0001'.
*    IF sy-subrc EQ 0.
*      READ TABLE gt_scarr ASSIGNING <gfs_scarr> INDEX es_row_no-row_id.
*      IF sy-subrc EQ 0.
*        <gfs_scarr>-carrname = ls_return_tab-fieldval.
*
*        go_grid->refresh_table_display( ).
*
*      ENDIF.
*    ENDIF.
*
*    er_event_data->m_event_handled = 'X'.
*  ENDMETHOD.
*  METHOD handle_buttonclick.
*    DATA: lv_mess TYPE char200.
*
*    READ TABLE gt_scarr INTO gs_scarr INDEX es_row_no-row_id.
*    IF sy-subrc EQ 0.
*      CASE es_col_id-fieldname.
*        WHEN 'DELETE'.
*          CONCATENATE es_col_id-fieldname ',' gs_scarr INTO lv_mess SEPARATED BY space.
*      ENDCASE.
*    ENDIF.
*    MESSAGE lv_mess TYPE 'I'.
*
*  ENDMETHOD.

  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.
    ls_toolbar-function = '&DEL'.
    ls_toolbar-text = 'Silme'.
    ls_toolbar-icon = '@11@'.
    ls_toolbar-quickinfo = 'Silme İşlemi'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.

    ls_toolbar-function = '&DIS'.
    ls_toolbar-text = 'Görüntüle'.
    ls_toolbar-icon = '@10@'.
    ls_toolbar-quickinfo = 'Görüntüleme İşlemi'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN '&DEL'.
        MESSAGE 'Silme işlemi' TYPE 'I'.
      WHEN '&DIS'.
        MESSAGE 'Görüntüleme işlemi' TYPE 'I'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
