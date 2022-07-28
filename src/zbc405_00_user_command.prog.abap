*&---------------------------------------------------------------------*
*& Report ZBC405_00_USER_COMMAND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC405_00_USER_COMMAND.
PARAMETERS pa_zahl type i.
at  SELECTION-SCREEN OUTPUT.


START-OF-SELECTION.
  SET PF-STATUS 'MYLIST'.
  WRITE 'List line'.

AT USER-COMMAND.
  IF sy-lsind = 20.
    SET PF-STATUS 'MYLIST' EXCLUDING 'MY_SELECTION'.
  ENDIF.
  CASE sy-ucomm.
    WHEN 'MY_SELECTION'.
      WRITE: / 'You worked on list', sy-listi,
             / 'You are on list', sy-lsind.
    ...
  ENDCASE.
