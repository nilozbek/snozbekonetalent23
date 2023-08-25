*&---------------------------------------------------------------------*
*& Report zot_23_p_compare
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_compare.

**YÖNTEM 1(ÇALIŞIYO AMA MANTIKI DEĞİL)
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p1 TYPE c LENGTH 6,
*              p2 TYPE c LENGTH 6,
*              p3 TYPE c LENGTH 6,
*              p4 TYPE c LENGTH 6,
*              p5 TYPE c LENGTH 6.
*
*SELECTION-SCREEN END OF BLOCK b1.
*
*START-OF-SELECTION.
*
*  IF p1 CO p2.
*  WRITE:/ P1, '-', P2.
*  ELSEIF p1 CO p3.
*  WRITE:/ P1, '-', P3.
*  ELSEIF p1 CO p4.
*  WRITE:/ P1, '-', P4.
*  ELSEIF p1 CO p5.
*  WRITE:/ P1, '-', P5.
*  ENDIF.
* """""""""""""""""""""""""""""
*  IF p2 CO p3.
*  WRITE:/ P2, '-', P3.
*  ELSEIF p2 CO p4.
*  WRITE:/ P2, '-', P4.
*  ELSEIF p2 CO p5.
*  WRITE:/ P2, '-', P5.
*  ENDIF.
* """"""""""""""""""""""""""""
*  IF p3 CO p4.
*  WRITE:/ P3, '-', P4.
*  ELSEIF p3 CO p5.
*  WRITE:/ P3, '-', P5.
*  ENDIF.
*  """""""""""""""""""""""
*  IF p4 CO p5.
*  WRITE:/ P4, '-', P5.
*  ENDIF.

*YÖNTEM2 ( TABLE İLE MANTIKLI )

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p1 TYPE c LENGTH 6,
              p2 TYPE c LENGTH 6,
              p3 TYPE c LENGTH 6,
              p4 TYPE c LENGTH 6,
              p5 TYPE c LENGTH 6.

SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  DATA: lt_parameters TYPE TABLE OF char6, "internal table char6
        lv_result     TYPE char6,
        lv_line       TYPE char6.

*  SORT p1.
*  SORT p2.
*  SORT p3.
*  SORT p4.
*  SORT p5.

  APPEND p1 TO lt_parameters.
  APPEND p2 TO lt_parameters.
  APPEND p3 TO lt_parameters.
  APPEND p4 TO lt_parameters.
  APPEND p5 TO lt_parameters.

  SORT lt_parameters.




  LOOP AT lt_parameters INTO DATA(lv_p).
    IF lv_line NE lv_p AND lv_line IS NOT INITIAL.
      WRITE:/ lv_result.
      CLEAR lv_result.
    ELSE.
      CONCATENATE lv_p '-' lv_line INTO lv_result SEPARATED BY space.


    ENDIF.
    WRITE:/ lv_result.
  ENDLOOP.





























*  DATA: lt_parameters TYPE TABLE OF string, "internal table
*
*        lt_result     TYPE TABLE OF string, "structure
*        lv_line       TYPE string.
*
*
*  APPEND p1 TO lt_parameters.
*
*
*  LOOP AT lt_parameters INTO DATA(lv_p1).
*  "  CLEAR lv_line.
*  "DELETE lt_parameters INDEX 1.
*    CONCATENATE lv_p1 '-' INTO lv_line.
*
*    LOOP AT lt_parameters INTO DATA(lv_p2).
*      CONCATENATE lv_p2 '-' INTO lv_line.
*
*      IF lv_p1 NE lv_p2 AND lv_p1 CS lv_p2.
*        CONCATENATE lv_p1 lv_p2 INTO lv_line SEPARATED BY space.
*
*      ENDIF.
*    ENDLOOP.
*    APPEND lv_line TO lt_result.
*  ENDLOOP.
*
*  LOOP AT lt_result INTO DATA(lv_result).
*  WRITE:/ lv_result.
*  ENDLOOP.





















  .
