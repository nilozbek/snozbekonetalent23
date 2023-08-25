*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE7_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF gty_scarr,
         delete   TYPE char10,
         carrid   TYPE  s_carr_id,
         carrname TYPE  s_carrname,
         currcode TYPE  s_currcode,
         url      TYPE  s_carrurl,
       END OF gty_scarr.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

DATA: gt_scarr  TYPE TABLE OF gty_scarr,
      gs_scarr  TYPE gty_scarr,
      gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_scarr> TYPE gty_scarr.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA go_event_receiver TYPE REF TO cl_event_receiver.
