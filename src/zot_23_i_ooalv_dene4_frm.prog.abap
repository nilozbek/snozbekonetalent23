*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE4_FRM
*&---------------------------------------------------------------------*
  FORM display_alv .

    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'OO_ALV4'.


    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_cont.


    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer            =
*       i_consistency_check           =
*       i_structure_name = 'ZDENEME_NIL_ST'
*       is_variant      =
*       i_save          =
*       i_default       = 'X'
        is_layout       = gs_layout
*       is_print        =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat
*       it_sort         =
*       it_filter       =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error   = 2
*       too_many_lines  = 3
*       others          = 4
      .

  ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM get_data .

    DATA: lv_numc   TYPE n LENGTH 8,
          lv_numc_c TYPE char8.


    SELECT * FROM scarr
        INTO CORRESPONDING FIELDS OF TABLE gt_scarr.
    "KOLONLARI DOLDURMAK İÇİN LOOP KULLANIYORUZ
*    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*      IF <gfs_scarr>-currcode <> 'EUR'.  " <> bu eşit değil demek
*         CLEAR: gs_cellstyle.
*         gs_cellstyle-fieldname = 'URL'.
*         gs_cellstyle-style = cl_gui_alv_grid=>mc_style_disabled.
*         APPEND gs_cellstyle TO <gfs_scarr>-cellstyle.
*
*        ENDIF.
*      ENDLOOP.

    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
      lv_numc = lv_numc_c + 1.
      lv_numc_c = lv_numc.

      gs_cellstyle-fieldname = 'URL'.
      gs_cellstyle-style = lv_numc_c.

      APPEND gs_cellstyle TO <gfs_scarr>-cellstyle.

      <gfs_scarr>-styleval = lv_numc_c.
    ENDLOOP.

  ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM set_fcat .

    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CARRID'.
    gs_fcat-scrtext_s = 'Havayolu T.'.
    gs_fcat-scrtext_m = 'Havayolu tanımı'.
    gs_fcat-scrtext_l = 'Hava yolu kısa tanımı'.
    APPEND gs_fcat TO gt_fcat.

    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CARRNAME'.
    gs_fcat-scrtext_s = 'Havayolu Ş. ad'.
    gs_fcat-scrtext_m = 'Havayolu şirket. adı'.
    gs_fcat-scrtext_l = 'Havayolu şirketinin adı'.
    APPEND gs_fcat TO gt_fcat.

    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'CURRCODE'.
    gs_fcat-scrtext_s = 'Havayolu para b.'.
    gs_fcat-scrtext_m = 'Havayolu şirketinin para birimi'.
    gs_fcat-scrtext_l = 'Havayolu şirketinin ulusal para birimi'.
    APPEND gs_fcat TO gt_fcat.

    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'URL'.
    gs_fcat-scrtext_s = 'URLsi'.
    gs_fcat-scrtext_m = 'Havayolu şirket. URLsi'.
    gs_fcat-scrtext_l = 'Havayolu şirketinin URLsi'.
*  gs_fcat-edit = abap_true.
    APPEND gs_fcat TO gt_fcat.

    CLEAR: gs_fcat.
    gs_fcat-fieldname = 'STYLEVAL'.
    gs_fcat-scrtext_s = 'Style'.
    gs_fcat-scrtext_m = 'Style'.
    gs_fcat-scrtext_l = 'Style'.
    APPEND gs_fcat TO gt_fcat.

  ENDFORM.

*&---------------------------------------------------------------------*
*& Form set_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM set_layout .
    CLEAR: gs_layout.
    gs_layout-cwidth_opt = abap_true. "sütunları ayarlar
    gs_layout-no_toolbar = abap_true. "üstteki butonları kaldırır
    gs_layout-stylefname = 'CELLSTYLE'.
  ENDFORM.
