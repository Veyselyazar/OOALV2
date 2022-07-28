*&---------------------------------------------------------------------*
*& Report ZBC405_12_WRITE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_12_write.

*BC405 kitabi sayfa 17/641.


INCLUDE zbc405_12_WRITETOP.
INCLUDE z12_incl.

WRITE: / gv_t1 UNDER 'Vorname', gv_t2 UNDER 'Nachname' INPUT QUICKINFO 'Das ist der Nachname.' .

*WRITE: / gv_t1 NO-GAP, gv_t2.
ULINE.

*INCLUDE ZBC405_12_WRITE_curr.



CLEAR gv_zahl.
WRITE: 'Zahl', gv_zahl.
* no-ZERO.
ULINE.

DATA gv_n TYPE n LENGTH 8 VALUE 33.
WRITE gv_n.
WRITE / gv_n NO-ZERO.

* NO-ZERO kullanildiginda sifirlar yerine bosluk birakilir.
* NO-GAP kullanildiginda bosluklar yazilmaz.
ULINE.

DATA gv_datum TYPE d VALUE '20220629'.
DATA gv_datum2 TYPE sy-datum VALUE '19931004'.
WRITE gv_datum DD/MM/YY.
WRITE / gv_datum2.
ULINE.


WRITE iban USING EDIT MASK '____-____-____-____-__'.
*IBAN'i parça parça yazdiriyor. (USING EDIT MASK)
ULINE.

DATA gv_text TYPE c LENGTH 4 VALUE 'Text'.
WRITE gv_text.
*linksbündig
WRITE: / gv_text RIGHT-JUSTIFIED.
WRITE: / gv_text CENTERED.

TOP-OF-PAGE.
WRITE: /2 'Vorname',
        20 'Nachname'.
ULINE.



AT LINE-SELECTION.
* Dopperklick

MESSAGE 'Doppelklick wurde ausgelöst!' TYPE 'I'.
