create or replace function TripParticipants(trip_id number)
    return trip_participants_table
as
    result trip_participants_table;
begin

    --     throws an error
    trip_exist(TripParticipants.trip_id);

    select trip_participant(P.firstname, P.lastname, R.reservation_id, R.status) bulk collect
    into result
    from person P
             inner join reservation R on R.person_id = P.person_id
    where R.trip_id = TripParticipants.trip_id;

    return result;

end;


create or replace function PersonReservations(person_id number)
    return person_reservations_table
as
    result person_reservations_table;
begin

    person_exist(PersonReservations.person_id);

    select person_reservation(C.country_name, T.trip_date, T.trip_name, R.reservation_id, R.status) bulk collect
    into result
    from trip T
             inner join country C on C.country_id = T.country_id
             inner join reservation R on R.trip_id = T.trip_id
             inner join person P on P.person_id = R.person_id
    where P.person_id = PersonReservations.person_id;

    return result;

end;


create or replace function AvailableTripsFunc(country varchar2, date_from date, date_to date)
    return available_trips_table
as
    result available_trips_table;
begin

    if AvailableTripsFunc.date_from > AvailableTripsFunc.date_to then
        raise_application_error(-20001, 'wrong date range');
    end if;

    country_exist(AvailableTripsFunc.country);

    select available_trips(V.trip_date, V.trip_name, V.no_places, V.no_available_places) bulk collect
    into result
    from AvailableTripsNoDateCheck V
    where V.trip_date >= AvailableTripsFunc.date_from
      and V.trip_date <= AvailableTripsFunc.date_to
      and AvailableTripsFunc.country = V.country;

    return result;

end;


create or replace function AvailableTripsFunc4(country varchar2, date_from date, date_to date)
    return available_trips_table
as
    result available_trips_table;
begin

    if AvailableTripsFunc4.date_from > AvailableTripsFunc4.date_to then
        raise_application_error(-20001, 'wrong date range');
    end if;

    country_exist(AvailableTripsFunc4.country);

    select available_trips(T.trip_date, T.trip_name, T.max_no_places, T.no_available_places) bulk collect
    into result
    from trip T
             inner join country C on T.country_id = C.country_id
    where T.trip_date >= AvailableTripsFunc4.date_from
      and T.trip_date <= AvailableTripsFunc4.date_to
      and AvailableTripsFunc4.country = C.country_name
      and T.no_available_places > 0;

    return result;

end;

