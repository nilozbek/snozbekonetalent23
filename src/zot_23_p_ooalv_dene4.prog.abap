*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE4.
INCLUDE zot_23_i_ooalv_dene4_top.
INCLUDE zot_23_i_ooalv_dene4_pbo.
INCLUDE zot_23_i_ooalv_dene4_pai.
INCLUDE zot_23_i_ooalv_dene4_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
