*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE5.

INCLUDE zot_23_i_ooalv_dene5_top.
INCLUDE zot_23_i_ooalv_dene5_pbo.
INCLUDE zot_23_i_ooalv_dene5_pai.
INCLUDE zot_23_i_ooalv_dene5_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
