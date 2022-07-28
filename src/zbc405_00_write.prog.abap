*&---------------------------------------------------------------------*
*& Report ZBC405_00_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_00_write.

include zbc405_00_writetop.
include z00_incl.

WRITE: / gv_t1 UNDER 'Vorname', gv_t2 UNDER 'Nachname' INPUT QUICKINFO 'Das ist der Nachname' .

"WRITE: / gv_t1 NO-GAP, gv_t2.

ULINE.

include z00_incl.


"include ZBC405_00_WRITE_curr.





CLEAR gv_zahl.
WRITE: 'Zahl', gv_zahl." NO-ZERO.
ULINE.
DATA gv_n TYPE n LENGTH 8 VALUE 33.
WRITE: gv_n.
WRITE: / gv_n NO-ZERO.
ULINE.
DATA gv_datum TYPE d VALUE '20220629'.
DATA gv_datum2 TYPE sy-datum VALUE '20220815'.
WRITE gv_datum MM/DD/YY.
WRITE / gv_datum2.
ULINE.

WRITE iban USING EDIT MASK '____-____-____-____-__'.


uline.
data gv_text type n LENGTH 100  VALUE 500.
write gv_text no-zero LEFT-JUSTIFIED. "linksbündig
write: / gv_text no-zero RIGHT-JUSTIFIED.
write: / gv_text no-zero CENTERED.

TOP-OF-PAGE.
  WRITE: /20 'Vorname',
          2 'Nachname'.
AT LINE-SELECTION. "Doppelklick

  MESSAGE 'Doppelklick wurde ausgelöst' TYPE 'I'.
