*&---------------------------------------------------------------------*
*& Include zot_23_i_kirilim_report_frm
*&---------------------------------------------------------------------*

FORM user_command USING p_ucomm TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.

  CASE p_ucomm.
    WHEN '&IC1'.

      CONCATENATE ps_selfield-fieldname ' EQ '  '''' ps_selfield-value '''' INTO DATA(lv_tab).
*       CONCATENATE ps_selfield-fieldname  'EQ'  ps_selfield-value INTO DATA(lv_tab) SEPARATED BY SPACE.
      IF ps_selfield-fieldname EQ 'NETWR' OR
         ps_selfield-fieldname EQ 'WAERK'.
      CONCATENATE 'vbap~' ps_selfield-fieldname ' EQ '  '''' ps_selfield-value '''' INTO lv_tab.
      ENDIF.
      SELECT vbak~vbeln,
               vbak~kunnr,
               vbak~bname,
               vbak~auart,
               vbak~audat,
               vbap~matnr,
               vbap~arktx,
               vbap~charg,
               vbap~meins,
               vbap~netwr,
               vbap~waerk,
               vbap~werks
               FROM vbak JOIN vbap ON vbak~vbeln = vbap~vbeln
               INTO TABLE @DATA(lt_new)
               WHERE (lv_tab).
*               WHERE vbap~WAERK = 'TRY'.

        cl_demo_output=>display( lt_new ).
*  CASE p_ucomm.
*
*    WHEN '&IC1'.
*      MESSAGE 'Çift tıklandı.' TYPE 'I'.
*
*      READ TABLE lt_main_t INTO ls_main_t INDEX ps_selfield-tabindex.
*
*      IF sy-subrc EQ 0.
*        PERFORM display_order_info USING ls_main_t.
*      ENDIF.
*
*  ENDCASE.

ENDCASE.
ENDFORM.

*FORM display_order_info USING p_main_t TYPE lty_main_t.


**  WRITE:  / 'VBELN:', p_main_t-vbeln,
**          / 'KUNNR:', p_main_t-kunnr,
**          / 'AUART:', p_main_t-auart,
**          / 'AUDAT:', p_main_t-audat,
**          / 'MATNR:', p_main_t-matnr,
**          / 'WERKS:', p_main_t-werks,
**          / 'PSTYV:', p_main_t-pstyv,
**          / 'MATKL:', p_main_t-matkl,
**          / 'NETWR:', p_main_t-netwr,
**          / 'WAERK:', p_main_t-waerk,
**          / 'CHARG:', p_main_t-charg.
*
*
*  cl_demo_output=>write( |VBELN: { p_main_t-vbeln }| ).
*  cl_demo_output=>write( |KUNNR: { p_main_t-kunnr }| ).
*  cl_demo_output=>write( |AUART: { p_main_t-auart }| ).
*  cl_demo_output=>write( |AUDAT: { p_main_t-audat }| ).
*  cl_demo_output=>write( |MATNR: { p_main_t-matnr }| ).
*  cl_demo_output=>write( |WERKS: { p_main_t-werks }| ).
*  cl_demo_output=>write( |PSTYV: { p_main_t-pstyv }| ).
*  cl_demo_output=>write( |MATKL: { p_main_t-matkl }| ).
*  cl_demo_output=>write( |NETWR: { p_main_t-netwr }| ).
*  cl_demo_output=>write( |WAERK: { p_main_t-waerk }| ).
*  cl_demo_output=>write( |CHARG: { p_main_t-charg }| ).
*
*  cl_demo_output=>display(  ).






*ENDFORM.
