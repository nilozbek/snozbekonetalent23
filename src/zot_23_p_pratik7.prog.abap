*&---------------------------------------------------------------------*
*& Report zot_23_p_pratik7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_23_p_pratik7.

PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            p_islem TYPE c.

DATA: gv_result TYPE i.

CASE p_islem.
WHEN '+'.
gv_result = p_num1 + p_num2.
WHEN '-'.
gv_result = p_num1 - p_num2.
WHEN '*'.
gv_result = p_num1 * p_num2.
WHEN '/'.
gv_result = p_num1 / p_num2.
WHEN OTHERS.
WRITE:/ 'HATA, TEKRAR YAP!'.

ENDCASE.

WRITE:/ 'SONUÇ: ', gv_result.
