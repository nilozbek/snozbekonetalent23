*&---------------------------------------------------------------------*
*& Report zot_23_p_zmn
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_zmn.


DATA: ls_zmnhesapla TYPE zot_23_t_zmn,
      lt_zmnhesapla TYPE TABLE OF zot_23_t_zmn.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS s_index FOR ls_zmnhesapla-indexx.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.
START-OF-SELECTION.

SELECT * FROM zot_23_t_zmn INTO TABLE lt_zmnhesapla WHERE indexx IN s_index.

LOOP AT lt_zmnhesapla INTO ls_zmnhesapla.

DATA: lv_gun_farki TYPE i,
      lv_saat_farki TYPE i,
      lv_yil_farki TYPE i,
      lv_dakika_farki TYPE i.

      lv_gun_farki = ls_zmnhesapla-bitis_tarihi - ls_zmnhesapla-baslangic_tarihi.

      IF ls_zmnhesapla-bitis_saati LE ls_zmnhesapla-baslangic_saati.
      lv_saat_farki = ls_zmnhesapla-baslangic_saati - ls_zmnhesapla-bitis_saati.
      ELSE.
      lv_saat_farki = ls_zmnhesapla-bitis_saati - ls_zmnhesapla-baslangic_saati.
      ENDIF.

      lv_yil_farki = lv_gun_farki / 365.
      lv_dakika_farki = lv_saat_farki / 60.


      IF lv_gun_farki <> 0 OR lv_saat_farki <> 0.
      WRITE :/ 'Index ID:', ls_zmnhesapla-indexx.
      WRITE :/ 'Yıllar Arası Fark:', lv_yil_farki, 'yıl.'.
      WRITE :/ 'Günler Arası Fark:', lv_gun_farki, 'gün.'.
      WRITE :/ 'Saatler Arası Fark:', lv_saat_farki, 'saat.'.
      WRITE :/ 'Dakikalar Arası Fark:', lv_dakika_farki, 'dakika.'.


      ENDIF.
      ENDLOOP.
