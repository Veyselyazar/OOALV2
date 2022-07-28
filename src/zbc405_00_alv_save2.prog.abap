*&---------------------------------------------------------------------*
*& Report ZBC405_00_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_00_alv_save2.
DATA gs_flight TYPE sflight.
DATA gt_flights TYPE TABLE OF sflight.
data ok_code type sy-ucomm.
data: go_container type REF TO cl_gui_custom_container,
      go_alv_grid  type REF TO cl_gui_alv_grid.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
SELECT-OPTIONS: so_car FOR gs_flight-carrid,
                so_con FOR gs_flight-connid.
SELECTION-SCREEN END OF BLOCK b1.

*Struktur Stable
data gs_stbl type lvc_s_stbl.

START-OF-SELECTION.
  SELECT * FROM sflight INTO TABLE gt_flights
    WHERE carrid IN so_car
      AND connid IN so_con.

  IF gt_flights IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'Keine Daten zu dieser Selektion' TYPE 'S'.
  ENDIF.



INCLUDE ZBC405_00_ALV_SAVE2_O01.
*INCLUDE zbc405_00_alv_o01.
INCLUDE ZBC405_00_ALV_SAVE2_I01.
*INCLUDE zbc405_00_alv_i01.
INCLUDE ZBC405_00_ALV_SAVE2_F01.
*include ZBC405_00_ALV_F01.
