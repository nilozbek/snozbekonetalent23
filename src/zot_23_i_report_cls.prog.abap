*&---------------------------------------------------------------------*
*& Include zot_23_i_report_cls
*&---------------------------------------------------------------------*

CLASS lcl_main_controller DEFINITION CREATE PRIVATE FINAL.
  PUBLIC SECTION.

    CLASS-METHODS:
      "! Main controller get singleton object
      get_instance
        RETURNING
          VALUE(ro_instance) TYPE REF TO lcl_main_controller.

    METHODS:
      get_datasat,
      get_datasas,
      display_data_sat,
      display_data_sas,
      display_grid_sat,
      display_grid_sas,
      init_0100,
      init_0100_sas,
      free.

  PRIVATE SECTION.
    CLASS-DATA:
      mo_instance              TYPE REF TO lcl_main_controller,
      mo_main_custom_container TYPE REF TO cl_gui_custom_container,
      "! Main ALV grid
      mo_main_grid             TYPE REF TO cl_gui_alv_grid,
      mt_eban_list              TYPE TABLE OF zot_02_s_eban,
      mt_ekpo_list              TYPE TABLE OF zot_02_s_ekpo.

    METHODS:
      fill_main_fieldcat_sat
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_fieldcat_sas
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_layout
        RETURNING
          VALUE(rs_layo) TYPE lvc_s_layo.

ENDCLASS.

CLASS lcl_main_controller IMPLEMENTATION.
  METHOD get_instance.
    IF mo_instance IS INITIAL.
      mo_instance = NEW #( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.

  METHOD get_datasat.
    SELECT banfn,
           bnfpo,
           bsart,
           matnr,
           menge,
           meins
    FROM eban INTO CORRESPONDING FIELDS OF TABLE @me->mt_eban_list.
  ENDMETHOD.

  METHOD get_datasas.
    SELECT ebeln,
           ebelp,
           matnr,
           menge,
           meins
    FROM ekpo INTO CORRESPONDING FIELDS OF TABLE @me->mt_ekpo_list.
  ENDMETHOD.

  METHOD display_data_sat.
    IF me->mt_eban_list IS INITIAL.
      MESSAGE 'Veri bulunamadı!' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      CALL SCREEN 0100.
    ENDIF.
  ENDMETHOD.

    METHOD display_data_sas.
    IF me->mt_ekpo_list IS INITIAL.
      MESSAGE 'Veri bulunamadı!' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      CALL SCREEN 0100.
    ENDIF.
  ENDMETHOD.

  METHOD display_grid_sat.

    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
                   <ls_data> TYPE any.

    ASSIGN me->mt_eban_list TO <lt_data>.
    CHECK sy-subrc IS INITIAL.
*
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A'
*                                      excp_fname = 'COLOR'
                                      info_fname = 'COLOR'
                                      excp_led   = abap_true ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat_sat( ).

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'EBAN' sy-uname sy-datum sy-uzeit INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
        is_variant         = ls_vari
      TABLES
        t_outtab           = gt_sat
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDMETHOD.

  METHOD display_grid_sas.



    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
                   <ls_data> TYPE any.

    ASSIGN me->mt_ekpo_list TO <lt_data>.
    CHECK sy-subrc IS INITIAL.
*
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A'
*                                      excp_fname = 'COLOR'
                                      info_fname = 'COLOR'
                                      excp_led   = abap_true ).
*    DATA(ls_vari) = VALUE disvariant( report = sy-repid
*                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat_sas( ).

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'EKPO' sy-uname sy-datum sy-uzeit INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
*        is_variant         = ls_vari
      TABLES
        t_outtab           = gt_sas
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDMETHOD.

  METHOD init_0100.
    IF me->mo_main_custom_container IS INITIAL.
      me->mo_main_custom_container = NEW cl_gui_custom_container( container_name = 'CC_MAIN' ).
      me->mo_main_grid = NEW cl_gui_alv_grid( i_parent = me->mo_main_custom_container i_appl_events = abap_true ).

      FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.
      ASSIGN me->mt_eban_list TO <lt_data>.

      DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                        username = sy-uname ).

*      me->set_handler_for_main( ).

      DATA(lt_fcat_main) = me->fill_main_fieldcat_sat( ).

      me->mo_main_grid->set_table_for_first_display(
        EXPORTING
          i_bypassing_buffer            = abap_true
          is_variant                    = ls_vari
          i_save                        = 'A'
          is_layout                     = me->fill_main_layout( )
        CHANGING
          it_outtab                     = gt_sat
          it_fieldcatalog               = lt_fcat_main
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ELSE.
      me->mo_main_grid->refresh_table_display( is_stable = VALUE #( col = abap_true row = abap_true ) ).
    ENDIF.
  ENDMETHOD.

  METHOD init_0100_sas.
    IF me->mo_main_custom_container IS INITIAL.
      me->mo_main_custom_container = NEW cl_gui_custom_container( container_name = 'CC_MAIN' ).
      me->mo_main_grid = NEW cl_gui_alv_grid( i_parent = me->mo_main_custom_container i_appl_events = abap_true ).

      FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.
      ASSIGN me->mt_eban_list TO <lt_data>.

      DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                        username = sy-uname ).

*      me->set_handler_for_main( ).

      DATA(lt_fcat_main) = me->fill_main_fieldcat_sas( ).

      me->mo_main_grid->set_table_for_first_display(
        EXPORTING
          i_bypassing_buffer            = abap_true
          is_variant                    = ls_vari
          i_save                        = 'A'
          is_layout                     = me->fill_main_layout( )
        CHANGING
          it_outtab                     = gt_sas
          it_fieldcatalog               = lt_fcat_main
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ELSE.
      me->mo_main_grid->refresh_table_display( is_stable = VALUE #( col = abap_true row = abap_true ) ).
    ENDIF.
  ENDMETHOD.

  METHOD fill_main_fieldcat_sat.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZOT_23_S_EBAN'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.



  METHOD fill_main_fieldcat_sas.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZOT_23_S_EKPO'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

  METHOD fill_main_layout.
    rs_layo = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).
  ENDMETHOD.

  METHOD free.
    IF me->mo_main_custom_container IS NOT INITIAL.
      me->mo_main_grid->free( ).
      me->mo_main_custom_container->free( ).
      CLEAR: me->mo_main_grid,
             me->mo_main_custom_container.
    ENDIF.
    FREE mo_instance.
    CLEAR mo_instance.
  ENDMETHOD.
ENDCLASS.

DATA:
  go_main TYPE REF TO lcl_main_controller.
