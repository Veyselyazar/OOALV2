*&---------------------------------------------------------------------*
*&  Include           ZBC405_00_SOL_F01
*&---------------------------------------------------------------------*
Form satzausgabe.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  WHERE_KLAUSEL_SETZEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM where_klausel_setzen .
  gv_where_klausel = `carrid IN so_car AND connid IN so_con AND fldate IN so_fld `.
  gv_where_klausel = gv_where_klausel && ' and cityfrom in so_citfr and cityto in so_citto '.
  CASE 'X'.
    WHEN pa_all.
    WHEN pa_aus.
      gv_where_klausel = gv_where_klausel && ` AND countryfr <> dv_flights~countryto `.
    WHEN pa_inl.
      gv_where_klausel = gv_where_klausel && ` AND countryfr = dv_flights~countryto `.
      gv_where_klausel = gv_where_klausel && ` and countryfr = pa_land `.
  ENDCASE.
ENDFORM.
