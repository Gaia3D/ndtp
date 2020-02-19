drop table if exists comment_manage cascade;

CREATE TABLE comment_manage (
    comment_seq integer NOT NULL,
    writer varchar(255),
    object_name varchar(255),
    comment_title varchar(255),
    comment_content varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    height varchar(255),
    apply_date timestamp with time zone		default now()
);