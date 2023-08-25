*&---------------------------------------------------------------------*
*& Include zot_23_i_kirilim_report_sel
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_sp_no FOR vbak-vbeln.
  SELECT-OPTIONS: s_sp_vrn for vbak-kunnr.
  SELECT-OPTIONS: s_sp_tur FOR vbak-auart.
  SELECT-OPTIONS: s_bl_trh FOR vbak-audat.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_malnum FOR vbap-matnr.
  SELECT-OPTIONS: s_urtmyr for vbap-werks.
  SELECT-OPTIONS: s_klmtip FOR vbap-pstyv.
  SELECT-OPTIONS: s_malgrb FOR vbap-matkl.
  SELECT-OPTIONS: s_parti FOR vbap-charg.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.

  PARAMETERS:
    p_sp_tur AS CHECKBOX,
    p_malnum AS CHECKBOX,
    p_sp_vrn AS CHECKBOX,
    p_malgrb AS CHECKBOX,
    p_parti  AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK b3.
