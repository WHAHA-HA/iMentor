drop table if exists file_upload_user_bin;
drop sequence if exists file_upload_user_bin_id_seq;

CREATE TABLE file_upload_user_bin (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL unique DEFAULT 0,
        bin_name VARCHAR(20) not null default 'Not Set',
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);

CREATE SEQUENCE file_upload_user_bin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE file_upload_user_bin_id_seq OWNED BY file_upload_user_bin.id;
ALTER TABLE ONLY file_upload_user_bin ALTER COLUMN id SET DEFAULT nextval('file_upload_user_bin_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drop table if exists file_upload_latest_bin_num;
drop sequence if exists file_upload_latest_bin_num_id_seq;

CREATE TABLE file_upload_latest_bin_num (
        id SERIAL NOT NULL,
        latest_bin_num INTEGER NOT NULL DEFAULT 1,
        PRIMARY KEY (id)
);

CREATE SEQUENCE file_upload_latest_bin_num_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE file_upload_latest_bin_num_id_seq OWNED BY file_upload_latest_bin_num.id;
ALTER TABLE ONLY file_upload_latest_bin_num ALTER COLUMN id SET DEFAULT nextval('file_upload_latest_bin_num_id_seq'::regclass);

insert into file_upload_latest_bin_num (latest_bin_num) values (1);
