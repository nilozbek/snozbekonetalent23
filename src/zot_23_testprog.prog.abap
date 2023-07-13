*&---------------------------------------------------------------------*
*& Report ZOT_23_TESTPROG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZOT_23_TESTPROG.

DATA: lv_ad(6)       TYPE c,
      lv_a_sayisi(6) TYPE c.

START-OF-SELECTION.

  lv_ad = 'Serkan'.
  DATA(lv_int) = strlen( lv_ad ).

*  WRITE:/ lv_ad+5(1).
*  WRITE:/ lv_ad+5(1).


  DO 6 TIMES.
  data(lv_index) = sy-index - 1.
    IF lv_ad+lv_index(1) = 'a'.

      lv_a_sayisi = lv_a_sayisi + 1.
      ENDIF.

    ENDDO.
    cl_demo_output=>write( lv_a_sayisi ).
  cl_demo_output=>display( ).
