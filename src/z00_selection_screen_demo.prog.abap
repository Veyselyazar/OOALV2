*&---------------------------------------------------------------------*
*& Report Z00_SELECTION_SCREEN_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_selection_screen_demo.

DATA gs_spfli TYPE spfli.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE t_bl1.
PARAMETERS pa_car TYPE spfli-carrid.
SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME .

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(20) TEXT-s03 .
SELECTION-SCREEN COMMENT pos_low(8) TEXT-s04 FOR FIELD pa_col.
PARAMETERS pa_col AS CHECKBOX.
SELECTION-SCREEN COMMENT pos_high(8) TEXT-s05.
PARAMETERS pa_ico AS CHECKBOX.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bl2.

SELECTION-SCREEN BEGIN OF SCREEN 1100.
SELECT-OPTIONS so_con FOR gs_spfli-connid.
SELECTION-SCREEN END OF SCREEN 1100.

DATA gv_count TYPE i.

INITIALIZATION.
  t_bl1 = 'Mein individueller Titel aus INIT'.

AT SELECTION-SCREEN OUTPUT.
  SELECT COUNT(*) FROM spfli INTO gv_count WHERE carrid = pa_car AND connid IN so_con.
  t_bl1 = `Bei F8-Taste liefert diese Selektion ` && gv_count && ' Datensätze'.
  IF pa_car = 'AA'.
    LOOP  AT SCREEN INTO screen.
      IF screen-name = 'PA_COL'.
        screen-input = 0.
        MODIFY screen FROM screen.
      ENDIF.
    ENDLOOP.
  ENDIF.

AT SELECTION-SCREEN.
  IF pa_ico = 'X'.
    IF sy-dynnr = 1000.
      CALL SELECTION-SCREEN 1100
          STARTING AT  20 10
          ENDING   AT 150 15.
    ENDIF.
  ELSE.
    clear so_con[].
  "  LEAVE TO SCREEN 1000.
  ENDIF.


  CASE pa_car.
    WHEN 'AA'.
      "t_bl1 = 'Die Flugnummern aus American Airlines'.
    WHEN 'LH'.

  ENDCASE.

START-OF-SELECTION.
  SELECT * FROM spfli INTO gs_spfli
    WHERE carrid = pa_car
      AND connid IN so_con.

    WRITE: /5 gs_spfli-carrid,
              gs_spfli-connid,
              gs_spfli-cityto,
              gs_spfli-deptime,
              gs_spfli-arrtime.
  ENDSELECT.
