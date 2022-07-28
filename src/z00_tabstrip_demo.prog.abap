*&---------------------------------------------------------------------*
*& Report Z00_SELECTION_SCREEN_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_tabstrip_demo.

DATA gs_spfli TYPE spfli.

SELECTION-SCREEN BEGIN OF SCREEN 101 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE t_bl1.
PARAMETERS pa_car TYPE spfli-carrid.
SELECTION-SCREEN END OF BLOCK bl1.
SELECTION-SCREEN END OF SCREEN 101.

SELECTION-SCREEN BEGIN OF SCREEN 102 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME .
SELECT-OPTIONS so_con FOR gs_spfli-connid.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 5(20) TEXT-s03 .
SELECTION-SCREEN COMMENT pos_low(8) TEXT-s04 FOR FIELD pa_col.
PARAMETERS pa_col AS CHECKBOX.
SELECTION-SCREEN COMMENT pos_high(8) TEXT-s05.
PARAMETERS pa_ico AS CHECKBOX USER-COMMAND fc_ico.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl2.
SELECTION-SCREEN END OF SCREEN 102.

SELECTION-SCREEN BEGIN OF TABBED BLOCK my_tabstrip FOR 4 LINES.
SELECTION-SCREEN TAB (30) tab1 USER-COMMAND fc_para DEFAULT SCREEN 101.
SELECTION-SCREEN TAB (30) tab2 USER-COMMAND fc_so DEFAULT SCREEN 102.

SELECTION-SCREEN END OF BLOCK my_tabstrip.



at SELECTION-SCREEN OUTPUT.
  case my_tabstrip-activetab.
   when 'FC_SO'.
  ENDCASE.


INITIALIZATION.
  tab1 = 'Fluggesellschart'.
  tab2 = 'Flugnummer - Auswhal'.

  my_tabstrip-activetab = 'FC_SO'.
  my_tabstrip-dynnr = 102.



AT SELECTION-SCREEN.
  IF sy-dynnr = 1000.
    CASE sy-ucomm.
      WHEN 'FC_PARA'.

      WHEN 'SO'.

    ENDCASE.
  ENDIF.



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
