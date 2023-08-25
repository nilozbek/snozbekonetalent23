*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE7_FRM
*&---------------------------------------------------------------------*
FORM display_alv .
  IF go_alv IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_cont.

    CREATE OBJECT go_event_receiver.
    SET HANDLER go_event_receiver->handle_buttonclick FOR go_alv.
    SET HANDLER go_event_receiver->handle_toolbar FOR go_alv.
    SET HANDLER go_event_receiver->handle_user_command FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.

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

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    <gfs_scarr>-delete = '@11@'. "çöp kutusu ikonunun kodu
  ENDLOOP.

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


  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'DELETE'.
  gs_fcat-scrtext_s = 'Sil'.
  gs_fcat-scrtext_m = 'Sil'.
  gs_fcat-scrtext_l = 'Sil'.
  gs_fcat-style = cl_gui_alv_grid=>mc_style_button.
  gs_fcat-icon = abap_true.  "ikon koyabilmek için
  APPEND gs_fcat TO gt_fcat.

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
