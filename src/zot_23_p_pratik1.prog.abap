*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik1.

DATA: lv_sayi TYPE i.
DO 101 TIMES.
IF lv_sayi MOD 2 EQ 0.
  WRITE:/ 'Çift sayı', lv_sayi.

ELSE.
  WRITE:/ 'Tek sayı.', lv_sayi.

ENDIF.
lv_sayi += 1.

ENDDO.
