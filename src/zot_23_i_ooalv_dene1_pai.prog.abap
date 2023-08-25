*&---------------------------------------------------------------------*
*& Include          ZOT_23_I_OOALV_DENE1_PAI
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
CASE sy-ucomm.
  WHEN '&BACK'.
    SET SCREEN 0.
      ENDCASE.
ENDMODULE.
