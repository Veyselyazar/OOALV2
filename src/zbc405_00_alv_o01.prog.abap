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
        i_parent = go_container
      EXCEPTIONS
        OTHERS   = 1.
    IF sy-subrc <> 0.
      MESSAGE a045(bc405_408).
    ENDIF.

    create OBJECT go_handler.
    set HANDLER go_handler->on_double_click for go_alv_grid.
    set HANDLER go_handler->on_toolbar for go_alv_grid.
    set HANDLER go_handler->on_user_command for go_alv_grid.

    " Layout-Formatierungen
    gs_layout-zebra = 'X'.
    gs_layout-grid_title = 'Flüge'(flg).
    gs_layout-totals_bef = 'X'.
    "gs_layout-cwidth_opt = 'X'.
    "gs_layout-edit = 'X'.
    gs_layout-sel_mode = 'C'.
    gs_layout-excp_fname = 'AMPEL'.
    gs_layout-excp_led = 'X'.
    gs_layout-no_vgridln = 'X'.
    gs_layout-no_hgridln = 'X'.

    " Sortierungen setzen
    gs_sort-fieldname = 'SEATSOCC'.
    gs_sort-spos = 1.
    gs_sort-up = 'X'.
    APPEND gs_sort TO gt_sort.
    CLEAR gs_sort.

    gs_sort-fieldname = 'FLDATE'.
    gs_sort-spos = 2.
    gs_sort-down = 'X'.
    APPEND gs_sort TO gt_sort.
    CLEAR gs_sort.

    gs_sort-fieldname = 'CONNID'.
    gs_sort-spos = 3.
    gs_sort-up = 'X'.
    APPEND gs_sort TO gt_sort.
    CLEAR gs_sort.



    " Zeilenfarbe auf Spalte setzen
    gs_layout-info_fname = 'COLOR'.
    " Zellenfarbe mit interner Tabelle bestimmen
    gs_layout-ctab_fname = 'IT_COLFIELDS'.

    "Funktionen ausblenden
*    append '&SORT_ASC' to gt_functions.
*    append cl_gui_alv_grid=>MC_FC_SORT_DSC to gt_functions.
*    append cl_gui_alv_grid=>MC_MB_FILTER to gt_functions.

* Feldkatalog füllen
*gs_fcat-fieldname = 'SEATSFREE'.
*gs_fcat-col_pos = 10.
*
*gs_fcat-scrtext_s = 'Frei'.
*gs_fcat-scrtext_m = 'Freie Plätze'.
*gs_fcat-scrtext_L = 'Freie Plätze Economy'.
*gs_fcat-emphasize = 'C610'.
*gs_fcat-do_sum = 'X'.
*append gs_fcat to gt_fcat.
*clear gs_fcat.
*gs_fcat-fieldname = 'AMPEL'.
*gs_fcat-coltext = 'Status'.
*append gs_fcat to gt_fcat.
*
*clear gs_fcat.
*gs_fcat-fieldname = 'FLDATE'.
*gs_fcat-coltext = 'Datum'.
*gs_fcat-col_pos = 10.
*gs_fcat-key = ' '.
*gs_fcat-key_sel = ' '.
*append gs_fcat to gt_fcat.
*
*clear gs_fcat.
*gs_fcat-fieldname = 'TELEPHONE'.
*"gs_fcat-ref_field = 'TELEPHONE'.
*gs_fcat-ref_TABLE = 'SCUSTOM'.
*"gs_fcat-no_out = 'X'.
*gs_fcat-col_pos = 11.
*gs_fcat-outputlen = 10.
*append gs_fcat to gt_fcat.
*
*clear gs_fcat.
*gs_fcat-fieldname = 'PAST'.
*gs_fcat-coltext = 'Vergangenheit'.
*gs_fcat-col_pos = 5.
*gs_fcat-tooltip = 'Ein rotes X bedeutet, dass der flug in der Vergangenheit liegt'(tol).
*gs_fcat-icon = 'X'.
*append gs_fcat to gt_fcat.
**clear gs_fcat.
**gs_fcat-fieldname = 'CARRID'.
**gs_fcat-tech = 'X'.
**
**append gs_fcat to gt_fcat.

perform set_field_catalog.

    go_alv_grid->set_table_for_first_display(
      EXPORTING
      "  i_structure_name              = 'SFLIGHT' "Standard-Feldkatalog
*        is_variant                    = gs_variant
*        i_save                        = 'X'
*        i_default                     = ' '
      is_layout                     = gs_layout
*        is_print                      =
*        it_special_groups             =
        it_toolbar_excluding          = gt_functions
*        it_hyperlink                  =
*        it_alv_graphics               =
*        it_except_qinfo               =
*        ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_flights
        it_fieldcatalog               = gt_fcat
        it_sort                       = gt_sort
*        it_filter                     =
      EXCEPTIONS
        OTHERS = 1
           ).
    IF sy-subrc <> 0.
      MESSAGE a012(bc405_408).
    ENDIF.
  ELSE.
    gs_stbl-row = 'X'.
    gs_stbl-col = 'X'.
    go_alv_grid->refresh_table_display(
      EXPORTING
        is_stable      = gs_stbl
        i_soft_refresh = ' '
           ).


  ENDIF.
ENDMODULE.
