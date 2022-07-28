*&---------------------------------------------------------------------*
*& Report ZBC405_00_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_00_alv_save.
DATA gs_flight TYPE sflight.
DATA gt_flights TYPE TABLE OF sflight.
data ok_code type sy-ucomm.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
SELECT-OPTIONS: so_car FOR gs_flight-carrid,
                so_con FOR gs_flight-connid.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  SELECT * FROM sflight INTO TABLE gt_flights
    WHERE carrid IN so_car
      AND connid IN so_con.

  IF gt_flights IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'Keine Daten zu dieser Selektion' TYPE 'S'.
  ENDIF.



INCLUDE ZBC405_00_ALV_SAVE_O01.
*INCLUDE zbc405_00_alv_o01.
INCLUDE ZBC405_00_ALV_SAVE_I01.
*INCLUDE zbc405_00_alv_i01.
