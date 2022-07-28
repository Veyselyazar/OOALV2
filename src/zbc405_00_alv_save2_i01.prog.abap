*----------------------------------------------------------------------*
***INCLUDE ZBC405_00_ALV_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      perform free_control_ressources.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      perform free_control_ressources.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.
