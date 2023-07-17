*&---------------------------------------------------------------------*
*& Report zot_23_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_internal_tables.

TYPES:BEGIN OF lty_material,
        matnr TYPE matnr, "malzeme id
        maktx TYPE maktx, "malzeme açıklaması
        matkl TYPE matkl, "malzeme grubu
        menge TYPE menge_d, "miktar
        meins TYPE meins,
      END OF lty_material.

DATA: lt_material TYPE TABLE OF lty_material,
      ls_material TYPE lty_material.

"APPEND
ls_material-matnr = '01'.
ls_material-maktx = 'Çekiç'.
ls_material-matkl = 'Hırdavat'.
ls_material-menge = 5.
ls_material-meins = 'PC'. "ölçü birimi
APPEND ls_material TO lt_material.

"BASE
lt_material = VALUE #( base lt_material ( matnr = '02'
                                          maktx = 'Tornavida'
                                          matkl = 'Hırdavat'
                                          menge = 10
                                          meins = 'PC' ) ).

"INSERT
ls_material-matnr = '03'.
ls_material-maktx = 'Lastih'.
ls_material-matkl = 'Hırdavat'.
ls_material-menge = 15.
ls_material-meins = 'PC'.
INSERT ls_material INTO TABLE lt_material.

"SORTED  (Bu tipteki table ları performans için kullanıyoruz,
*         belirli bir indexe göre okuduğu için sistem daha hızlı okuyor
DATA: lt_material_s type SORTED TABLE OF lty_material with NON-UNIQUE KEY matnr.

      "bu tabloya aynı matnr den kayıt atabilirim demek. Ben eğer unique deseydim matnr ler farklı olsaydı hata alırdım
lt_material = VALUE #( base lt_material ( matnr = ' '
                                          maktx = 'Tornavida'
                                          matkl = 'Hırdavat'
                                          menge = 10
                                          meins = 'PC' ) ).
*DATA: lv_matnr TYPE matnr.
*DO 5 TIMES.
*  lv_matnr += 1.
*  ls_material-matnr = lv_matnr.
*  ls_material-maktx = 'Çekiç'.
*  ls_material-matkl = 'Hırdavat'.
*  ls_material-menge = 6.
*  ls_material-meins = 'PC'.
*  APPEND ls_material TO lt_material.
**  CLEAR: ls_material.   "büyük programlarda sorun olmaması adına alışkanlık
*
*  lv_matnr += 1.
*  ls_material-matnr = lv_matnr.
*  ls_material-maktx = 'Tornavida'.
*  ls_material-matkl = 'Hırdavat'.
*  ls_material-menge = 5.
*  ls_material-meins = 'PC'.
*  APPEND ls_material TO lt_material.
*ENDDO.

*DATA: lv_matnr TYPE numc2.
*DO 5 TIMES.
*  lv_matnr += 1.
*  ls_material-matnr = lv_matnr.
*  ls_material-maktx = 'Çekiç'.
*  ls_material-matkl = 'Hırdavat'.
*  ls_material-menge = 6.
*  ls_material-meins = 'PC'.
*  APPEND ls_material TO lt_material.
*  CLEAR: ls_material.   "büyük programlarda sorun olmaması adına alışkanlık
*ENDDO.
*DATA: lt_material_kirtasiye TYPE TABLE OF lty_material,
*      lt_material_hirdavat TYPE TABLE of lty_material.

*DO 5 TIMES.
*lv_matnr += 1.
*lt_material_kirtasiye =
*VALUE #( BASE lt_material_kirtasiye ( matnr = lv_matnr
*                                      maktx = 'Kalem'
*                                      matkl = 'Kırtasiye'
*                                      menge = 10
*                                      meins = 'PC' ) ).
*lv_matnr += 1.
*lt_material_kirtasiye =
*VALUE #( BASE lt_material_kirtasiye ( matnr = lv_matnr
*                                      maktx = 'Silgi'
*                                      matkl = 'Kırtasiye'
*                                      menge = 10
*                                      meins = 'KG' ) ).
*lv_matnr += 1.
*lt_material_kirtasiye =
*VALUE #( BASE lt_material_kirtasiye ( matnr = lv_matnr
*                                      maktx = 'Sulu Boya'
*                                      matkl = 'Kırtasiye'
*                                      menge = 5
*                                      meins = 'M3' ) ).
*lv_matnr += 1.
*lt_material_hirdavat =
*VALUE #( BASE lt_material_hirdavat ( matnr = lv_matnr
*                                     maktx = 'Çivi'
*                                     matkl = 'Hırdavat'
*                                     menge = 10
*                                     meins = 'KG' ) ).
*lv_matnr += 1.
*lt_material_hirdavat =
*VALUE #( BASE lt_material_hirdavat ( matnr = lv_matnr
*                                     maktx = 'Balta'
*                                     matkl = 'Hırdavat'
*                                     menge = 10
*                                     meins = 'PC' ) ).
* ENDDO.
*"kırtasiyedeki meins alanım eğer hırdavatın meins alanıyla eşitse loopum dursun.
*LOOP AT lt_material_kirtasiye INTO DATA(ls_material_kirtasiye).
*  READ TABLE lt_material_hirdavat INTO DATA(ls_material_hirdavat)
*  WITH KEY meins = ls_material_kirtasiye-meins.
*
*  IF sy-subrc EQ 0.
*    "BREAK-POINT.
*    "eğer bu şarta girerse kırtasiyenin meins ini m^3 yap
**    ls_material_kirtasiye-meins = 'M3'.
**    MODIFY lt_material_kirtasiye FROM ls_material_kirtasiye.
*    ls_material_kirtasiye-menge = 15.
*    MODIFY lt_material_kirtasiye FROM ls_material_kirtasiye
*    TRANSPORTING menge WHERE meins = 'M3'.
*
*  ENDIF.
*ENDLOOP.
*
*DATA: lt_material_buffer TYPE TABLE OF lty_material.
*TYPES: BEGIN OF lty_malzeme,
*         matnr TYPE matnr,
*         maktx TYPE maktx,
*       END OF lty_malzeme.

*DATA lt_malzeme TYPE TABLE OF lty_malzeme.
*
**MOVE lt_material_kirtasiye TO lt_malzeme.
*MOVE-CORRESPONDING lt_material_kirtasiye TO lt_malzeme.
*
*DELETE lt_material_kirtasiye WHERE menge > 9.
*
*SORT lt_material_kirtasiye BY menge DESCENDING. "bir şey yazmassak küçükten büyüğe sıralar
*
*
**MOVE lt_material_kirtasiye TO lt_material_buffer.
*
*
*READ TABLE lt_material INTO ls_material WITH KEY maktx = 'Çekiç'. "matnr si 01 olan kaydı getirir. Çekiç yazısını büyük harflerle yazssaydı hata alırdık.(read işleminde böyle)
*IF  sy-subrc EQ 0. "bir önceki kodun çalışıp çalışmadığını kontrol eder, 0 dan farklıysa hata var demektir
*  lt_material = VALUE #( BASE lt_material ( matnr = '99'
*                                            maktx = 'Kalem'
*                                            matkl = 'Kırtasiye'
*                                            menge = ls_material-menge
*                                            meins = ls_material-meins ) ).
*            "bulduğu ilk kaydı getiriyo. sy-tabix ile kaçıncı satırı istediğini belirtebilirsin
*ENDIF.
** read table internal table ın tek bir satırını çekmeye yarıyor. belirli şartlar verebiliyoruz. sy-tabix kaçıncı satırda olduğunu gösteriyo.



DATA: lt_material_kirtasiye TYPE SORTED TABLE OF lty_material WITH UNIQUE KEY matnr,
      lt_material_hirdavat TYPE TABLE OF lty_material,
      lt_material_kirtasiye_unsorted TYPE TABLE OF lty_material.

DATA: lv_matnr TYPE numc10.

      DO 10000 TIMES.
      lv_matnr += 1.

      lt_material_kirtasiye =
         VALUE #( BASE lt_material ( matnr = lv_matnr
                                     maktx = 'Silgi'
                                     matkl = 'Kırtasiye'
                                     menge = 10
                                     meins = 'M3' ) ).

      ENDDO.

      LOOP AT lt_material_hirdavat INTO DATA(ls_material_hirdavat).
      READ TABLE lt_material_kirtasiye INTO DATA(ls_material_kirtasiye)
      WITH KEY matnr = ls_material_hirdavat-matnr BINARY SEARCH.
       IF sy-subrc = 0.
       BREAK-POINT.
       ENDIF.
       ENDLOOP.

*       GET RUN TIME FIELD lv_beg.
*       LOOP AT lt_material_hirdavat INTO DATA(ls_material_hirdavat).
*       READ TABLE lt_material_kirtasiye_unsorted INTO DATA(ls_material_kirtasiye)
*       WITH KEY
*
