*&---------------------------------------------------------------------*
*&  Include           ZBC405_12_SOL_E01
*&---------------------------------------------------------------------*

LOAD-OF-PROGRAM. "1

INITIALIZATION. "2
  so_car-sign = 'I'.
  so_car-option = 'BT'.
  so_car-low = 'AA'.
  so_car-high = 'QF'.
  APPEND so_car.
  CLEAR so_car.
  so_car-sign = 'E'.
  so_car-option = 'EQ'.
  so_car-low = 'AZ'.
  APPEND so_car.

  tab1 = 'Flugverbindungen'.
  tab2 = 'Flugtermin'.
  tab3 = 'Flugart'.
  tab4 = 'Ausgabe'.

  gv_butt = 'Details ausblenden'.

*  tabstrip-activetab = 'FC_TAB2'.
*  tabstrip-dynnr  = '1200'.

AT SELECTION-SCREEN OUTPUT. "3
  "IF sy-dynnr = 1000.
    PERFORM where_klausel_setzen.
    TRY.
        SELECT COUNT(*) FROM dv_flights INTO gv_count WHERE (gv_where_klausel).
        gv_text = `Anzahl zu selektierender Datensätze: ` && gv_count.
      CATCH cx_root.
    ENDTRY.

    IF gv_butt = 'Details einblenden'.
      LOOP AT SCREEN.
        IF screen-group1 = 'AUS'.
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
    ENDIF.
  "ENDIF.

AT SELECTION-SCREEN ON BLOCK radio.
  IF pa_inl = 'X' AND pa_land IS INITIAL.
    MESSAGE e003(bc405).
  ENDIF.

AT SELECTION-SCREEN ON BLOCK b1.
  IF so_car-low = 'AZ'.
    MESSAGE 'Wir verarbeiten keine Alitalia' TYPE 'E'.
  ENDIF.

AT SELECTION-SCREEN ON HELP-REQUEST FOR so_car.
  CALL SCREEN 110
    STARTING AT 20  10
    ENDING AT  150  20.

AT SELECTION-SCREEN .
  IF sy-dynnr = 1100.
    CASE sy-ucomm.

      WHEN 'FC_BUTTON'.
        IF gv_butt = 'Details einblenden'.
          gv_butt = 'Details ausblenden'.
        ELSE.
          gv_butt = 'Details einblenden'.
        ENDIF.

    ENDCASE.
  ENDIF.


START-OF-SELECTION. "5

  PERFORM where_klausel_setzen.

  CASE 'X'.
    WHEN pa_write.
      SELECT * FROM dv_flights INTO gs_flights
      WHERE (gv_where_klausel).
        WRITE: /10 gs_flights-carrid,
                   gs_flights-connid,
                   gs_flights-fldate,
                   gs_flights-countryfr,
                   gs_flights-cityfrom,
                   gs_flights-airpfrom,
                   gs_flights-countryto,
                   gs_flights-cityto,
                   gs_flights-airpto,
                   gs_flights-price,
                   gs_flights-currency,
                   gs_flights-seatsmax,
                   gs_flights-seatsocc.
      ENDSELECT.
    WHEN pa_alv.
      SELECT * FROM dv_flights INTO TABLE gt_flights
      WHERE (gv_where_klausel).
      cl_salv_table=>factory(
       EXPORTING
          list_display   = pa_liste
        IMPORTING
          r_salv_table   = go_alv
        CHANGING
          t_table        = gt_flights
             ).


      go_func = go_alv->get_functions( ).
      go_func->set_all( ).
      go_alv->display( ).

  ENDCASE.
