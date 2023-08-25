*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE8.
INCLUDE zot_23_i_ooalv_dene8_top.
INCLUDE zot_23_i_ooalv_dene8_cls.
INCLUDE zot_23_i_ooalv_dene8_pbo.
INCLUDE zot_23_i_ooalv_dene8_pai.
INCLUDE zot_23_i_ooalv_dene8_frm.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
