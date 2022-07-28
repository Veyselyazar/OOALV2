*----------------------------------------------------------------------*
***INCLUDE Z00_DEMO_ALV_GRID_DYNPRO_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_0100'.
  SET TITLEBAR 'TITEL_0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CREATE_AND_DISPLAY_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_and_display_alv OUTPUT.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL'.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container.
  ENDIF.

  go_alv_grid->set_table_for_first_display(
    EXPORTING
      i_structure_name              = 'SFLIGHT'
*    is_variant                    =
*    i_save                        =
*    i_default                     = 'X'
*    is_layout                     =
*    is_print                      =
*    it_special_groups             =
*    it_toolbar_excluding          =
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
    CHANGING
      it_outtab                     = gt_sflight
*    it_fieldcatalog               =
*    it_sort                       =
*    it_filter                     =
  ).





ENDMODULE.
