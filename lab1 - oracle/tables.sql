create table person
(
    person_id int generated always as identity not null,
    firstname varchar(50),
    lastname  varchar(50),
    constraint person_pk primary key (person_id) enable
);


create table trip
(
    trip_id       int generated always as identity not null,
    trip_name     varchar(100),
    country_id    int,
    trip_date     date,
    max_no_places int,
    constraint trip_pk primary key (trip_id) enable
);


alter table trip
    add constraint trip_fk1 foreign key
        (country_id) references country (country_id) enable;


create table country
(
    country_id   int generated always as identity not null,
    country_name varchar(100),
    constraint country_pk primary key (country_id) enable
);


alter table country
    add constraint country_name_unique unique (country_name);

create table reservation
(
    reservation_id int generated always as identity not null,
    trip_id        int,
    person_id      int,
    status         char(1),
    constraint reservation_pk primary key (reservation_id) enable
);


alter table reservation
    add constraint reservation_fk1 foreign key
        (person_id) references person (person_id) enable;


alter table reservation
    add constraint reservation_fk2 foreign key
        (trip_id) references trip (trip_id) enable;


alter table reservation
    add constraint reservation_chk1 check
        (status in ('N', 'P', 'C')) enable;


create table log
(
    log_id         int generated always as identity not null,
    reservation_id int                              not null,
    log_date       date                             not null,
    status         char(1),
    constraint log_pk primary key (log_id) enable
);


alter table log
    add constraint log_chk1 check
        (status in ('N', 'P', 'C')) enable;


alter table log
    add constraint log_fk1 foreign key
        (reservation_id) references reservation (reservation_id) enable;

insert into country(country_name)
values ('Francja');


insert into country(country_name)
values ('Niemcy');


insert into country(country_name)
values ('Polska');


insert into trip(trip_name, country_id, trip_date, max_no_places)
values ('Wyciasdasdeczka do Paryża', 1, '2022-12-20', 40);


insert into trip(trip_name, country_id, trip_date, max_no_places)
values ('Piękny Kraków', 3, '2023-02-21', 10);


insert into trip(trip_name, country_id, trip_date, max_no_places)
values ('Piękniejszy Rzeszów', 3, '2022-10-27', 5);


insert into trip(trip_name, country_id, trip_date, max_no_places)
values ('Tu nie ma miejsc', 2, '2023-03-11', 0);


insert into person(firstname, lastname)
values ('Marcin', 'Najman');


insert into person(firstname, lastname)
values ('Janek', 'Stawarz');


insert into reservation(trip_id, person_id, status)
values (21, 1, 'C');
