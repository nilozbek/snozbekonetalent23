*&---------------------------------------------------------------------*
*& Report ZOT_23_P_OOALV_DENE6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_P_OOALV_DENE6.

INCLUDE zot_23_i_ooalv_dene6_top.
INCLUDE zot_23_i_ooalv_dene6_cls.
INCLUDE zot_23_i_ooalv_dene6_pbo.
INCLUDE zot_23_i_ooalv_dene6_pai.
INCLUDE zot_23_i_ooalv_dene6_frm.


START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
