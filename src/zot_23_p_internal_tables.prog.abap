*&---------------------------------------------------------------------*
*& Report zot_23_p_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_internal_tables.

"NOTLAR:
"gt_material : internal table
"z li tablodan çekilen : gs_material_ab
"internal table a benim attığım : gs_material_c
"gt_material_c : ikinci internal table, matkl = 'C' ler için

DATA: gt_material TYPE TABLE OF zot_00_t_materia.

SELECT * FROM zot_00_t_materia INTO TABLE gt_material.
DATA: gt_material_c TYPE SORTED TABLE OF zot_00_t_materia WITH UNIQUE KEY matnr.

gt_material_c =
VALUE #( BASE gt_material_c ( matnr = 01
                            maktx = 'Buzdolabı'
                            matkl = 'C'
                            menge = 6
                            meins = 'ST' ) ).
gt_material_c =
VALUE #( BASE gt_material_c ( matnr = 02
                            maktx = 'Fırın'
                            matkl = 'C'
                            menge = 5
                            meins = 'ST' ) ).
gt_material_c =
VALUE #( BASE gt_material_c ( matnr = 03
                            maktx = 'Mikrodalga'
                            matkl = 'C'
                            menge = 2
                            meins = 'ST' ) ).
gt_material_c =
VALUE #( BASE gt_material_c ( matnr = 04
                            maktx = 'Ocak'
                            matkl = 'C'
                            menge = 4
                            meins = 'ST' ) ).
gt_material_c =
VALUE #( BASE gt_material_c ( matnr = 05
                            maktx = 'Çaydanlık'
                            matkl = 'C'
                            menge = 8
                            meins = 'ST' ) ).


"z li tablodan çekilen: gs_material_ab
"internal table a benim attığım gs_material_c

LOOP AT gt_material INTO DATA(gs_material_ab).
  READ TABLE gt_material_c INTO DATA(gs_material_c)
  WITH KEY meins = gs_material_ab-meins.

  IF sy-subrc EQ 0.
    MODIFY gt_material FROM gs_material_ab.
    gs_material_ab-menge += 10.

  ENDIF.
ENDLOOP.

DATA: ls_combined_datas TYPE zot_00_t_materia,  "kısa süreliğine bu satırda tut
      lt_combined_datas TYPE TABLE OF zot_00_t_materia.


APPEND LINES OF gt_material_c TO lt_combined_datas.
APPEND LINES OF gt_material TO lt_combined_datas.

DATA: ls_material_group_total TYPE zot_00_t_materia,
      lt_material_group_total TYPE TABLE OF zot_00_t_materia.


LOOP AT lt_combined_datas INTO ls_combined_datas.
  ADD ls_combined_datas-menge TO ls_material_group_total-menge.
  IF ls_combined_datas-menge LT 10.
    DELETE lt_combined_datas WHERE matnr = ls_combined_datas-matnr.
  ENDIF.
ENDLOOP.

SORT lt_combined_datas BY menge ASCENDING.
SORT lt_material_group_total BY menge DESCENDING.

*WRITE :/ lt_combined_datas.  HATA VERDI NEDEN?
cl_demo_output=>display( lt_combined_datas ).

cl_demo_output=>display( lt_material_group_total ).

*LOOP AT lt_combined_datas INTO ls_combined_datas WHERE menge GT 10.
*  WRITE: / ls_combined_datas-matnr,
*           ls_combined_datas-maktx,
*           ls_combined_datas-menge.

*ENDLOOP.
