*&---------------------------------------------------------------------*
*& Report zot_23_p_satsas_rapor
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_satsas_rapor.
TABLES: eban, ekpo.
INCLUDE zot_23_i_report_top.
INCLUDE zot_23_i_report_sel.
INCLUDE zot_23_i_report_cls.
INCLUDE zot_23_i_report_mdl.

INITIALIZATION.
  go_main = lcl_main_controller=>get_instance( ).


START-OF-SELECTION.

  IF p_sat = abap_true.
    go_main->get_datasat( ).

    SELECT eban~banfn,
           eban~bnfpo,
           eban~bsart,
           eban~matnr,
           eban~menge,
           eban~meins
    FROM eban
    INNER JOIN ekpo ON ekpo~banfn = eban~banfn AND ekpo~matkl = eban~matkl
    WHERE eban~banfn IN @s_sat_id AND eban~bsart IN @s_sat_in
                                            "bnfpo
    INTO TABLE @gt_sat.

    LOOP AT gt_sat INTO gs_sat.
      IF gs_sat-menge > 10.
        gs_sat-color = 'C510'.
      ENDIF.
      MODIFY gt_sat FROM gs_sat.
    ENDLOOP.

    go_main->display_grid_sat( ).

  ELSEIF p_sas = abap_true.
    go_main->get_datasas( ).

    SELECT ekpo~ebeln,
           ekpo~ebelp,
           ekpo~matnr,
           ekpo~menge,
           ekpo~meins
    FROM ekpo
    INNER JOIN eban ON eban~banfn = ekpo~banfn AND ekpo~matkl = eban~matkl
    WHERE ekpo~ebeln IN @s_sas_id AND ekpo~matkl IN @s_sas_in
    INTO TABLE @gt_sas.

    LOOP AT gt_sas INTO gs_sas.
      IF gs_sas-menge > 10.
        gs_sas-color = 'C510'.
      ENDIF.
      MODIFY gt_sas FROM gs_sas.
    ENDLOOP.

    go_main->display_grid_sas( ).

  ENDIF.


END-OF-SELECTION.

*TABLES: eban,
*        ekpo.
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
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  SELECT-OPTIONS:  s_banfn FOR eban-banfn,
*                   s_bnfpo FOR eban-bnfpo.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
*  SELECT-OPTIONS: s_banfn2 FOR ekpo-banfn,
*                  s_bnfpo2 FOR ekpo-bnfpo.
*SELECTION-SCREEN END OF BLOCK b2.
*
*SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
*  PARAMETERS: p_sat  TYPE char1 RADIOBUTTON GROUP gr1,
*              p_sas TYPE char1 RADIOBUTTON GROUP gr1.
*
*SELECTION-SCREEN END OF BLOCK b3.


*INCLUDE zot_23_i_report_top. "değişkenleri tanımlama
*INCLUDE zot_23_i_report_pbo. "screenlerimin açılmadan önceki oluşturmuş olduğum modullerini topladığım yer
*INCLUDE zot_23_i_report_pai. "oluşturduktan sonra butonları yakaladığım yer
*INCLUDE zot_23_i_report_frm. "formlarımı oluşturduğum yapı
