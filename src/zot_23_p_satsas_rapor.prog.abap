*&---------------------------------------------------------------------*
*& Report zot_23_p_satsas_rapor
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_satsas_rapor.

TABLES: eban,
        ekpo.
*
*INCLUDE zot_23_i_report_top.
*INCLUDE zot_23_i_report_sel.
*INCLUDE zot_23_i_report_cls.
*INCLUDE zot_23_i_report_mdl.
*
*"SAT -> BANFN
*"SAS -> BNFPO
*INITIALIZATION.
*  go_main = lcl_main_controller=>get_instance( ).
*
*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS:  s_banfn FOR eban-banfn,
                   s_bnfpo FOR eban-bnfpo.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_banfn2 FOR ekpo-banfn,
                  s_bnfpo2 FOR ekpo-bnfpo.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  PARAMETERS: p_sat  TYPE char1 RADIOBUTTON GROUP gr1,
              p_sas TYPE char1 RADIOBUTTON GROUP gr1.

SELECTION-SCREEN END OF BLOCK b3.


*INCLUDE zot_23_i_report_top. "değişkenleri tanımlama
*INCLUDE zot_23_i_report_pbo. "screenlerimin açılmadan önceki oluşturmuş olduğum modullerini topladığım yer
*INCLUDE zot_23_i_report_pai. "oluşturduktan sonra butonları yakaladığım yer
*INCLUDE zot_23_i_report_frm. "formlarımı oluşturduğum yapı
*
*START-OF-SELECTION.
*  CREATE OBJECT go_cont
*    EXPORTING
*      container_name = 'CC_ALV'.
*
*  CREATE OBJECT go_alv
*    EXPORTING
*      i_parent = go_cont.
*
*CALL METHOD go_alv->set_table_for_first_display
**  EXPORTING
**    i_buffer_active               =
**    i_bypassing_buffer            =
**    i_consistency_check           =
**    i_structure_name              =
**    is_variant                    =
**    i_save                        =
**    i_default                     = 'X'
**    is_layout                     =
**    is_print                      =
**    it_special_groups             =
**    it_toolbar_excluding          =
**    it_hyperlink                  =
**    it_alv_graphics               =
**    it_except_qinfo               =
**    ir_salv_adapter               =
*  CHANGING
*    it_outtab                     =
**    it_fieldcatalog               =
**    it_sort                       =
**    it_filter                     =
**  EXCEPTIONS
**    invalid_parameter_combination = 1
**    program_error                 = 2
**    too_many_lines                = 3
**    others                        = 4
*  .
*IF SY-SUBRC <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
**ENDIF.
*
*  CALL SCREEN 0100.





  .
