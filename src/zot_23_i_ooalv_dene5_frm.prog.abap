*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE5_FRM
*&---------------------------------------------------------------------*
FORM display_alv .

  CREATE OBJECT go_cust
    EXPORTING
      container_name = 'OO_ALV5'.

  CREATE OBJECT go_splitter
    EXPORTING
      parent  = go_cust
      rows    = 1             "kaça bölmeye çalışıyorsak burada belirtiyoruz.
      columns = 2.    "rows u 2 yapmsaydık u sefer alt alta duran containerlar şeklinde duracaktı

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1
      column    = 1
    RECEIVING
      container = go_gui1.

  CALL METHOD go_splitter->get_container
    EXPORTING
      row       = 1              "row= 2 ve column=2 deseydik sağ alt köşede bastıracaktı
      column    = 2
    RECEIVING
      container = go_gui2.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_gui1.

  CREATE OBJECT go_alv2
    EXPORTING
      i_parent = go_gui2.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_scarr
      it_fieldcatalog = gt_fcat.

  CALL METHOD go_alv2->set_table_for_first_display
    EXPORTING
      is_layout       = gs_layout
    CHANGING
      it_outtab       = gt_sflight
      it_fieldcatalog = gt_fcat2.


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

  SELECT * FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_sflight.

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

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      ct_fieldcat      = gt_fcat2.
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
  gs_layout-no_toolbar = abap_true.
  gs_layout-cwidth_opt = abap_true.
ENDFORM.
