*&---------------------------------------------------------------------*
*& Include zot_23_i_report_top
*&---------------------------------------------------------------------*

*DATA: go_alv    TYPE REF TO cl_salv_table,
*      gv_ucomm  TYPE sy-ucomm,
*      gv_okcode TYPE sy-ucomm.

DATA: go_alv    TYPE REF TO cl_gui_alv_grid,
      go_cont   TYPE REF TO cl_gui_custom_container.
