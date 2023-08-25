*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE2.
INCLUDE zot_23_i_ooalv_dene2_top.
INCLUDE zot_23_i_ooalv_dene2_pbo.
INCLUDE zot_23_i_ooalv_dene2_pai.
INCLUDE zot_23_i_ooalv_dene2_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
