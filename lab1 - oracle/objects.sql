create or replace type trip_participant as object
(
    firstname      varchar2(50),
    lastname       varchar2(50),
    reservation_id number,
    status         char(1)
);


create or replace type trip_participants_table is table of trip_participant;


create or replace type person_reservation as object
(
    country        varchar2(100),
    trip_date      date,
    trip_name      varchar2(100),
    reservation_id number,
    status         char(1)
);


create or replace type person_reservations_table as table of person_reservation;


create or replace type available_trips as object
(
    trip_date           date,
    trip_name           varchar2(100),
    no_places           number,
    no_available_places number
);


create or replace type available_trips_table as table of available_trips;