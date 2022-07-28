*&---------------------------------------------------------------------*
*& Report Z00_SELECT_OPTIONS_DEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_select_options_demo.

data gv_dummy type s_carr_id. " Char 3
select-OPTIONS so_car for gv_dummy.

DATA gt_scarr TYPE TABLE OF scarr.
DATA gs_scarr TYPE scarr.

gs_scarr-carrid = 'LH'.
APPEND gs_scarr TO gt_scarr[].

LOOP AT gt_scarr[] INTO gs_scarr.
  "WRITE gs_scarr.
ENDLOOP.

CLEAR gs_scarr.
CLEAR gt_scarr[].

******************************************
DATA gt_scarr_h TYPE TABLE OF scarr WITH HEADER LINE.
gt_scarr_h-carrid = 'LH'. "Struktur
APPEND gt_scarr_h TO gt_scarr_h. "Struktur wird an Tabelle angehangen

LOOP AT gt_scarr_h INTO gt_scarr_h. "Kopieren von Tabelle in Struktur
  "WRITE gt_scarr_h. "Ausgabe der Struktur
ENDLOOP.
CLEAR gt_scarr_h. "Struktur wird gelöscht
CLEAR gt_scarr_h[]. "Löschen der Tabelle
REFRESH gt_scarr_h. "Löschen der Tabelle

BREAK-POINT.
