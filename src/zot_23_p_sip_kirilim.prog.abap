*&---------------------------------------------------------------------*
*& Report zot_23_p_sip_kirilim
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_sip_kirilim.

INCLUDE zot_23_i_kirilim_report_top.
INCLUDE zot_23_i_kirilim_report_sel.
INCLUDE zot_23_i_kirilim_report_frm.

START-OF-SELECTION.

SELECT
        vbak~vbeln,
        vbak~kunnr,
        vbak~auart,
        vbak~audat,
        vbap~matnr,
        vbap~werks,
        vbap~pstyv,
        vbap~matkl,
        vbap~charg,
        vbap~netwr,
        vbap~waerk

        FROM vbak INNER JOIN vbap ON vbak~vbeln = vbap~vbeln
        INTO TABLE @lt_main_t
        WHERE vbak~vbeln IN @s_sp_no   "vbeln
         AND vbak~kunnr IN @s_sp_vrn   "kunnr
         AND  vbak~auart IN @s_sp_tur  "auart
         AND vbak~audat IN @s_bl_trh   "audat
         AND vbap~matnr IN @s_malnum   "matnr
         AND vbap~werks IN @s_urtmyr   "werks
         AND vbap~pstyv IN @s_klmtip   "pstyv
         AND vbap~matkl IN @s_malgrb   "matkl
         AND vbap~charg IN @s_parti.   "charg

IF p_sp_tur = abap_true.
CLEAR: gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'AUART'.
gs_fieldcatolog-seltext_s = 'Sipariş Tür'.
gs_fieldcatolog-seltext_m = 'Sipariş Türü'.
gs_fieldcatolog-seltext_l = 'Sipariş Türü'.
"gs_fieldcatolog-hotspot = abap_true.  "kullanmadım frm da double click yaptım
APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDIF.

IF p_malnum = abap_true.
CLEAR: gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'MATNR'.
gs_fieldcatolog-seltext_s = 'Malzeme No'.
gs_fieldcatolog-seltext_m = 'Sipariş Numarası'.
gs_fieldcatolog-seltext_l = 'Sipariş Numarası'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDIF.

IF p_sp_vrn = abap_true.
CLEAR: gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'KUNNR'.
gs_fieldcatolog-seltext_s = 'Sipariş Veren'.
gs_fieldcatolog-seltext_m = 'Sipariş Veren'.
gs_fieldcatolog-seltext_l = 'Sipariş Veren'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDIF.

IF p_malgrb = abap_true.
CLEAR: gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'MATKL'.
gs_fieldcatolog-seltext_s = 'Mal Grubu'.
gs_fieldcatolog-seltext_m = 'Mal Grubu'.
gs_fieldcatolog-seltext_l = 'Mal Grubu'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDIF.

IF p_parti = abap_true.
CLEAR: gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'CHARG'.
gs_fieldcatolog-seltext_s = 'Parti'.
gs_fieldcatolog-seltext_m = 'Parti'.
gs_fieldcatolog-seltext_l = 'Parti'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDIF.

CLEAR gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'NETWR'.
gs_fieldcatolog-seltext_s = 'Net Değer'.
gs_fieldcatolog-do_sum = 'X'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.

CLEAR gs_fieldcatolog.
gs_fieldcatolog-fieldname = 'WAERK'.
gs_fieldcatolog-seltext_s = 'Para Birimi'.
"gs_fieldcatolog-hotspot = abap_true.
APPEND gs_fieldcatolog TO gt_fieldcatolog.

""""""""""""""""""""""""""""""""""""""""""
DATA(flag1) = 0.
DATA(flag2) = 0.
DATA(flag3) = 0.
DATA(flag4) = 0.
DATA(flag5) = 0.

DATA(counter) = 0.

IF p_sp_tur = abap_true.
counter += 1.
flag1 += 1.

CLEAR gs_sort.
gs_sort-fieldname = 'AUART'.
gs_sort-up = 'X'.
gs_sort-subtot = 'X'.
APPEND gs_sort TO gt_sort.
ENDIF.

IF p_malnum = abap_true.
counter += 1.
flag2 += 1.

CLEAR gs_sort.
gs_sort-fieldname = 'MATNR'.
gs_sort-up = 'X'.
gs_sort-subtot = 'X'.
APPEND gs_sort TO gt_sort.
ENDIF.

IF p_sp_vrn = abap_true.
counter += 1.
flag3 += 1.

CLEAR gs_sort.
gs_sort-fieldname = 'KUNNR'.
gs_sort-up = 'X'.
gs_sort-subtot = 'X'.
APPEND gs_sort TO gt_sort.
ENDIF.

IF p_malgrb = abap_true.
counter += 1.
flag4 += 1.

CLEAR gs_sort.
gs_sort-fieldname = 'MATKL'.
gs_sort-up = 'X'.
gs_sort-subtot = 'X'.
APPEND gs_sort TO gt_sort.
ENDIF.

IF p_parti = abap_true.
counter += 1.
flag5 += 1.

CLEAR gs_sort.
gs_sort-fieldname = 'CHARG'.
gs_sort-up = 'X'.
gs_sort-subtot = 'X'.
APPEND gs_sort TO gt_sort.
ENDIF.

IF counter NE 2 .
   MESSAGE 'Please select 2 selections!' TYPE 'E'.
  ENDIF.
""""""""""""""""""""""""""""""""""""""""""""""""""

gs_layout-window_titlebar = 'Müşteri Sipariş Kırılım Raporu'.
gs_layout-zebra = abap_true.


""""""""""""""""""""""""""""""""""""""""""""""""""""""
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = sy-repid
*   I_CALLBACK_PF_STATUS_SET          = ' '
   I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
   IS_LAYOUT                         = gs_layout
   IT_FIELDCAT                       = gt_fieldcatolog
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
   IT_SORT                           = gt_sort
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         = lt_events
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
*   O_PREVIOUS_SRAL_HANDLER           =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = lt_main_t
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
