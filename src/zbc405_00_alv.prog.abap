*&---------------------------------------------------------------------*
*& Report ZBC405_00_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_00_alv.
"DATA gs_flight TYPE sflight.
"DATA gt_flights TYPE TABLE OF sflight.
TYPES: BEGIN OF ty_flights.
         INCLUDE TYPE sflight.
       TYPES:
                ampel        TYPE c LENGTH 1, "Ausnahmespalte
                it_colfields TYPE lvc_t_scol, "Interne Tabelle Zellenfarben
                color        TYPE c LENGTH 4, " Konstante C Nr 0-7 Intensiv 0-1  Invertierung 0-1
                seatsfree    TYPE i,
                telephone    TYPE scustom-telephone,
                past         TYPE icon-id,
              END OF ty_flights.
DATA ok_code TYPE sy-ucomm.
DATA gs_flight TYPE ty_flights.
DATA gt_flights TYPE TABLE OF ty_flights.

DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid  TYPE REF TO cl_gui_alv_grid.

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    METHODS on_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING es_row_no
                e_column
                sender.
    METHODS on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING e_object.
    METHODS on_user_command FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING e_ucomm.
ENDCLASS.
CLASS lcl_handler IMPLEMENTATION.
  METHOD on_double_click.
    DATA ls_flight TYPE ty_flights.
    MESSAGE i017(bc405_408) WITH es_row_no-row_id e_column-fieldname.
    READ TABLE gt_flights INTO ls_flight INDEX es_row_no-row_id.
  ENDMETHOD.
  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.
    ls_button-function = 'BUTTON1'.
    ls_button-text   = 'Eigener Button 1'.
    ls_button-icon = icon_ws_plane.
    ls_button-quickinfo = 'Selbst definierter Button'.
    insert ls_button inTO  e_object->mt_toolbar index 5.
  ENDMETHOD.
  METHOD on_user_command.
    CASE e_ucomm.
      WHEN 'BUTTON1'.
        MESSAGE 'Button mit der nr 1 wurde ausgelöst' TYPE 'I'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
SELECT-OPTIONS: so_car FOR gs_flight-carrid DEFAULT 'AA',
                so_con FOR gs_flight-connid DEFAULT 17.
PARAMETERS pa_plane TYPE saplane-planetype.
PARAMETERS pa_lv TYPE disvariant-variant.
SELECTION-SCREEN END OF BLOCK b1.

DATA gt_car LIKE TABLE OF so_car.
DATA go_handler TYPE REF TO lcl_handler.

*Struktur Stable für Methode REFRESH_TABLE_DISPLAY
DATA gs_stbl TYPE lvc_s_stbl.
* Struktur zur Layout-Verwaltung
DATA gs_variant TYPE disvariant.
* Struktur für Layout des ALV
DATA gs_layout TYPE lvc_s_layo.
* Sortierungen
DATA: gs_sort TYPE lvc_s_sort,
      gt_sort TYPE lvc_t_sort.
* Struktur für zellenfarbe
DATA gs_colfields TYPE lvc_s_scol.

" Werkzeuge ausblenden
DATA gt_functions TYPE ui_functions.
* Feldkatalog definieren
DATA gt_fcat TYPE lvc_t_fcat.
DATA gs_fcat TYPE lvc_s_fcat.

INITIALIZATION. "Wird einmali beim Start aufgerufen
  gs_variant-report = sy-cprog.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.
  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant = gs_variant
      i_save     = 'A'
    IMPORTING
      es_variant = gs_variant
    EXCEPTIONS
      OTHERS     = 2.

  IF sy-subrc = 0.
    pa_lv = gs_variant-variant.
  ENDIF.


START-OF-SELECTION.
  gt_car = so_car[].
  gs_variant-variant = pa_lv.
  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_flights
    WHERE carrid IN so_car
  AND connid IN so_con.

  IF gt_flights IS NOT INITIAL.
    LOOP AT gt_flights INTO gs_flight.
      IF gs_flight-seatsocc = 0.
        gs_flight-ampel = '1'. " rot
      ELSEIF gs_flight-seatsocc < 50.
        gs_flight-ampel = '2'. " gelb
      ELSE.
        gs_flight-ampel = '3'. " grün
      ENDIF.

      IF gs_flight-fldate(6) = sy-datum(6).
        gs_flight-color = 'C310'.
      ELSE.
        CLEAR gs_flight-color.
      ENDIF.

      IF gs_flight-fldate < sy-datum.
        gs_flight-past = icon_space.
      ELSE.
        gs_flight-past = icon_okay.
      ENDIF.

      IF gs_flight-planetype = pa_plane.
        gs_colfields-fname = 'PLANETYPE'.
        gs_colfields-color-col = col_positive.
        gs_colfields-color-int = 1.
        APPEND gs_colfields TO gs_flight-it_colfields.

      ENDIF.

      gs_flight-seatsfree = gs_flight-seatsmax - gs_flight-seatsocc.

      MODIFY gt_flights FROM gs_flight.
    ENDLOOP.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'Keine Daten zu dieser Selektion' TYPE 'S'.
  ENDIF.



  INCLUDE zbc405_00_alv_o01.
  INCLUDE zbc405_00_alv_i01.
  INCLUDE zbc405_00_alv_f01.
