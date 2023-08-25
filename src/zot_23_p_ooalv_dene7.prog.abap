*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE7.
INCLUDE zot_23_i_ooalv_dene7_top.
INCLUDE zot_23_i_ooalv_dene7_cls.
INCLUDE zot_23_i_ooalv_dene7_pbo.
INCLUDE zot_23_i_ooalv_dene7_pai.
INCLUDE zot_23_i_ooalv_dene7_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
