create or replace trigger add_or_modify_reservation_log_trigger
    after insert or update
    on reservation
    for each row
begin
    insert into log (reservation_id, log_date, status)
    values (:new.reservation_id, current_date, :new.status);
end;


create or replace trigger delete_reservation_trigger
    before delete
    on reservation
    for each row
begin
    raise_application_error(-20001, 'it is forbidden to remove reservation');
end;


create or replace trigger add_reservation_log_trigger2
    after insert
    on reservation
    for each row
begin
    insert into log (reservation_id, log_date, status)
    values (:new.reservation_id, current_date, :new.status);

    update trip T
    set T.no_available_places = T.no_available_places - 1
    where T.trip_id = :new.trip_id;
end;


create or replace trigger modify_reservation_log_trigger2
    after update
    on reservation
    for each row
declare
    to_add number;
begin
    insert into log (reservation_id, log_date, status)
    values (:new.reservation_id, current_date, :new.status);

    if :new.status = 'C' then
        to_add = 1;
    else
        to_add = 0;
    end if;

    update trip T
    set T.no_available_places = T.no_available_places + to_add
    where T.trip_id = :new.trip_id;
end;


create or replace trigger change_no_of_places_trigger
    after update of max_no_places
    on trip
    for each row
begin
    update trip T
    set T.no_available_places = T.no_available_places + (:new.max_no_places - T.max_no_places);
end;
