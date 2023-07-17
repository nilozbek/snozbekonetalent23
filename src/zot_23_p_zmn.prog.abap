*&---------------------------------------------------------------------*
*& Report zot_23_p_zmn
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_zmn.
"""""""""""""""""""""""""""""""""""""""""""
"ÖNEMLİ NOTLAR:
"loop içinde DATA tanımlama, tanımlıcaksan inline olarak tanımla!
"Türkçe isimlendirme yapma, tanımı Türkçe girebilirsin!
"""""""""""""""""""""""""""""""""""""""""""
DATA: ls_zmnhesapla TYPE zot_23_t_zmn,
      lt_zmnhesapla TYPE TABLE OF zot_23_t_zmn.   "Bu aslında local olmuyo tüm programda geçerli çünkü

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS s_index FOR ls_zmnhesapla-indexx.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.
START-OF-SELECTION.

SELECT * FROM zot_23_t_zmn INTO TABLE lt_zmnhesapla WHERE indexx IN s_index.

DATA: lv_gun_farki TYPE i,
      lv_saat_farki TYPE i,
      lv_yil_farki TYPE i,
      lv_ay_farki TYPE i,
      lv_saniye_farki TYPE i,
      lv_yil_icin_gun_farki TYPE i,
      lv_dakika_farki TYPE i.

LOOP AT lt_zmnhesapla INTO ls_zmnhesapla.

      IF ls_zmnhesapla-bitis_saati LE ls_zmnhesapla-baslangic_saati.
      lv_saat_farki = ( ls_zmnhesapla-baslangic_saati - ls_zmnhesapla-bitis_saati ) / 3600.
      ELSE.
      lv_saat_farki = ( ls_zmnhesapla-bitis_saati - ls_zmnhesapla-baslangic_saati ) / 3600.
      ENDIF.

*      IF ls_zmnhesapla-bitis_saati LE ls_zmnhesapla-baslangic_saati.
*      lv_saniye_farki = ( ls_zmnhesapla-baslangic_saati - ls_zmnhesapla-bitis_saati ).
*      ELSE.
*      lv_saniye_farki = ( ls_zmnhesapla-bitis_saati - ls_zmnhesapla-baslangic_saati ).
*      ENDIF.


      DATA(p_tarihbas) = ls_zmnhesapla-baslangic_tarihi.
      DATA(p_tarihbit) = ls_zmnhesapla-bitis_tarihi.

      IF p_tarihbit+4(2) LE p_tarihbas+4(2).
      lv_ay_farki = p_tarihbas+4(2) - p_tarihbit+4(2).
      ELSE.
      lv_ay_farki = p_tarihbit+4(2) - p_tarihbas+4(2).
      ENDIF.

      IF p_tarihbit+6(2) LE p_tarihbas+6(2).
      lv_gun_farki = p_tarihbas+6(2) - p_tarihbit+6(2).
      ELSE.
      lv_gun_farki = p_tarihbit+6(2) - p_tarihbas+6(2).
      ENDIF.

      DATA(p_saatbas) = ls_zmnhesapla-baslangic_saati.
      DATA(p_saatbit) = ls_zmnhesapla-bitis_saati.

      IF p_saatbit+4(2) LE p_saatbas+4(2).
      lv_saniye_farki = p_saatbas+4(2) - p_saatbit+4(2).
      ELSE.
      lv_saniye_farki = p_saatbit+4(2) - p_saatbas+4(2).
      ENDIF.

      IF p_saatbit+2(2) LE p_saatbas+2(2).
      lv_dakika_farki = p_saatbas+2(2) - p_saatbit+2(2).
      ELSE.
      lv_dakika_farki = p_saatbit+2(2) - p_saatbas+2(2).
      ENDIF.

      lv_yil_icin_gun_farki = ls_zmnhesapla-bitis_tarihi - ls_zmnhesapla-baslangic_tarihi.
      lv_yil_farki = lv_yil_icin_gun_farki / 365.
*      lv_dakika_farki = lv_saat_farki / 60.


      IF lv_gun_farki <> 0 OR lv_saat_farki <> 0.
      WRITE :/ 'Index ID:', ls_zmnhesapla-indexx.
      WRITE :/ 'Yıllar Arası Fark:', lv_yil_farki, 'yıl.'.
      WRITE :/ 'Aylar Arası Fark:', lv_ay_farki, 'ay.'.
      WRITE :/ 'Günler Arası Fark:', lv_gun_farki, 'gün.'.
      WRITE :/ 'Saatler Arası Fark:', lv_saat_farki, 'saat.'.
      WRITE :/ 'Dakikalar Arası Fark:', lv_dakika_farki, 'dakika.'.
      WRITE :/ 'Saniyeler Arası Fark:', lv_saniye_farki, 'saniye.'.
      WRITE :/ '---------'.

      ENDIF.
      ENDLOOP.
