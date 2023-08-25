*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik5.

PARAMETERS: p_not TYPE i.

START-OF-SELECTION.

WRITE:/ 'Notunuz = ' , p_not.
IF p_not >= 0 AND p_not <= 20.
WRITE:/ 'Harf notunuz FF!'.

ELSEIF p_not > 20 AND p_not <= 40.
WRITE:/ 'Harf notunuz DD!'.

ELSEIF p_not > 40 AND p_not <= 60.
WRITE:/ 'Harf notunuz CC!'.

ELSEIF p_not > 60 AND p_not <= 80.
WRITE:/ 'Harf notunuz BB!'.

ELSEIF p_not > 80 AND p_not <= 100.
WRITE:/ 'Harf notunuz AA!'.

ELSE.
WRITE:/ 'Böyle bir not yok, tekrar değer gir!'.

ENDIF.
