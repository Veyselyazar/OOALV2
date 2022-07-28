*&---------------------------------------------------------------------*
*& Report Z00_DEMO_ALV_OM_AUS_SFLIGHT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_alv_grid_dynpro.

DATA gs_sflight TYPE sflight.
DATA gt_sflight TYPE TABLE OF sflight.
data ok_code type sy-ucomm.
data go_alv_grid type REF TO cl_gui_alv_grid.
data go_container type REF TO cl_gui_custom_container.

PARAMETERS pa_car TYPE sflight-carrid.
SELECT-OPTIONS so_con FOR gs_sflight-connid.


SELECT * FROM sflight INTO TABLE gt_sflight
  WHERE carrid = pa_car
    AND connid IN so_con.

if gt_sflight is not INITIAL.
  call screen 100.
endif.

INCLUDE z00_demo_alv_grid_dynpro_o01.

INCLUDE z00_demo_alv_grid_dynpro_i01.
