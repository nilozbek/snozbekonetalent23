*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE3_FRM
*&---------------------------------------------------------------------*
FORM display_alv .

  CREATE OBJECT go_cont
    EXPORTING
      container_name = 'OO_ALV3'.


  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_cont.

  PERFORM set_dropdown.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
*     i_buffer_active  =
*     i_bypassing_buffer            =
*     i_consistency_check           =
      i_structure_name = 'ZDENEME_NIL_ST'
*     is_variant       =
*     i_save           =
*     i_default        = 'X'
      is_layout        = gs_layout
*     is_print         =
*     it_special_groups             =
*     it_toolbar_excluding          =
*     it_hyperlink     =
*     it_alv_graphics  =
*     it_except_qinfo  =
*     ir_salv_adapter  =
    CHANGING
      it_outtab        = gt_scarr
      it_fieldcatalog  = gt_fcat
*     it_sort          =
*     it_filter        =
*  EXCEPTIONS
*     invalid_parameter_combination = 1
*     program_error    = 2
*     too_many_lines   = 3
*     others           = 4
    .

  CALL METHOD go_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter.

  CALL METHOD go_alv->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.


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
  SELECT * FROM scarr
      INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    CASE <gfs_scarr>-currcode.
      WHEN 'EUR'.
        <gfs_scarr>-dd_handle = 3.
      WHEN 'USD'.
        <gfs_scarr>-dd_handle = 4.
      WHEN 'JPY'.
        <gfs_scarr>-dd_handle = 5.

    ENDCASE.
  ENDLOOP.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    CASE <gfs_scarr>-currcode.
      WHEN 'USD'.
        <gfs_scarr>-line_color = 'C710'.
      WHEN 'EUR'.
        CLEAR: gs_cell_color.
        gs_cell_color-fname = 'URL'.
        gs_cell_color-color-col = '3'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO <gfs_scarr>-cell_color.
    ENDCASE.
  ENDLOOP.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
**
*  IF <gfs_scarr>-currcode = 'EUR'.
*      <gfs_scarr>- = abap_true.
*  ENDIF.
*
*  ENDLOOP.

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
*
*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name       = 'ZDENEME_NIL_ST'
**     i_structure_name       = 'ZOT_23_S_OOALV_DENE2' "structure oluştrumadım bu programda kullanacaksan oluştur.
**     I_INTERNAL_TABNAME     =
*    CHANGING
*      ct_fieldcat            = gt_fcat
*    EXCEPTIONS
*      inconsistent_interface = 1
*      program_error          = 2
*      OTHERS                 = 3.
*
  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-scrtext_s = 'Havayolu T.'.
  gs_fcat-scrtext_m = 'Havayolu tanımı'.
  gs_fcat-scrtext_l = 'Hava yolu kısa tanımı'.
*  gs_fcat-col_pos = 2.        "kaçıncı sütunda olucak onu ayarlar
  gs_fcat-key = abap_true.  "daha farklı bir renkte gösterir tabloda
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CARRNAME'.
  gs_fcat-scrtext_s = 'Havayolu Ş. ad'.
  gs_fcat-scrtext_m = 'Havayolu şirket. adı'.
  gs_fcat-scrtext_l = 'Havayolu şirketinin adı'.
*  gs_fcat-col_pos = 3.
  gs_fcat-edit = abap_true. " sütunu editlenebilir yani güncellenebilir şekilde gösterir
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'CURRCODE'.
  gs_fcat-scrtext_s = 'Havayolu para b.'.
  gs_fcat-scrtext_m = 'Havayolu şirketinin para birimi'.
  gs_fcat-scrtext_l = 'Havayolu şirketinin ulusal para birimi'.
*  gs_fcat-col_pos = 4.
  gs_fcat-hotspot = abap_true.  "tıklanabilirliği sağlıyor
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'URL'.
  gs_fcat-scrtext_s = 'URLsi'.
  gs_fcat-scrtext_m = 'Havayolu şirket. URLsi'.
  gs_fcat-scrtext_l = 'Havayolu şirketinin URLsi'.
*  gs_fcat-col_pos = 1.
  gs_fcat-col_opt = abap_true.   "satırın uygun uzunlukta gösterilmesini sağlar
*  gs_fcat-no_out = abap_true.  "tabloda göstermez
  gs_fcat-outputlen = 100.    "ekranda kaç karakter gözükmesini istiyorsan onu ayarlar
  APPEND gs_fcat TO gt_fcat.
*  "bu yukardakileri yapmak yerine ref kullanabilirdik
*
**  gs_fcat-ref_table = 'SCARR'.
**  gs_fcat-ref_field = 'URL'.
*  APPEND gs_fcat TO gt_fcat.
*ENDFORM.



*  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'MESS'.
*
*  IF sy-subrc = 0.
*    <gfs_fc>-edit = abap_true.
*  ENDIF.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'COST'.
  gs_fcat-scrtext_s = 'Tutar'.
  gs_fcat-scrtext_m = 'Tutar'.
  gs_fcat-scrtext_l = 'Tutar'.
  gs_fcat-edit = abap_true. " sütunu editlenebilir yani güncellenebilir şekilde gösterir
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'LOCATION'.
  gs_fcat-scrtext_s = 'Lokasyon'.
  gs_fcat-scrtext_m = 'Lokasyon'.
  gs_fcat-scrtext_l = 'Lokasyon'.
  gs_fcat-edit = abap_true. " sütunu editlenebilir yani güncellenebilir şekilde gösterir
  gs_fcat-drdn_hndl = 1.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'SEATL'.
  gs_fcat-scrtext_s = 'Koltuk Harf'.
  gs_fcat-scrtext_m = 'Koltuk Harf'.
  gs_fcat-scrtext_l = 'Koltuk Harf'.
  gs_fcat-edit = abap_true. " sütunu editlenebilir yani güncellenebilir şekilde gösterir
  gs_fcat-drdn_hndl = 2.
  APPEND gs_fcat TO gt_fcat.

  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'SEATP'.
  gs_fcat-scrtext_s = 'Koltuk Pos.'.
  gs_fcat-scrtext_m = 'Koltuk Pos.'.
  gs_fcat-scrtext_l = 'Koltuk Pos.'.
  gs_fcat-edit = abap_true. " sütunu editlenebilir yani güncellenebilir şekilde gösterir
  gs_fcat-drdn_field = 'DD_HANDLE'.
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
*gs_layout-edit = abap_true.
  gs_layout-no_toolbar = abap_true. "üstteki butonları kaldırır
  gs_layout-zebra = abap_true.
  gs_layout-info_fname = 'LINE_COLOR'.
  gs_layout-ctab_fname = 'CELL_COLOR'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_dropdown
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtiçi'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtdışı'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'A'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'B'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'C'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 5.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown TO lt_dropdown.

  go_alv->set_drop_down_table(
    EXPORTING
      it_drop_down = lt_dropdown
  ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_total_sum
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_total_sum .
  DATA: lv_ttl_sum   TYPE int4,
        lv_ttl_sum_c TYPE char10,
        lv_mess      TYPE char200.

  LOOP AT gt_scarr INTO gs_scarr.
    lv_ttl_sum = lv_ttl_sum + gs_scarr-cost.
  ENDLOOP.

  lv_ttl_sum_c = lv_ttl_sum.  "c char olarak yaptığım için yazdım. bunu karakter tipine eşitliyoruz yoksa message(mess) kısmında hata veriyo karakter tipinde istediği için

  CONCATENATE 'Tüm satırların toplamı ='
              lv_ttl_sum_c
              INTO lv_mess.

  MESSAGE lv_mess TYPE 'I'.

ENDFORM.
