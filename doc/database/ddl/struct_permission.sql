drop table if exists struct_permission cascade;

CREATE TABLE struct_permission (
    perm_seq integer NOT NULL,
    constructor varchar(50),
    constructor_type varchar(50),
    perm_officer varchar(50),
    birthday varchar(50),
    license_num varchar(50),
    phone_number varchar(50),
    is_complete varchar(1) DEFAULT 'N',
    latitude varchar(30),
    longitude varchar(30),
    apply_date date DEFAULT now()
);