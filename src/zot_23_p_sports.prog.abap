*&---------------------------------------------------------------------*
*& Report zot_23_p_sports
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_sports.



TYPES : BEGIN OF ty_g,
          id      TYPE i,
          team    TYPE char40,
          country TYPE char2,
        END OF ty_g.

DATA: lt_g1 TYPE TABLE OF ty_g, "internal table
      ls_g1 TYPE ty_g, "structure
      lt_ga TYPE TABLE OF ty_g,
      ls_ga TYPE ty_g.

DATA: lt_g2 TYPE TABLE OF ty_g, "internal table
      ls_g2 TYPE  ty_g, "structure
      lt_gb TYPE TABLE OF ty_g,
      ls_gb TYPE ty_g.

DATA: lt_g3 TYPE TABLE OF ty_g, "internal table
      ls_g3 TYPE  ty_g, "structure
      lt_gc TYPE TABLE OF ty_g,
      ls_gc TYPE ty_g.

DATA: lt_g4 TYPE TABLE OF ty_g, "internal table
      ls_g4 TYPE  ty_g, "structure
      lt_gd TYPE TABLE OF ty_g,
      ls_gd TYPE ty_g.

DATA: rnd_value TYPE integer2.


*TORBA1
ls_g1-id = 1.
ls_g1-team = 'Liverpool'.
ls_g1-country = 'EN'.
APPEND ls_g1 TO lt_g1.

ls_g1-id = 2.
ls_g1-team = 'Bayern Munich'.
ls_g1-country = 'DE'.
APPEND ls_g1 TO lt_g1.

ls_g1-id = 3.
ls_g1-team = 'Inter'.
ls_g1-country = 'IT'.
APPEND ls_g1 TO lt_g1.

ls_g1-id = 4.
ls_g1-team = 'PSG'.
ls_g1-country = 'FR'.
APPEND ls_g1 TO lt_g1.
""""""""""""""""""""""""""""""""
*TORBA2
ls_g2-id = 1.
ls_g2-team = 'Man.City'.
ls_g2-country = 'EN'.
APPEND ls_g2 TO lt_g2.

ls_g2-id = 2.
ls_g2-team = 'PSV'.
ls_g2-country = 'NE'.
APPEND ls_g2 TO lt_g2.

ls_g2-id = 3.
ls_g2-team = 'Porto'.
ls_g2-country = 'PO'.
APPEND ls_g2 TO lt_g2.

ls_g2-id = 4.
ls_g2-team = 'Real Madrid'.
ls_g2-country = 'ES'.
APPEND ls_g2 TO lt_g2.
"""""""""""""""""""""""""""""""
*TORBA3
ls_g3-id = 1.
ls_g3-team = 'Dortmund'.
ls_g3-country = 'DE'.
APPEND ls_g3 TO lt_g3.

ls_g3-id = 2.
ls_g3-team = 'Galatasaray'.
ls_g3-country = 'TR'.
APPEND ls_g3 TO lt_g3.

ls_g3-id = 3.
ls_g3-team = 'Marsilya'.
ls_g3-country = 'FR'.
APPEND ls_g3 TO lt_g3.

ls_g3-id = 4.
ls_g3-team = 'Ajax'.
ls_g3-country = 'NE'.
APPEND ls_g3 TO lt_g3.
""""""""""""""""""""""""""""""
*TORBA4
ls_g4-id = 1.
ls_g4-team = 'AEK'.
ls_g4-country = 'GR'.
APPEND ls_g4 TO lt_g4.

ls_g4-id = 2.
ls_g4-team = 'Roma'.
ls_g4-country = 'IT'.
APPEND ls_g4 TO lt_g4.

ls_g4-id = 3.
ls_g4-team = 'St.Bükreş'.
ls_g4-country = 'RO'.
APPEND ls_g4 TO lt_g4.

ls_g4-id = 4.
ls_g4-team = 'At.Madrid'.
ls_g4-country = 'ES'.
APPEND ls_g4 TO lt_g4.

DO.

  CALL FUNCTION 'RANDOM_I2'
    EXPORTING
      rnd_min   = 1
      rnd_max   = 4
    IMPORTING
      rnd_value = rnd_value.

  IF lt_g1 IS NOT INITIAL.

    READ TABLE lt_g1 INTO ls_g1
    WITH KEY id = rnd_value.
    IF sy-subrc EQ 0.
      IF lt_ga IS INITIAL.
        MOVE-CORRESPONDING ls_g1 TO ls_ga.
        APPEND ls_ga TO lt_ga.
        DELETE lt_g1 WHERE id = rnd_value.
      ELSEIF lt_gb IS INITIAL.
        MOVE-CORRESPONDING ls_g1 TO ls_gb.
        APPEND ls_gb TO lt_gb.
        DELETE lt_g1 WHERE id = rnd_value.
      ELSEIF lt_gc IS INITIAL.
        MOVE-CORRESPONDING ls_g1 TO ls_gc.
        APPEND ls_gc TO lt_gc.
        DELETE lt_g1 WHERE id = rnd_value.
      ELSEIF lt_gd IS INITIAL.
        MOVE-CORRESPONDING ls_g1 TO ls_gd.
        APPEND ls_gd TO lt_gd.
        DELETE lt_g1 WHERE id = rnd_value.
      ENDIF.
    ENDIF.

  ELSEIF lt_g2 IS NOT INITIAL.

    READ TABLE lt_g2 INTO ls_g2
    WITH KEY id = rnd_value.
    IF sy-subrc EQ 0.
      IF lines( lt_ga ) = 1.
        READ TABLE lt_ga INTO ls_ga
        WITH KEY country = ls_g2-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g2 TO ls_ga.  "ls_ga-team,id,.. = ls_g2-team,id,..
          APPEND ls_ga TO lt_ga.
          DELETE lt_g2 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gb ) = 1.
        READ TABLE lt_gb INTO ls_gb
         WITH KEY country = ls_g2-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g2 TO ls_gb.
          APPEND ls_gb TO lt_gb.
          DELETE lt_g2 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gc ) = 1.
        READ TABLE lt_gc INTO ls_gc
         WITH KEY country = ls_g2-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g2 TO ls_gc.
          APPEND ls_gc TO lt_gc.
          DELETE lt_g2 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gd ) = 1.
        READ TABLE lt_gd INTO ls_gd
          WITH KEY country = ls_g2-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g2 TO ls_gd.
          APPEND ls_gd TO lt_gd.
          DELETE lt_g2 WHERE id = rnd_value.
        ENDIF.
      ENDIF.
    ENDIF.

  ELSEIF lt_g3 IS NOT INITIAL.

    READ TABLE lt_g3 INTO ls_g3
    WITH KEY id = rnd_value.
    IF sy-subrc EQ 0.
      IF lines( lt_ga ) = 2.
        READ TABLE lt_ga INTO ls_ga
        WITH KEY country = ls_g3-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g3 TO ls_ga.
          APPEND ls_ga TO lt_ga.
          DELETE lt_g3 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gb ) = 2.
        READ TABLE lt_gb INTO ls_gb
         WITH KEY country = ls_g3-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g3 TO ls_gb.
          APPEND ls_gb TO lt_gb.
          DELETE lt_g3 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gc ) = 2.
        READ TABLE lt_gc INTO ls_gc
         WITH KEY country = ls_g3-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g3 TO ls_gc.
          APPEND ls_gc TO lt_gc.
          DELETE lt_g3 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gd ) = 2.
        READ TABLE lt_gd INTO ls_gd
          WITH KEY country = ls_g3-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g3 TO ls_gd.
          APPEND ls_gd TO lt_gd.
          DELETE lt_g3 WHERE id = rnd_value.
        ENDIF.
      ENDIF.
    ENDIF.

  ELSEIF lt_g4 IS NOT INITIAL.

    READ TABLE lt_g4 INTO ls_g4
    WITH KEY id = rnd_value.
    IF sy-subrc EQ 0.
      IF lines( lt_ga ) = 3.
        READ TABLE lt_ga INTO ls_ga
        WITH KEY country = ls_g4-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g4 TO ls_ga.
          APPEND ls_ga TO lt_ga.
          DELETE lt_g4 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gb ) = 3.
        READ TABLE lt_gb INTO ls_gb
         WITH KEY country = ls_g4-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g4 TO ls_gb.
          APPEND ls_gb TO lt_gb.
          DELETE lt_g4 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gc ) = 3.
        READ TABLE lt_gc INTO ls_gc
         WITH KEY country = ls_g4-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g4 TO ls_gc.
          APPEND ls_gc TO lt_gc.
          DELETE lt_g4 WHERE id = rnd_value.
        ENDIF.
      ELSEIF lines( lt_gd ) = 3.
        READ TABLE lt_gd INTO ls_gd
          WITH KEY country = ls_g4-country.
        IF sy-subrc NE 0.
          MOVE-CORRESPONDING ls_g4 TO ls_gd.
          APPEND ls_gd TO lt_gd.
          DELETE lt_g4 WHERE id = rnd_value.
        ENDIF.
      ENDIF.
    ENDIF.

  ELSE.

    EXIT.

  ENDIF.

ENDDO.
BREAK otnozbek.

.
