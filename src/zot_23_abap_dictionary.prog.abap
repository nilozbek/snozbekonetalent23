*&---------------------------------------------------------------------*
*& Report zot_23_abap_dictionary
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_abap_dictionary.
*
**TYPES : BEGIN OF lty_personel,
**          id        TYPE zot_23_e_id,
**          ad        TYPE zot_23_e_ad,
**          yas       TYPE zot_23_e_yas,
**          departman TYPE zot_23_e_departman,
**          unvan     TYPE zot_23_e_unvan,
**        END OF lty_personel.
**
**DATA : ls_personel_1 TYPE lyt_personel,
**       ls_personel_2 TYPE zot_23_s_personel.
**
**DATA: ls_personel TYPE zot_23_s_personel,
**      lt_personel TYPE TABLE OF zot_23_s_personel, "satırın tipinde tablo
**      lt_personel2 TYPE zot_23_tt_personel, "tablonun tipinde bir tablo
**      lt_personel3 TYPE TABLE OF zot_23_tt_personel. "iç içe tablo olur, personel2 nin tablosu

DATA(lt_personel) = VALUE zot_23_tt_personel( ( id        = 1
                                                ad        = 'Sena Süyün'
                                                yas       = 18
                                                departman = 'ABAP'
                                                unvan     = 'Stajyer'
                                                ekip      =  VALUE zot_23_tt_ekip(
                                                             ( id = 2
                                                               ad = 'Yusuf Yüksel' )
                                                             ( id = 3
                                                               ad = 'Mustafa Özkaya') )
                     ) ).
                     BREAK otnozbek.
