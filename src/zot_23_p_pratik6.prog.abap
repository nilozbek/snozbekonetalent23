*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik6.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_num3 TYPE i.

*Olasılıklar: 1>2>3
*             1>3>2
*             2>1>3
*             2>3>1
*             3>1>2
*             3>2>1

IF p_num1 GT p_num2 AND p_num2 GT p_num3.
WRITE:/'İkinci sayı 1 ile 3 arasında.'.
ELSEIF p_num1 GT p_num3 AND p_num3 GT p_num2.
WRITE:/'Üçüncü sayı 1 ile 2 arasında.'.
ELSEIF p_num2 GT p_num1 AND p_num1 GT p_num3.
WRITE:/'Birinci sayı 2 ile 3 arasında.'.
ELSEIF p_num2 GT p_num3 AND p_num3 GT p_num1.
WRITE:/'Üçüncü sayı 2 ile 1 arasında.'.
ELSEIF p_num3 GT p_num1 AND p_num1 GT p_num2.
 WRITE:/'Birinci sayı 3 ile 2 arasında.'.
ELSEIF p_num3 GT p_num2 AND p_num2 GT p_num1.
WRITE:/'İkinci sayı 3 ile 1 arasında.'.
ELSE.
WRITE:/ 'HATA! Tekrar değer gir.'.

ENDIF.
