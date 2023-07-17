*&---------------------------------------------------------------------*
*& Report zot_23_p_asal
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_asal.

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p1 TYPE i OBLIGATORY,
*              p2 TYPE i OBLIGATORY.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*START-OF-SELECTION.
*
*IF p1 < 1 OR p1 > 10000.
*    MESSAGE 'Lütfen 1 ile 10000 arasında bir sayı girin!' TYPE 'E'.
*  ENDIF.
*  IF p2 < 1 OR p2 > 10000.
*    MESSAGE 'Lütfen 1 ile 10000 arasında bir sayı girin!' TYPE 'E'.
*  ENDIF.
""""""""""""""""""""""""""""
  DATA : lv_bolum TYPE i,
       lv_kalan  TYPE p,
       lv_sayi TYPE p,
       lv_flag  TYPE C.
SELECTION-SCREEN BEGIN OF BLOCK b1.
PARAMETERS : p_num TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

  lv_sayi = 2.
  WHILE lv_sayi LE p_num.
  lv_bolum = 2.
  CLEAR LV_FLAG.
  WHILE lv_bolum < lv_sayi.
    lv_kalan =  lv_sayi MOD lv_bolum.
    IF lv_kalan = 0.
      lv_flag = 'X'.
      EXIT.
    ENDIF.
    lv_bolum = lv_bolum + 1.
  ENDWHILE.
    IF lv_flag = ''.
    WRITE : / lv_sayi.
    WRITE : 'Asal sayıdır '.
  ENDIF.
  lv_sayi = lv_sayi + 1.
ENDWHILE.
