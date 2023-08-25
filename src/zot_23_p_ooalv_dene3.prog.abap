*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE3.

INCLUDE zot_23_i_ooalv_dene3_top.
INCLUDE zot_23_i_ooalv_dene3_pbo.
INCLUDE zot_23_i_ooalv_dene3_pai.
INCLUDE zot_23_i_ooalv_dene3_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
