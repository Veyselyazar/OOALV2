*----------------------------------------------------------------------*
***INCLUDE ZBC405_00_ALV_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FREE_CONTROL_RESSOURCES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_control_ressources .
go_alv_grid->free( ).
go_container->free( ).
CLEAR: go_alv_grid, go_container.

ENDFORM.
