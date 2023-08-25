*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE9_FRM
*&---------------------------------------------------------------------*
FORM display_alv .
  IF go_alv IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_cont.

*    CREATE OBJECT go_event_receiver.
*    SET HANDLER go_event_receiver->handle_buttonclick FOR go_alv.
*    SET HANDLER go_event_receiver->handle_toolbar FOR go_alv.
*    SET HANDLER go_event_receiver->handle_user_command FOR go_alv.

*    PERFORM set_excluding.
*    PERFORM set_sort.
*    PERFORM set_filter.
    gs_variant-report = sy-repid.
    gs_variant-variant = p_vari.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer   =
*       i_consistency_check  =
*       i_structure_name     =
        is_variant      = gs_variant
        i_save          = 'A'
*       i_default       = 'X'
        is_layout       = gs_layout
*       is_print        =
*       it_special_groups    =
*       it_toolbar_excluding = gt_excluding
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
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
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  ELSE.
    CALL METHOD go_alv->refresh_table_display( ).
  ENDIF.


ENDFORM.


*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    <gfs_scarr>-delete = '@11@'. "çöp kutusu ikonunun kodu
*  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat .
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SCARR'
    CHANGING
      ct_fieldcat      = gt_fcat.


*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'DELETE'.
*  gs_fcat-scrtext_s = 'Sil'.
*  gs_fcat-scrtext_m = 'Sil'.
*  gs_fcat-scrtext_l = 'Sil'.
*  gs_fcat-style = cl_gui_alv_grid=>mc_style_button.
*  gs_fcat-icon = abap_true.  "ikon koyabilmek için
*  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
*  gs_layout-no_toolbar = abap_true.
  gs_layout-cwidth_opt = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_excluding
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM set_excluding .
*  CLEAR: gs_excluding.
*  gs_excluding = cl_gui_alv_grid=>mc_fc_detail.  "baştaki(en soldaki) ayrıntı butonunu toolbardan kaldırdı.
*  APPEND gs_excluding TO gt_excluding.
*
*   CLEAR: gs_excluding.
*  gs_excluding = cl_gui_alv_grid=>mc_fc_find. "find butonunu kaldırır
*  APPEND gs_excluding TO gt_excluding.
*
*   CLEAR: gs_excluding.
*  gs_excluding = cl_gui_alv_grid=>mc_fc_sort_asc.  "artarak sort eden butonu kaldırır
*  APPEND gs_excluding TO gt_excluding.
*
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM set_sort .
*  CLEAR: gs_sort.
*  gs_sort-spos = 1.
*  gs_sort-fieldname = 'CURRCODE'.
*  gs_sort-down = abap_true.
*  APPEND gs_sort TO gt_sort.
*ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_filter
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM set_filter .
*CLEAR: gs_filter.
*
*gs_filter-tabname = 'GT_SCARR'.
*gs_filter-fieldname = 'CURRCODE'.
*gs_filter-sign = 'I'.   "include
*gs_filter-option = 'EQ'.   "equal
*gs_filter-low = 'USD'.  "sadece ekrana usd olan dataları getirir.
**gs_filter-high =
*APPEND gs_filter TO gt_filter.
*ENDFORM.
