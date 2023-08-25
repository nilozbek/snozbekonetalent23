*&---------------------------------------------------------------------*
*& Report zot_23_p_ooalv_dene1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_ooalv_dene1.

INCLUDE zot_23_i_ooalv_dene1_top.
INCLUDE zot_23_i_ooalv_dene1_pbo.
INCLUDE zot_23_i_ooalv_dene1_pai.
INCLUDE zot_23_i_ooalv_dene1_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.




  CALL SCREEN 0100.
