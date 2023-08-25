*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE9_CLS
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS set_fcat.

    METHODS get_data.

    METHODS set_layout.

    METHODS display_alv.

    METHODS start_of_selection.

ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.

  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'SCARR'
      CHANGING
        ct_fieldcat      = gt_fcat.

  ENDMETHOD.
method start_of_selection.
  go_event_receiver->get_data( ).
  go_event_receiver->set_fcat( ).
  go_event_receiver->set_layout( ).
  go_event_receiver->display_alv( ).
endmethod.
  METHOD get_data.
    SELECT * FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
  ENDMETHOD.

METHOD set_layout.
  CLEAR: gs_layout.
*  gs_layout-no_toolbar = abap_true.
  gs_layout-cwidth_opt = abap_true.
  ENDMETHOD.

  METHOD display_alv.
    IF go_alv IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_cont.

    gs_variant-report = sy-repid.
    gs_variant-variant = p_vari.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_structure_name     =
        is_variant      = gs_variant
        i_save          = 'A'
*       i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat
*       it_sort         = gt_sort
*       it_filter       = gt_filter
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error   = 2
*       too_many_lines  = 3
*       others          = 4
      .

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  ELSE.
    CALL METHOD go_alv->refresh_table_display( ).
  ENDIF.

  ENDMETHOD.

ENDCLASS.

*data go_main type ref to cl_event_receiver.
