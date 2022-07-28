*&---------------------------------------------------------------------*
*& Report Z00_PARAMETERS_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_parameters_demo.

PARAMETERS pa_car TYPE spfli-carrid memory id car VALUE CHECK.
PARAMETERS pa_name TYPE text40.
SELECTION-SCREEN SKIP 1.
PARAMETERS pa_chk1 AS CHECKBOX DEFAULT 'X' .
SELECTION-SCREEN SKIP 1.
PARAMETERS pa_rb1 RADIOBUTTON GROUP gr1.
PARAMETERS pa_rb2 RADIOBUTTON GROUP gr1 DEFAULT 'X'.
PARAMETERS pa_rb3 RADIOBUTTON GROUP gr1.
CONSTANTS gc_checked TYPE c LENGTH 1 VALUE 'X'.

CASE gc_checked.
  WHEN pa_rb1.
    WRITE 'RB1'.
  WHEN pa_rb2.
    WRITE 'RB2'.
  WHEN pa_rb3.
    WRITE 'RB3'.
ENDCASE.
*if pa_rb1 = 'X'.
*
*elseif pa_rb2 = 'X'.
*
*ELSEIF pa_rb3 = 'X'.
*
*endif.


CASE pa_chk1.
  WHEN 'X'.
    WRITE 'checked'.
  WHEN OTHERS.
    WRITE 'Leer'.
ENDCASE.
