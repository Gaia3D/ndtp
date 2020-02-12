drop table if exists struct_permission cascade;

CREATE TABLE public.struct_permission (
    perm_seq int4 NOT NULL,
    constructor varchar(50) NOT NULL,
    constructor_type varchar(50) NOT NULL,
    birthday varchar(50) NOT NULL,
    license_num varchar(50) NOT NULL,
    phone_number varchar(50) NOT NULL,
    is_complete varchar(1) NULL DEFAULT 'N',
    apply_date date NULL DEFAULT now()
);

CREATE SEQUENCE struct_permission_seq;
ALTER TABLE struct_permission ALTER COLUMN perm_seq SET DEFAULT nextval('struct_permission_seq');
ALTER SEQUENCE struct_permission_seq OWNED BY struct_permission.perm_seq;