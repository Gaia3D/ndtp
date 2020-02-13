drop table if exists struct_permission cascade;

CREATE TABLE struct_permission (
    perm_seq int4 NOT NULL,
    constructor varchar(50) NOT NULL,
    constructor_type varchar(50) NOT NULL,
    birthday varchar(50) NOT NULL,
    license_num varchar(50) NOT NULL,
    phone_number varchar(50) NOT NULL,
    is_complete varchar(1) NULL DEFAULT 'N',
    apply_date date NULL DEFAULT now()
);