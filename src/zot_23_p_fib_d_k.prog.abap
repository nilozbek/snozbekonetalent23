*&---------------------------------------------------------------------*
*& Report zot_23_p_fib_d_k
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_fib_d_k.

PARAMETERS : p_son  TYPE i,
             p_dizi TYPE i.

DATA:
  lv_ilk    TYPE i VALUE 0,
  lv_ikinci TYPE i VALUE 1,
  lv_total  TYPE i.
"p_son 100 , p_dizi 3

DO .
  lv_total = lv_ilk + lv_ikinci." 21
  IF lv_total LE p_son. " 21 küçük eşit 100
    lv_ilk = lv_ikinci. " 13
    lv_ikinci = lv_total. " 21
    WRITE lv_total." 21
    IF sy-index MOD p_dizi EQ 0." 7 3
      WRITE /."satır atla
    ENDIF.
  ELSE.
    EXIT.
  ENDIF.
ENDDO.

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p1 TYPE i OBLIGATORY,
*              p2 TYPE n LENGTH 1 OBLIGATORY.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*START-OF-SELECTION.
*
*  DATA : lv_old  TYPE i,
*         lv_curr TYPE i,
*         lv_next TYPE i.
*
*  WRITE 'Fibonacci : ' .
*  WRITE : lv_old, lv_curr .
*
*  IF p1 < 1 OR p1 > 10000.
*    MESSAGE 'Lütfen 1 ile 10000 arasında bir sayı girin!' TYPE 'E'.
*  ENDIF.
*
*  IF p2 < 1 OR p2 > 9.
*    MESSAGE 'Lütfen 1 ile 9 arasında bir sayı girin!' TYPE 'E'.
*  ENDIF.
*
*  DATA: lv_max_number TYPE i,
*        lv_iterations TYPE i,
*        lv_index      TYPE i.
*
*  lv_max_number = p1.
*  lv_iterations = p2.
*
*
*  DO lv_max_number TIMES.
*    .
*    lv_index = sy-index.
*    IF lv_index > 0 AND lv_index MOD lv_iterations EQ 1.
*
*      WRITE :/ lv_index.
*    ELSE.
*      WRITE lv_index.
*    ENDIF.
*
*  ENDDO.
**
**DO p2 TIMES .
**
**  lv_next = lv_old + lv_curr .                           "3 = 1 + 2
**  WRITE lv_next .                                           "3
**  lv_old = lv_curr .                                     "lv_old = 2
**  lv_curr = lv_next .                                    "lv_curr = 3
**
**ENDDO .
**
