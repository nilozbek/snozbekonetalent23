*&---------------------------------------------------------------------*
*& Include zot_23_i_report_top
*&---------------------------------------------------------------------*

DATA:
      gv_ucomm  TYPE sy-ucomm,
      gv_okcode TYPE sy-ucomm.

DATA: "go_alv    TYPE REF TO cl_gui_alv_grid,
      go_cont   TYPE REF TO cl_gui_custom_container.


TYPES: BEGIN OF gty_sat,
       banfn TYPE banfn,
       bnfpo TYPE bnfpo,
       bsart TYPE bsart,
       matnr TYPE matnr,
       menge TYPE menge_d,
       meins TYPE meins,
       color(4),
       END OF gty_sat,

       BEGIN OF gty_sas,
       ebeln TYPE ebeln,
       ebelp TYPE ebelp,
       matnr TYPE matnr,
       menge TYPE menge_d,
       meins TYPE meins,
       color(4),
       END OF gty_sas.
