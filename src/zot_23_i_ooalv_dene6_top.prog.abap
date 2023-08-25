*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE6_TOP
*&---------------------------------------------------------------------*
  DATA: go_grid TYPE REF TO cl_gui_alv_grid,
        go_cust TYPE REF TO cl_gui_custom_container.


  DATA: gt_scarr  TYPE TABLE OF scarr,
        gs_scarr  TYPE scarr,
        gt_fcat   TYPE lvc_t_fcat,
        gs_fcat   TYPE lvc_s_fcat,
        gs_layout TYPE lvc_s_layo.

  CLASS cl_event_receiver DEFINITION DEFERRED.  "cls Include un altta veya üstte olmasından etkilenmez class ı görür

  DATA: go_spli TYPE REF TO cl_gui_splitter_container,
        go_sub1 TYPE REF TO cl_gui_container,
        go_sub2 TYPE REF TO cl_gui_container.

  DATA: go_event_receiver TYPE REF TO cl_event_receiver.

  DATA: go_docu TYPE REF TO cl_dd_document.

  FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat,
                 <gfs_scarr> TYPE scarr.
