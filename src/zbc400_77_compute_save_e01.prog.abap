*&---------------------------------------------------------------------*
*&  Include           ZBC400_77_COMPUTE_E01
*&---------------------------------------------------------------------*



START-OF-SELECTION. "5.
  CASE pa_op.
    WHEN '+'.
      gv_result = pa_int1 + pa_int2.
    WHEN '-'.
      gv_result = pa_int1 - pa_int2.
    WHEN '*'.
      gv_result = pa_int1 * pa_int2.
    WHEN '/'.
      gv_result = pa_int1 / pa_int2.
  ENDCASE.

  WRITE: 'Ergebnis:'(res), gv_result.


AT SELECTION-SCREEN ON pa_int2. "4.
  IF pa_op  = '/' AND pa_int2 = 0.
    message e050(bc400).
     " MESSAGE e010 with pa_int1 sy-datum.
    " MESSAGE 'Es kann nicht durch 0 dividiert werden' TYPE 'E'.
  ENDIF.

AT SELECTION-SCREEN ON pa_op.
  IF pa_op NA '+-/*'.
    MESSAGE 'Falscher Operator' TYPE 'E'.
     message e012 with pa_op.
  ENDIF.


end-of-SELECTION. "Wird nach beendigung von Start-of-selection ausgeführt
  message 'End of Selection' type 'I'.
