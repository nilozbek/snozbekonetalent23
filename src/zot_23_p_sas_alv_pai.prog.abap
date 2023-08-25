*&---------------------------------------------------------------------*
*& Include          ZOT_23_P_SAS_ALV_PAI
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
CASE SY-ucomm.
  WHEN '&back'.
      SET SCREEN 0.
ENDCASE.
ENDMODULE.
