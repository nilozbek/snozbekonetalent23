REPORT zot_23_calculator.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: number1 TYPE p DECIMALS 2 OBLIGATORY,
              number2 TYPE p DECIMALS 2 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: topla RADIOBUTTON GROUP grp1,
              cikar RADIOBUTTON GROUP grp1,
              carp  RADIOBUTTON GROUP grp1,
              bol   RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b2.
PARAMETERS: result TYPE p DECIMALS 2.
AT SELECTION-SCREEN.
  CASE 'X'.
    WHEN topla.
      result = number1 + number2.
    WHEN cikar.
      result = number1 - number2.
    WHEN carp.
      result = number1 * number2.
    WHEN bol.
      IF number2 <> 0.
        result = number1 / number2.
      ELSE.
        MESSAGE 'Sıfıra bölme hatası!!' TYPE 'E'.
      ENDIF.
  ENDCASE.
  cl_demo_output=>write( |Sonuç: { result }| ).
  cl_demo_output=>display( ).
