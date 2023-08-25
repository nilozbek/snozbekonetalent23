*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik2.

DATA: lv_sayi TYPE i.

WRITE:/ '2 ye bölünebilir sayılar: '.

DO 101 TIMES.
IF lv_sayi MOD 2 EQ 0.
WRITE: lv_sayi , ','.
ENDIF.
lv_sayi += 1.
ENDDO.

WRITE:/ '3 e bölünebilir sayılar: '.
DO 101 TIMES.
IF lv_sayi MOD 3 EQ 0.
WRITE: lv_sayi , ','.
ENDIF.
lv_sayi += 1.
ENDDO.

WRITE:/ '5 e bölünebilir sayılar: '.
DO 101 TIMES.
IF lv_sayi MOD 5 EQ 0.
WRITE: lv_sayi , ','.
ENDIF.
lv_sayi += 1.
ENDDO.
