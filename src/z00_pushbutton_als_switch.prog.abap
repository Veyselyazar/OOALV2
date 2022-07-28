*&---------------------------------------------------------------------*
*& Report Z00_PUSHBUTTON_ALS_SWITCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_pushbutton_als_switch.
DATA gs_flights TYPE dv_flights.

SELECT-OPTIONS: so_car FOR gs_flights-carrid MODIF ID aus,
                so_con FOR gs_flights-connid MODIF ID aus,
                so_fld FOR gs_flights-fldate MODIF ID aus.
SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN PUSHBUTTON /30(20) gv_butt USER-COMMAND fc_button.

INITIALIZATION.
  gv_butt = 'Ausblenden'.

AT SELECTION-SCREEN OUTPUT.
  " Screen-Tabelle wird mit statischen Attributen gefüllt
  IF gv_butt = 'Einblenden'.
    LOOP AT SCREEN INTO screen.
     " if screen-name cs 'SO_CAR' or screen-name cs 'SO_CON' or screen-name cs 'SO_FLD'.
      if screen-group1 = 'AUS'.
        screen-input = 0.
        screen-output = 0.
        screen-invisible = 1.
        "screen-value_help = 0.
        modify screen from screen.
      endif.
    ENDLOOP.
  ENDIF.

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC_BUTTON'.
      IF gv_butt = 'Ausblenden'.
        gv_butt = 'Einblenden'.
      ELSE.
        gv_butt = 'Ausblenden'.
      ENDIF.
    WHEN 'ONLI'.
      MESSAGE 'F8 bei ASS' TYPE 'I'.
  ENDCASE.

START-OF-SELECTION.
  WRITE 'F8-Taste wurde ausgelöst'.
