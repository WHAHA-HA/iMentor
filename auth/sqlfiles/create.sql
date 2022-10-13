CREATE TABLE iuser_uuid (
        id SERIAL NOT NULL,
        uuid uuid default NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE iuser_uuid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE iuser_uuid_id_seq OWNED BY iuser_uuid.id;
ALTER TABLE ONLY iuser_uuid ALTER COLUMN id SET DEFAULT nextval('iuser_uuid_id_seq'::regclass);
CREATE INDEX iuser_uuid_user_id_fkey ON iuser_uuid(user_id);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE iuser_token (
        id SERIAL NOT NULL,
        session_token TEXT default NULL,
        date_created TIMESTAMP default NULL,
        is_active BOOLEAN default true,
        user_id INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE iuser_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE iuser_token_id_seq OWNED BY iuser_token.id;
ALTER TABLE ONLY iuser_token ALTER COLUMN id SET DEFAULT nextval('iuser_token_id_seq'::regclass);
CREATE INDEX iuser_token_user_id_fkey ON iuser_token(user_id);
