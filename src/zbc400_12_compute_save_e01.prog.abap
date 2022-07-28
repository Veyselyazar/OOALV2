*&---------------------------------------------------------------------*
*&  Include           ZBC400_12_COMPUTE_E01
*&---------------------------------------------------------------------*


IF pa_op = '+'.
  gv_result = pa_int1 + pa_int2.
  WRITE: 'Das Ergebnis:'(res), gv_result.

ELSEIF pa_op = '-'.
  gv_result = pa_int1 - pa_int2.
  WRITE: 'Das Ergebnis:'(res), gv_result.

ELSEIF pa_op = '*'.
  gv_result = pa_int1 * pa_int2.
  WRITE: 'Das Ergebnis:'(res), gv_result.

ELSEIF pa_op = '/' AND pa_int2 <> 0.
  gv_result = pa_int1 / pa_int2.
  WRITE: 'Das Ergebnis:'(res), gv_result.
ENDIF.

AT SELECTION-SCREEN ON pa_int2. "4.
  IF pa_op  = '/' AND pa_int2 = 0.
      MESSAGE e010 with pa_int1 sy-datum.
    " MESSAGE 'Es kann nicht durch 0 dividiert werden' TYPE 'E'.
  ENDIF.

AT SELECTION-SCREEN ON pa_op.
  IF pa_op NA '+-/*'.
    "MESSAGE 'Falscher Operator' TYPE 'E'.
     message x012 with pa_op.
  ENDIF.
