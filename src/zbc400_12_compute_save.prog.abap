*&---------------------------------------------------------------------*
*& Report ZBC400_12_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_12_compute_save MESSAGE-ID ZBC400_JUNI.

INCLUDE ZBC400_12_COMPUTE_SAVE_TOP.
INCLUDE ZBC400_12_COMPUTE_SAVE_E01.


LOAD-OF-PROGRAM. "1.
*
*
*
*INITIALIZATION. "2
*  pa_int1 = 5.
*  pa_int2 = 12.
*  pa_op = '*'.
*
*AT SELECTION-SCREEN OUTPUT. "3
*  pa_int1 = pa_int1 + 1.
*
***********************************************************************
**
**   Bildschirmanzeige
**
***********************************************************************
* AT SELECTION-SCREEN. "4.
*  IF pa_int1 > 6.
*    MESSAGE 'Zahl wird langsam zu groß' TYPE 'E'.
*  ENDIF.
*
*
*
*START-OF-SELECTION. "5.




*IF ( pa_op = '+' or
*     pa_op = '-' or
*     pa_op = '*' or
*     pa_op = '/' and pa_int2 <> 0 ).
*
*  CASE pa_op.
*    WHEN '+'.
*      gv_result = pa_int1 + pa_int2.
*    WHEN '-'.
*      gv_result = pa_int1 - pa_int2.
*    WHEN '*'.
*      gv_result = pa_int1 * pa_int2.
*    WHEN '/'.
*      gv_result = pa_int1 / pa_int2.
*  ENDCASE.
*
*WRITE: 'Das Ergebnis:', gv_result.
*
*ELSEIF pa_op = '/' and pa_int2 = 0.
*  WRITE 'No division by zero!'(dbz).
*
*ELSE.
*  WRITE 'Invalid operator!'(iop).
*ENDIF.
