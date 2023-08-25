*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik4.

PARAMETERS: p_num TYPE i.

START-OF-SELECTION.
WRITE:/ 'Girilen Sayı: ', p_num.
IF p_num > 0 AND p_num <= 25.
WRITE:/ 'Sayı 0 ile 25 arasındadır.'.

ELSEIF p_num > 25 AND p_num <= 50.
WRITE:/ 'Sayı 25 ile 50 arasındadır.'.

ELSEIF p_num > 50 AND p_num <= 75.
WRITE:/ 'Sayı 50 ile 75 arasındadır.'.

ELSEIF p_num > 75 AND p_num <= 100.
WRITE:/ 'Sayı 75 ile 100 arasındadır.'.

ELSEIF p_num > 100.
WRITE:/ 'Sayı 100 den büyük.'.
ENDIF.
