create or replace view ReservationsDetails
            (country_name, trip_date, trip_name, firstname, lastname, reservation_id, status) as
select C.country_name, T.trip_date, T.trip_name, P.firstname, P.lastname, R.reservation_id, R.status
from trip T
         inner join country C on T.country_id = C.country_id
         inner join reservation R on T.trip_id = R.trip_id
         inner join person P on R.person_id = P.person_id;


create or replace view TripsDetails (country, trip_date, trip_name, no_places, no_available_places) as
select C.country_name, T.trip_date, T.trip_name, T.max_no_places, A.av_places
from trip T
         inner join AVAILABLEPLACES A on A.trip_id = T.trip_id
         inner join country C on C.country_id = T.country_id;


create or replace view AvailablePlaces (trip_id, av_places) as
select T.trip_id,
       T.max_no_places - (select count(R.reservation_id)
                          from reservation R
                          where R.trip_id = T.trip_id
                            and R.status != 'C')
from trip T;


create or replace view AvailableTrips (country, trip_date, trip_name, no_places, no_available_places) as
select *
from TripsDetails TD
where TD.no_available_places > 0
  and TD.trip_date > current_date;


create or replace view AvailableTripsNoDateCheck (country, trip_date, trip_name, no_places, no_available_places) as
select *
from TripsDetails TD
where TD.no_available_places > 0;


create or replace view TripsDetails4 (country, trip_date, trip_name, no_places, no_available_places) as
select C.country_name, T.trip_date, T.trip_name, T.max_no_places, T.no_available_places
from trip T
         inner join country C on C.country_id = T.country_id;


create or replace view AvailableTrips4 (country, trip_date, trip_name, no_places, no_available_places) as
select *
from TripsDetails4 TD
where TD.no_available_places > 0
  and TD.trip_date > current_date;
