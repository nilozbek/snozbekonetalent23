*&---------------------------------------------------------------------*
*& Report zot_23_p_performance
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_performance.

"performanslı bir select atabilmek için nelere dikkat etmek lazım: ihtiyacım olan alanları çekerim
"ihtiyacım olmayanları kullanmıyorum (15-20. satır arası)
* SELECT * kullanılmamalı
* SELECT DE VERDİKLERİNİN KEY OLMASINA DİKKAT ET

SELECT * FROM sflight  "bütün alanlar için yapıyor bu *
INTO TABLE @DATA(lt_sflight_all).

SELECT carrid,
       connid,
       fldate,
       price
       FROM sflight
       INTO TABLE @DATA(lt_sflight).

LOOP AT lt_sflight INTO DATA(ls_sflight) WHERE carrid = 'AA'.
ENDLOOP.

SELECT carrid,
connid,
price
FROM sflight
INTO TABLE @DATA(lt_sflight_2)
WHERE carrid = 'AA'.

"SELECT SINGLE KULLANIMI
TYPES: BEGIN OF ty_matnr,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF ty_matnr.

DATA: lt_matnr TYPE TABLE OF ty_matnr.

SELECT matnr FROM mara
INTO TABLE lt_matnr.

LOOP AT lt_matnr INTO DATA(ls_matnr).
  SELECT SINGLE maktx FROM makt
  INTO ls_matnr-maktx
  WHERE matnr = ls_matnr-matnr.
*AND spras = sy-langu.

ENDLOOP.

LOOP AT lt_matnr ASSIGNING FIELD-SYMBOL(<ls_matnr>).
  SELECT SINGLE maktx FROM makt
  INTO <ls_matnr>-maktx
  WHERE matnr = ls_matnr-matnr.

  "field symbolun mantığı assign ettiğimiz şey
  "lt matnr nin work ettiği satırı assign ediyo,
  "atamış olduğum değer satıra assign edilmiş adres satırını point ediyo

* LOOP İÇİNDE SELECT KULLANILMAZ!!!!

ENDLOOP.

IF lt_matnr IS NOT INITIAL.

  SELECT matnr,
         maktx
         FROM makt
         FOR ALL ENTRIES IN @lt_matnr
         WHERE matnr = @lt_matnr-matnr
         INTO TABLE @DATA(lt_maktx).
ENDIF.

SORT lt_maktx[] BY matnr maktx. "internal table olduğunu belirtmek için köşeli parantez kullandık

LOOP AT lt_matnr ASSIGNING <ls_matnr>.
  READ TABLE lt_maktx ASSIGNING FIELD-SYMBOL(<ls_maktx>) WITH KEY matnr = <ls_matnr>-matnr.
  IF sy-subrc = 0.
    <ls_matnr>-maktx = <ls_maktx>-maktx.
  ENDIF.
ENDLOOP.


SELECT mara~matnr, makt~maktx FROM mara
INNER JOIN makt
ON makt~matnr = mara~matnr
INTO TABLE @DATA(lt_maktx_last).

SELECT SINGLE matnr FROM mara
INTO @DATA(lv_matnr)
WHERE matnr = '000000000000001390'.  "bu kayıt var mı yok mu bakılıyor
IF sy-subrc = 0.
ENDIF.
  SELECT SINGLE COUNT(*) FROM mara
  WHERE matnr = '000000000000001390'.  "veri çekmeden sorgulama yapar, var mı yok mu
  IF sy-subrc = 0.

  ENDIF.

  LOOP AT lt_matnr ASSIGNING <ls_matnr>.
*READ TABLE lt_maktx ASSIGNING <ls_maktx> WITH KEY matnr = <ls_matnr>-matnr BINARY SEARCH.
*IF sy-subrc = 0.
*ENDIF.
    READ TABLE lt_maktx TRANSPORTING NO FIELDS WITH KEY matnr = <ls_matnr>-matnr BINARY SEARCH.
    IF sy-subrc = 0.
* BINARY SEARCH SIRALI OLARAK OKUR
*1 2 3 5 10 7 diyelim 7 yi ararken 10 dan sonrasına bakmaz çünkü 10 dan büyük değil diye düşünür.
    ENDIF.
  ENDLOOP.

  DATA: lt_mara TYPE TABLE OF mara.
  SELECT * FROM mara INTO @DATA(ls_mara). "select istediğim koşuldakileri alır. select-endselect her bir kayıt için database e gider alır gelir.
    ls_mara-matnr = 'DENEME'. "matnr yi deneme yazarak doldurur
    APPEND ls_mara TO lt_mara.  "üst satırda maradakileri alıyor ls_mara nın içine atıyor,

  ENDSELECT.



  TYPES: BEGIN OF ty_sflight,
           carrid     TYPE sflight-carrid,
           connid     TYPE sflight-connid,
           fldate     TYPE sflight-fldate,
           price      TYPE sflight-price,
           seatsmax   TYPE sflight-seatsmax,
           seatsmax_f TYPE sflight-seatsmax_f,
           seatsocc_f TYPE sflight-seatsocc_f,
         END OF ty_sflight.

  DATA: lt_sflight_into TYPE TABLE OF ty_sflight.
*      SELECT CARRID,
*             CONNID,
*             FLDATE,
*             PRICE,
*             SEATSMAX,
*             SEATSMAX_F,
*             SEATSOCC_F
*             FROM sflight
**             INTO CORRESPONDING FIELDS OF TABLE @lt_sflight_INTO.
**             INTO @data(lt_sflight_into_2).
*             INTO TABLE @lt_sflight_INTO.


  SELECT carrid,
              connid,
              fldate,
              price,
              seatsmax,
              seatsmax_f,
              seatsocc_f
              FROM sflight
              INTO TABLE @DATA(lt_sflight_3)
              WHERE seatsmax GT 350.

  SELECT carrid,
              connid,
              fldate,
              price,
              seatsmax,
              seatsmax_f,
              seatsocc_f
              FROM sflight
              INTO TABLE @DATA(lt_sflight_4)
              WHERE seatsmax LE 350.

    MOVE lt_sflight_3 TO lt_sflight_into.
    APPEND LINES OF lt_sflight_4 TO lt_sflight_into.
