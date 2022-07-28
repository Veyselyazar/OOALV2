*----------------------------------------------------------------------*
***INCLUDE ZBC405_00_ALV_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'DYN'.
  SET TITLEBAR 'T100' WITH ` am ` sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CLEAR_OK_CODE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CREATE_CONT_AND_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'
      EXCEPTIONS
        OTHERS         = 1.
    IF sy-subrc <> 0.
      MESSAGE a010(bc405_408).
    ENDIF.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent          = go_container
      EXCEPTIONS
        others            = 1
        .
    IF sy-subrc <> 0.
        MESSAGE a045(bc405_408).
    ENDIF.
    go_alv_grid->set_table_for_first_display(
      EXPORTING
        i_structure_name              = 'SFLIGHT'
*        is_variant                    =
*        i_save                        =
*        i_default                     = 'X'
*        is_layout                     =
*        is_print                      =
*        it_special_groups             =
*        it_toolbar_excluding          =
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_flights
*        it_fieldcatalog               =
*        it_sort                       =
*        it_filter                     =
      EXCEPTIONS
        others = 1
           ).
    IF sy-subrc <> 0.
      message a012(bc405_408).
    ENDIF.
  else.
    gs_stbl-row = 'X'.
    gs_stbl-col = 'X'.
    go_alv_grid->refresh_table_display(
      EXPORTING
        is_stable      = gs_stbl
        i_soft_refresh = ' '
           ).


  ENDIF.
ENDMODULE.
