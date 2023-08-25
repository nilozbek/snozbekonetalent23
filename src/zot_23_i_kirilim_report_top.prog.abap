*&---------------------------------------------------------------------*
*& Include zot_23_i_kirilim_report_top
*&---------------------------------------------------------------------*

TABLES: vbak, vbap.

TYPES: BEGIN OF lty_main_t,
       vbeln TYPE VBELN_VA,
       kunnr TYPE KUNAG,
       auart TYPE auart,
       audat TYPE audat,
       matnr TYPE matnr,
       werks TYPE WERKS_EXT,
       pstyv TYPE pstyv,
       matkl TYPE matkl,
       charg TYPE CHARG_D,
       netwr TYPE netwr,
       waerk TYPE waerk,
      " color(4),
       END OF lty_main_t.

DATA:  lt_main_t TYPE TABLE OF lty_main_t,
       ls_main_t TYPE lty_main_t,
       lt_collection TYPE TABLE OF lty_main_t,
       ls_collection TYPE lty_main_t.

DATA: gs_fieldcatolog TYPE slis_fieldcat_alv,
      gt_fieldcatolog TYPE slis_t_fieldcat_alv,
      gs_sort TYPE slis_sortinfo_alv,
      gt_sort TYPE slis_t_sortinfo_alv.


DATA: gs_layout TYPE slis_layout_alv.

DATA: lt_events TYPE TABLE OF slis_t_event,
      ls_events TYPE slis_alv_event.
