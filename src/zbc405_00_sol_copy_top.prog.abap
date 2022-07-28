*&---------------------------------------------------------------------*
*&  Include           ZBC405_00_SOL_TOP
*&---------------------------------------------------------------------*

DATA gs_flights TYPE dv_flights.

PARAMETERS pa_chk AS CHECKBOX USER-COMMAND para.
SELECT-OPTIONS so_car FOR gs_flights-carrid.
" DEFAULT 'AA' "to 'AZ'

"OBLIGATORY
"no-EXTENSION
"no INTERVALS.


*LOAD-OF-PROGRAM. "1
*  GET PARAMETER ID 'CAR' FIELD so_car-low.
*  APPEND so_car.
*
*INITIALIZATION. "2
*  gs_flights-conid = '0400'.
***************  Wiederholter aufruf *************
*at SELECTION-SCREEN OUTPUT. "3 (PBO)
***********************************************************************
**
**   Anzeige des DYNPRO 1000
***********************************************************************
*at SELECTION-SCREEN. "4 Prüfungen (PAI)
*
*
*
*START-OF-SELECTION. "5
