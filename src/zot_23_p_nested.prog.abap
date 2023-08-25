*&---------------------------------------------------------------------*
*& Report zot_23_p_nested
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_nested.

DATA(lt_ogr_not) = VALUE zot_23_tt_ogr_not( (
                                          ogr_id      = '1278'
                                          ogr_ad      = 'Nil'
                                          ogr_dgm_trh = '17.11.2002'
                                          ogr_bolum   = 'bilgisayar'
                                          ogr_notlari = VALUE zot_23_s_sinif(
                                          birinci_s_not = VALUE zot_23_s_ders(
                                          ders_1 = VALUE zot_23_s_not(
                                          vize_1 = '50'
                                          vize_2 = '80'
                                          final = '72'
                                          butunleme = '100')
                                          ders_2 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_3 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_4 = VALUE zot_23_s_not(
                                          vize_1 = '60'
                                          vize_2 = '77'
                                          final = '75'
                                          butunleme = '90')
                                          ders_5 = VALUE zot_23_s_not(
                                          vize_1 = '84'
                                          vize_2 = '78'
                                          final = '52'
                                          butunleme = '70') )

                                          ikinci_s_not = VALUE zot_23_s_ders(
                                          ders_1 = VALUE zot_23_s_not(
                                          vize_1 = '55'
                                          vize_2 = '28'
                                          final = '62'
                                          butunleme = '100')
                                          ders_2 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '65'
                                          final = '72'
                                          butunleme = '94')
                                          ders_3 = VALUE zot_23_s_not(
                                          vize_1 = '56'
                                          vize_2 = '68'
                                          final = '62'
                                          butunleme = '92')
                                          ders_4 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_5 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90') )

                                          ucuncu_s_not = VALUE zot_23_s_ders(
                                          ders_1 = VALUE zot_23_s_not(
                                          vize_1 = '50'
                                          vize_2 = '80'
                                          final = '72'
                                          butunleme = '100')
                                          ders_2 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_3 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_4 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_5 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90') )

                                          dorduncu_s_not = VALUE zot_23_s_ders(
                                          ders_1 = VALUE zot_23_s_not(
                                          vize_1 = '50'
                                          vize_2 = '80'
                                          final = '72'
                                          butunleme = '100')
                                          ders_2 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_3 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_4 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90')
                                          ders_5 = VALUE zot_23_s_not(
                                          vize_1 = '46'
                                          vize_2 = '78'
                                          final = '72'
                                          butunleme = '90') )
                                                              )
                                                              ) ).
cl_demo_output=>display( lt_ogr_not ).
