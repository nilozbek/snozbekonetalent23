*&---------------------------------------------------------------------*
*& Report zot_23_p_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_internal_tables.
*TYPES: BEGIN OF lty_collect_material,
*         matkl TYPE zot_00_t_materia-matkl,
*         menge TYPE zot_00_t_materia-menge,
*       END OF lty_collect_material.

DATA: lt_material TYPE TABLE OF zot_00_t_materia.

SELECT * FROM zot_00_t_materia INTO TABLE lt_material.
DATA: lt_material_2 TYPE SORTED TABLE OF zot_00_t_materia WITH UNIQUE KEY matnr.

lt_material_2 =
VALUE #( BASE lt_material_2 ( matnr = 01
                            maktx = 'Buzdolabı'
                            matkl = 'C'
                            menge = 6
                            meins = 'ST' )

                           ( matnr = 02
                            maktx = 'Fırın'
                            matkl = 'C'
                            menge = 5
                            meins = 'ST' )

                           ( matnr = 03
                            maktx = 'Mikrodalga'
                            matkl = 'C'
                            menge = 2
                            meins = 'ST' )

                           ( matnr = 04
                            maktx = 'Ocak'
                            matkl = 'C'
                            menge = 4
                            meins = 'ST' )

                           ( matnr = 05
                            maktx = 'Çaydanlık'
                            matkl = 'C'
                            menge = 8
                            meins = 'ST' ) ).


"z li tablodan çekilen: gs_material_ab
"internal table a benim attığım gs_material_c

LOOP AT lt_material INTO DATA(ls_material).
  READ TABLE lt_material_2 INTO DATA(ls_material_2)
  WITH KEY meins = ls_material-meins.

  IF sy-subrc EQ 0.
    MODIFY lt_material FROM ls_material.
    ls_material-menge += 10.

  ENDIF.
ENDLOOP.

DATA: ls_combined_datas TYPE zot_00_t_materia,  "kısa süreliğine bu satırda tut
      lt_combined_datas TYPE TABLE OF zot_00_t_materia.


APPEND LINES OF lt_material_2 TO lt_combined_datas.
APPEND LINES OF lt_material TO lt_combined_datas.

TYPES: BEGIN OF lty_collect_material,
         matkl TYPE zot_00_t_materia-matkl,
         menge TYPE zot_00_t_materia-menge,
       END OF lty_collect_material.

*DATA: ls_material_group_total TYPE zot_00_t_materia,
*      lt_material_group_total TYPE TABLE OF zot_00_t_materia.

      DATA: ls_material_group_total TYPE lty_collect_material,
      lt_material_group_total TYPE TABLE OF lty_collect_material.


LOOP AT lt_combined_datas INTO DATA(ls_combine).
  CLEAR: ls_material_group_total.
  ls_material_group_total = VALUE #( matkl = ls_combine-matkl
                                       menge = ls_combine-menge ).

COLLECT ls_material_group_total INTO lt_material_group_total.

  "IF lt_material_group_total < 10.
    DELETE lt_combined_datas WHERE menge < 10.
 " ENDIF.
ENDLOOP.



SORT lt_combined_datas BY menge ASCENDING.
SORT lt_material_group_total BY menge DESCENDING.

*WRITE :/ lt_combined_datas.  HATA VERDI NEDEN?
cl_demo_output=>display( lt_combined_datas ).

cl_demo_output=>display( lt_material_group_total ).
