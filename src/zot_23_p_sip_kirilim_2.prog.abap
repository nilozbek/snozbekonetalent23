*&---------------------------------------------------------------------*
*& Report zot_23_p_sip_kirilim_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_sip_kirilim_2.

*alv siz denedim fakat time out veriyo dumpa düşüyo!! ÇALIŞAN HALİ İLK PROGRAMDA

*TABLES: vbak, vbap.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  SELECT-OPTIONS: s_sp_no FOR vbak-vbeln.
*  SELECT-OPTIONS: s_sp_vrn for vbak-kunnr.
*  SELECT-OPTIONS: s_sp_tur FOR vbak-auart.
*  SELECT-OPTIONS: s_bl_trh FOR vbak-audat.
*SELECTION-SCREEN END OF BLOCK b1.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
*  SELECT-OPTIONS: s_malnum FOR vbap-matnr.
*  SELECT-OPTIONS: s_urtmyr for vbap-werks.
*  SELECT-OPTIONS: s_klmtip FOR vbap-pstyv.
*  SELECT-OPTIONS: s_malgrb FOR vbap-matkl.
*  SELECT-OPTIONS: s_parti FOR vbap-charg.
*SELECTION-SCREEN END OF BLOCK b2.
*
*SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
*
*  PARAMETERS:
*    p_sp_tur AS CHECKBOX,
*    p_malnum AS CHECKBOX,
*    p_sp_vrn AS CHECKBOX,
*    p_malgrb AS CHECKBOX,
*    p_parti  AS CHECKBOX.
*
*SELECTION-SCREEN END OF BLOCK b3.
*"""""""""""""""""""""""""""""""""""""""""""""
*START-OF-SELECTION.
*
*DATA(flag1) = 0.
*DATA(flag2) = 0.
*DATA(flag3) = 0.
*DATA(flag4) = 0.
*DATA(flag5) = 0.
*
*DATA(counter) = 0.
*
*IF p_sp_tur = 'X'.
*counter += 1.
*flag1 += 1.
*ENDIF.
*
*IF p_malnum = 'X'.
*counter += 1.
*flag2 += 1.
*ENDIF.
*
*IF p_sp_vrn = 'X'.
*counter += 1.
*flag3 += 1.
*ENDIF.
*
*IF p_malgrb = 'X'.
*counter += 1.
*flag4 += 1.
*ENDIF.
*
*IF p_parti = 'X'.
*counter += 1.
*flag5 += 1.
*ENDIF.
*
*IF counter NE 2 .
*    WRITE:/ 'Please select 2 selections!'.
*  ENDIF.
*""""""""""""""""""""""""""""""""""""""""""""""
*TYPES: BEGIN OF lty_main_t,
*       vbeln TYPE VBELN_VA,
*       kunnr TYPE KUNAG,
*       auart TYPE auart,
*       audat TYPE audat,
*       matnr TYPE matnr,
*       werks TYPE WERKS_EXT,
*       pstyv TYPE pstyv,
*       matkl TYPE matkl,
*       charg TYPE CHARG_D,
*       netwr TYPE netwr,
*       waerk TYPE waerk,
*      " color(4),
*       END OF lty_main_t.
*
*DATA:  lt_main_t TYPE TABLE OF lty_main_t,
*       ls_main_t TYPE lty_main_t,
*       lt_collection TYPE TABLE OF lty_main_t,
*       ls_collection TYPE lty_main_t.
*
*SELECT
*        vbak~vbeln,
*        vbak~kunnr,
*        vbak~auart,
*        vbak~audat,
*        vbap~matnr,
*        vbap~werks,
*        vbap~pstyv,
*        vbap~matkl,
*        vbap~charg,
*        vbap~netwr,
*        vbap~waerk
*
*        FROM vbak INNER JOIN vbap ON vbak~vbeln = vbap~vbeln
*        INTO TABLE @lt_main_t
*        WHERE vbak~vbeln IN @s_sp_no   "vbeln
*         AND vbak~kunnr IN @s_sp_vrn   "kunnr
*         AND  vbak~auart IN @s_sp_tur  "auart
*         AND vbak~audat IN @s_bl_trh   "audat
*         AND vbap~matnr IN @s_malnum   "matnr
*         AND vbap~werks IN @s_urtmyr   "werks
*         AND vbap~pstyv IN @s_klmtip   "pstyv
*         AND vbap~matkl IN @s_malgrb   "matkl
*         AND vbap~charg IN @s_parti.   "charg
*
*SORT lt_main_t BY vbeln ASCENDING.
*
*DATA: lt_output TYPE TABLE OF lty_main_t.
*
*LOOP AT lt_main_t INTO ls_main_t.
*
*CASE counter.
*WHEN 2.
*
*    IF flag1 EQ 1.  "p_sp_tur , SİPARİŞ TÜRÜ
*
*    MOVE-CORRESPONDING ls_main_t TO ls_collection.
*        APPEND ls_collection TO lt_collection.
*        CLEAR ls_collection.
*        ls_collection-vbeln = ls_main_t-auart.
*
*    ENDIF.
*
*    IF flag2 EQ 1.  "p_malnum , MALZEME NUMARASI
*
*    MOVE-CORRESPONDING ls_main_t TO ls_collection.
*        APPEND ls_collection TO lt_collection.
*        CLEAR ls_collection.
*        ls_collection-vbeln = ls_main_t-matnr.
*
*    ENDIF.
*
*    IF flag3 EQ 1. "p_sp_vrn , SİPARİŞ VEREN
*
*    MOVE-CORRESPONDING ls_main_t TO ls_collection.
*        APPEND ls_collection TO lt_collection.
*        CLEAR ls_collection.
*        ls_collection-vbeln = ls_main_t-kunnr.
*
*    ENDIF.
*
*    IF flag4 EQ 1.  "p_malgrb , MAL GRUBU
*
*    MOVE-CORRESPONDING ls_main_t TO ls_collection.
*        APPEND ls_collection TO lt_collection.
*        CLEAR ls_collection.
*        ls_collection-vbeln = ls_main_t-matkl.
*
*    ENDIF.
*
*    IF flag5 EQ 1.  "p_parti , PARTİ
*
*    MOVE-CORRESPONDING ls_main_t TO ls_collection.
*        APPEND ls_collection TO lt_collection.
*        CLEAR ls_collection.
*        ls_collection-vbeln = ls_main_t-charg.
*
*    ENDIF.
*
*    LOOP AT lt_collection INTO ls_collection.
*
*    CLEAR: ls_collection-netwr,
*           ls_collection-waerk.
*
*        LOOP AT lt_main_t INTO ls_main_t
*        WHERE ( vbeln = ls_collection-vbeln ).
*
*        ls_collection-netwr = ls_collection-netwr + ls_main_t-netwr.
*        ls_collection-waerk = ls_main_t-waerk.
*
*        ENDLOOP.
*
**         APPEND ls_collection TO lt_output.
*        COLLECT ls_collection INTO lt_output.
*
*    ENDLOOP.
*
*ENDCASE.
*ENDLOOP.
*
*cl_demo_output=>display( lt_output ).
