*&---------------------------------------------------------------------*
*&  Include           ZBC405_00_SOL_E01
*&---------------------------------------------------------------------*


at SELECTION-SCREEN OUTPUT.
refresh so_car.
so_car-sign = 'I'.
so_car-OPTION = 'BT'.
so_car-low = 'AA'.
so_car-high = 'AZ'.
append so_car.
clear so_car.
**************
so_car-sign = 'I'.
so_car-OPTION = 'EQ'.
so_car-low = 'LH'.
append so_car.

START-OF-SELECTION.
select * from dv_flights into gs_flights
  where carrid in so_car.
WRITE: /10 gs_flights-carrid,
           gs_flights-connid,
           gs_flights-fldate,
           gs_flights-countryfr,
           gs_flights-cityfrom,
           gs_flights-airpfrom,
           gs_flights-countryto,
           gs_flights-cityto,
           gs_flights-airpto,
           gs_flights-price,
           gs_flights-currency,
           gs_flights-seatsmax,
           gs_flights-seatsocc.


ENDSELECT.

at USER-COMMAND.
  message sy-ucomm type 'I'.
