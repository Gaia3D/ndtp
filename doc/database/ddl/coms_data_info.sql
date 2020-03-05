drop table if exists cons_data_info cascade;

create table cons_data_info
(
    data_name varchar,
    lon       real,
    lat       real,
    alt       real,
    heading   real,
    pitch     real,
    roll      real,
    step      varchar,
    ratio     int4
);