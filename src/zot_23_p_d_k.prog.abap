*&---------------------------------------------------------------------*
*& Report zot_23_p_d_k
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_d_k.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p1 TYPE i OBLIGATORY,
              p2 TYPE n LENGTH 1 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  IF p1 < 1 OR p1 > 100.
    MESSAGE 'Lütfen 1 ile 100 arasında bir sayı girin!' TYPE 'E'.
  ENDIF.
  IF p2 < 1 OR p2 > 9.
    MESSAGE 'Lütfen 1 ile 9 arasında bir sayı girin!' TYPE 'E'.
  ENDIF.

  DATA: lv_max_number TYPE i,
        lv_iterations TYPE i,
        lv_index      TYPE i.

  lv_max_number = p1.
  lv_iterations = p2.


  DO lv_max_number TIMES.
   .
lv_index = sy-index.
    IF lv_index > 0 AND lv_index MOD lv_iterations EQ 1.

      WRITE :/ lv_index.
    ELSE.
      WRITE lv_index.
    ENDIF.

  ENDDO.
