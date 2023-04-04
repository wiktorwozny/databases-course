create or replace procedure trip_exist(trip_id number)
as
    tmp char(1);
begin

    select 1 into tmp from trip t where T.trip_id = trip_exist.trip_id;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'trip not found');

end;


create or replace procedure person_exist(person_id number)
as
    tmp char(1);
begin

    select 1 into tmp from person P where P.person_id = person_exist.person_id;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'person not found');

end;


create or replace procedure country_exist(country_name varchar2)
as
    tmp char(1);
begin

    select 1 into tmp from country C where C.country_name = country_exist.country_name;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'there is no such country in database');

end;


create or replace procedure is_trip_available(trip_id number)
as
    tmp char(1);
begin

    select 1
    into tmp
    from AvailableTrips A
             inner join trip t on A.trip_name = t.trip_name
    where t.trip_id = is_trip_available.trip_id;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'trip unavailable');

end;


create or replace procedure AddReservation(trip_id number, person_id number)
as
    new_res_id number;
begin
    person_exist(AddReservation.person_id);
    trip_exist(AddReservation.trip_id);
    is_trip_available(AddReservation.trip_id);

    insert into reservation
    values (default, AddReservation.trip_id, AddReservation.person_id, 'N')
    returning reservation_id into new_res_id;

    insert into log values (default, new_res_id, current_date, 'N');

end;


create or replace procedure reservation_exist(reservation_id number)
as
    tmp char(1);
begin

    select 1 into tmp from reservation R where R.reservation_id = reservation_exist.reservation_id;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'reservation not found');

end;


create or replace procedure ModifyReservationStatus(reservation_id number, status char)
as
    current_status char;
    trip_id        number;
begin
    reservation_exist(ModifyReservationStatus.reservation_id);

    select R.status
    into current_status
    from reservation R
    where R.reservation_id = ModifyReservationStatus.reservation_id;

    select R.trip_id
    into ModifyReservationStatus.trip_id
    from reservation R
    where R.reservation_id = ModifyReservationStatus.reservation_id;

    if ModifyReservationStatus.status not in ('N', 'P', 'C') then
        raise_application_error(-20001, 'wrong reservation status');
    end if;

--     if current status is 'C' and we want to change it, we have to check if there are any free places

    if current_status = 'C' and ModifyReservationStatus.status != 'C' then
        is_trip_available(ModifyReservationStatus.trip_id);
    end if;

    insert into log values (default, ModifyReservationStatus.reservation_id, current_date, current_status);

    update reservation R
    set R.status = ModifyReservationStatus.status
    where R.reservation_id = ModifyReservationStatus.reservation_id;

end;


create or replace procedure ModifyNoPlaces(trip_id number, no_places number)
as
    currplaces number;
begin
    trip_exist(ModifyNoPlaces.trip_id);

    select count(*)
    into currplaces
    from trip T
             inner join reservation R on R.trip_id = T.trip_id
    where T.trip_id = ModifyNoPlaces.trip_id
      and R.status != 'C';

    if ModifyNoPlaces.no_places < currplaces then
        raise_application_error(-20001, 'you can not reduce number of places');
    end if;

    update trip T
    set T.max_no_places = ModifyNoPlaces.no_places
    where T.trip_id = ModifyNoPlaces.trip_id;
end;


create or replace procedure AddReservation2(trip_id number, person_id number)
as
begin
    person_exist(AddReservation2.person_id);
    trip_exist(AddReservation2.trip_id);
    is_trip_available(AddReservation2.trip_id);

    insert into reservation
    values (default, AddReservation2.trip_id, AddReservation2.person_id, 'N');

end;


create or replace procedure ModifyReservationStatus2(reservation_id number, status char)
as
    current_status char;
    trip_id        number;
begin
    reservation_exist(ModifyReservationStatus2.reservation_id);

    select R.status
    into current_status
    from reservation R
    where R.reservation_id = ModifyReservationStatus2.reservation_id;

    select R.trip_id
    into ModifyReservationStatus2.trip_id
    from reservation R
    where R.reservation_id = ModifyReservationStatus2.reservation_id;

    if ModifyReservationStatus2.status not in ('N', 'P', 'C') then
        raise_application_error(-20001, 'wrong reservation status');
    end if;

--     if current status is 'C' and we want to change it, we have to check if there are any free places

    if current_status = 'C' and ModifyReservationStatus2.status != 'C' then
        is_trip_available(ModifyReservationStatus2.trip_id);
    end if;

    update reservation R
    set R.status = ModifyReservationStatus2.status
    where R.reservation_id = ModifyReservationStatus2.reservation_id;

end;


create or replace procedure update_trip
as
begin
    update trip T
    set T.no_available_places = T.max_no_places - (select count(*)
                                                   from reservation R
                                                   where R.trip_id = T.trip_id
                                                     and R.status != 'C');
end;


create or replace procedure is_trip_available4(trip_id number)
as
    tmp char(1);
begin

    select 1
    into tmp
    from trip T
    where t.trip_id = is_trip_available4.trip_id
      and t.no_available_places > 0
      and t.trip_date > current_date;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20001, 'trip unavailable');

end;


create or replace procedure AddReservation4(trip_id number, person_id number)
as
begin
    person_exist(AddReservation4.person_id);
    trip_exist(AddReservation4.trip_id);
    is_trip_available4(AddReservation4.trip_id);

    insert into reservation
    values (default, AddReservation4.trip_id, AddReservation4.person_id, 'N');

    update trip T
    set T.no_available_places = T.no_available_places - 1
    where AddReservation4.trip_id = T.trip_id;

end;


create or replace procedure ModifyReservationStatus4(reservation_id number, status char)
as
    current_status char;
    trip_id        number;
begin
    reservation_exist(ModifyReservationStatus4.reservation_id);

    select R.status
    into current_status
    from reservation R
    where R.reservation_id = ModifyReservationStatus4.reservation_id;

    select R.trip_id
    into ModifyReservationStatus4.trip_id
    from reservation R
    where R.reservation_id = ModifyReservationStatus4.reservation_id;

    if ModifyReservationStatus4.status not in ('N', 'P', 'C') then
        raise_application_error(-20001, 'wrong reservation status');
    end if;

--     if current status is 'C' and we want to change it, we have to check if there are any free places

    if current_status = 'C' and ModifyReservationStatus4.status != 'C' then
        is_trip_available4(ModifyReservationStatus4.trip_id);

        update trip T
        set T.no_available_places = T.no_available_places - 1
        where ModifyReservationStatus4.trip_id = T.trip_id;
    end if;

    if current_status != 'C' and ModifyReservationStatus4.status = 'C' then
        update trip T
        set T.no_available_places = T.no_available_places + 1
        where ModifyReservationStatus4.trip_id = T.trip_id;
    end if;

    update reservation R
    set R.status = ModifyReservationStatus4.status
    where R.reservation_id = ModifyReservationStatus4.reservation_id;

end;


create or replace procedure AddReservation5(trip_id number, person_id number)
as
begin
    person_exist(AddReservation5.person_id);
    trip_exist(AddReservation5.trip_id);
    is_trip_available4(AddReservation5.trip_id);

    insert into reservation
    values (default, AddReservation5.trip_id, AddReservation5.person_id, 'N');

end;


create or replace procedure ModifyReservationStatus5(reservation_id number, status char)
as
    current_status char;
    trip_id        number;
begin
    reservation_exist(ModifyReservationStatus5.reservation_id);

    select R.status
    into current_status
    from reservation R
    where R.reservation_id = ModifyReservationStatus5.reservation_id;

    select R.trip_id
    into ModifyReservationStatus5.trip_id
    from reservation R
    where R.reservation_id = ModifyReservationStatus5.reservation_id;

    if ModifyReservationStatus5.status not in ('N', 'P', 'C') then
        raise_application_error(-20001, 'wrong reservation status');
    end if;

--     if current status is 'C' and we want to change it, we have to check if there are any free places

    if current_status = 'C' and ModifyReservationStatus5.status != 'C' then
        is_trip_available4(ModifyReservationStatus5.trip_id);

        update trip T
        set T.no_available_places = T.no_available_places - 1
        where ModifyReservationStatus5.trip_id = T.trip_id;
    end if;

    update reservation R
    set R.status = ModifyReservationStatus5.status
    where R.reservation_id = ModifyReservationStatus5.reservation_id;

end;


create or replace procedure ModifyNoPlaces5(trip_id number, no_places number)
as
    currplaces number;
begin
    trip_exist(ModifyNoPlaces5.trip_id);

    select T.max_no_places - T.no_available_places
    into currplaces
    from trip T
    where T.trip_id = ModifyNoPlaces5.trip_id;

    if ModifyNoPlaces5.no_places < currplaces then
        raise_application_error(-20001, 'you can not reduce number of places');
    end if;

    update trip T
    set T.max_no_places = ModifyNoPlaces5.no_places
    where T.trip_id = ModifyNoPlaces5.trip_id;
end;

