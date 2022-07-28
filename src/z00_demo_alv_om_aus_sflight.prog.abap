*&---------------------------------------------------------------------*
*& Report Z00_DEMO_ALV_OM_AUS_SFLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_alv_om_aus_sflight.

DATA gs_sflight TYPE sflight.
DATA gt_sflight TYPE TABLE OF sflight.
DATA go_alv_om TYPE REF TO cl_salv_table.
data go_func type REF TO cl_salv_functions.
PARAMETERS pa_car TYPE sflight-carrid.
SELECT-OPTIONS so_con FOR gs_sflight-connid.
PARAMETERS pa_list AS CHECKBOX.

SELECT * FROM sflight INTO TABLE gt_sflight
  WHERE carrid = pa_car
    AND connid IN so_con.

cl_salv_table=>factory(
  EXPORTING
    list_display   = pa_list

  IMPORTING
    r_salv_table   = go_alv_om
  CHANGING
    t_table        = gt_sflight
       ).
go_func = go_alv_om->get_functions( ).
go_func->set_all( ).

go_alv_om->display( ).
