REPORT zot_23_calculator.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: number1 TYPE p DECIMALS 2 OBLIGATORY,
              number2 TYPE p DECIMALS 2 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_topla RADIOBUTTON GROUP grp1,
              p_cikar RADIOBUTTON GROUP grp1,
              p_carp  RADIOBUTTON GROUP grp1,
              p_bol   RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b2.
PARAMETERS: result TYPE p DECIMALS 2.
AT SELECTION-SCREEN.
  CASE 'X'.
    WHEN p_topla.
      result = number1 + number2.
    WHEN p_cikar.
      result = number1 - number2.
    WHEN p_carp.
      result = number1 * number2.
    WHEN p_bol.
      IF number2 <> 0.
        result = number1 / number2.
      ELSE.
        MESSAGE 'Sıfıra bölme hatası!!' TYPE 'E'.
      ENDIF.
  ENDCASE.
  cl_demo_output=>write( |Sonuç: { result }| ).
  cl_demo_output=>display( ).
