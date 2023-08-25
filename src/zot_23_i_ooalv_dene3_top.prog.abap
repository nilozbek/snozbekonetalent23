*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE3_TOP
*&---------------------------------------------------------------------*
DATA: go_alv TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_scarr,
       CARRID TYPE  S_CARR_ID,
       CARRNAME TYPE  S_CARRNAME,
       CURRCODE TYPE  S_CURRCODE,
       URL  TYPE  S_CARRURL,
       MESS TYPE char200,
       LINE_COLOR TYPE CHAR4,
       cost TYPE int4,
       cell_color TYPE lvc_t_scol,
       location TYPE char20,
       seatl TYPE char1,
       seatp TYPE char20,
       dd_handle TYPE int4,
       END OF gty_scarr.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_scarr TYPE TABLE OF gty_scarr,
      gs_scarr TYPE gty_scarr,
      gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_fc> TYPE lvc_s_fcat,
               <gfs_scarr> TYPE gty_scarr.
