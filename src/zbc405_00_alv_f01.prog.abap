*----------------------------------------------------------------------*
***INCLUDE ZBC405_00_ALV_F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FREE_CONTROL_RESSOURCES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_control_ressources .
go_alv_grid->free( ).
go_container->free( ).
CLEAR: go_alv_grid, go_container.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_FIELD_CATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_field_catalog .
  gs_fcat-fieldname = 'SEATSFREE'.
  append gs_fcat to gt_fcat.
  gs_fcat-fieldname = 'PAST'.
  append gs_fcat to gt_fcat.
  gs_fcat-fieldname = 'AMPEL'.
  append gs_fcat to gt_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
   EXPORTING
     I_STRUCTURE_NAME             = 'SFLIGHT'
    CHANGING
      ct_fieldcat                  = gt_fcat.

  loop at gt_fcat into gs_fcat.
    case gs_fcat-fieldname.
      when 'AMPEL'.
        gs_fcat-coltext = 'Status'(amp).
      when 'PAYMENTSUM'.
        gs_fcat-no_out = 'X'.
      when 'SEATSOCC'.
        gs_fcat-do_sum = 'X'.
      when 'SEATSFREE'.
        gs_fcat-scrtext_s = 'Frei'.
        gs_fcat-scrtext_m = 'Freie Plätze'.
        gs_fcat-scrtext_l = 'Freie Plätze economy'.
       " gs_fcat-hotspot = 'X'.
        gs_fcat-do_sum ='X'.
      when 'PAST'.
        gs_fcat-icon = 'X'.
        gs_fcat-coltext = 'Änderbar'(chg).
        gs_fcat-col_pos = 5.
        gs_fcat-tooltip = 'Änderungen möglich?'(t01).
      when 'CARRID' or 'CONNID' or 'FLDATE'.
        gs_fcat-key = ' '.
      when 'PRICE'.
        gs_fcat-outputlen = 10.
    ENDCASE.
    modify gt_fcat from gs_fcat.
  ENDLOOP.



ENDFORM.
