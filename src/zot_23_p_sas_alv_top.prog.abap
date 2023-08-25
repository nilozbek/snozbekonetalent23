*&---------------------------------------------------------------------*
*& Include          ZOT_23_P_SAS_ALV_TOP
*&---------------------------------------------------------------------*
TABLES :vbrk, ekko, werks, lgort.

TYPES: BEGIN OF gty_tutar,
         netpr TYPE netpr,
       END OF gty_tutar.

DATA: gt_tutar TYPE TABLE OF gty_tutar,
      gs_tutar TYPE gty_tutar.

CLASS cl_event_receiver DEFINITION DEFERRED.

DATA: go_event_receiver TYPE REF TO cl_event_receiver.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_alv2 TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

DATA: go_splitter TYPE REF TO cl_gui_splitter_container,
      go_gui1     TYPE REF TO cl_gui_container,
      go_gui2     TYPE REF TO cl_gui_container.

DATA: gs_layout   TYPE lvc_s_layo,
      gt_fcat     TYPE lvc_t_fcat,
      gt_fcat2    TYPE lvc_t_fcat,
      gs_fcat     TYPE lvc_s_fcat,
      gs_fcat2    TYPE lvc_s_fcat,
      gt_fcat_pop TYPE slis_t_fieldcat_alv.

DATA: gt_main1 TYPE TABLE OF zot_23_s_sas_main1,
      gs_main1 TYPE zot_23_s_sas_main1.

DATA: gt_main2 TYPE TABLE OF zot_23_s_sas_main2,
      gs_main2 TYPE zot_23_s_sas_main2.

SELECT-OPTIONS: s_vbeln FOR vbrk-vbeln,
                s_fkdat FOR vbrk-fkdat,
                s_fkart FOR vbrk-fkart,
                s_kunrg FOR vbrk-kunrg.

*SELECT-OPTIONS: s_ekorg FOR ekko-ekorg,
*                s_ekgrp FOR ekko-ekgrp,
*                s_werks FOR werks-werks,  "WERKS_D
*                s_lgort FOR lgort-lgort.

FIELD-SYMBOLS: <gfs_fcat2> TYPE lvc_s_fcat.

DATA: gt_log TYPE TABLE OF zot_23_t_log,
      gs_log TYPE zot_23_t_log.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_log_pop TYPE TABLE OF zot_23_t_log,
      gs_log_pop TYPE zot_23_t_log.
