drop table if exists user_live_session;
drop sequence if exists user_live_session_id_seq;
drop table if exists user_live_session_mobile;
drop sequence if exists user_live_session_mobile_id_seq;

CREATE TABLE user_live_session (
        id SERIAL NOT NULL,
        session_id TEXT UNIQUE not null default '',
        user_id INTEGER UNIQUE NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE user_live_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE user_live_session_id_seq OWNED BY user_live_session.id;
ALTER TABLE ONLY user_live_session ALTER COLUMN id SET DEFAULT nextval('user_live_session_id_seq'::regclass);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE user_live_session_mobile (
        id SERIAL NOT NULL,
        session_id TEXT UNIQUE not null default '',
        user_id INTEGER UNIQUE NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE user_live_session_mobile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE user_live_session_mobile_id_seq OWNED BY user_live_session_mobile.id;
ALTER TABLE ONLY user_live_session_mobile ALTER COLUMN id SET DEFAULT nextval('user_live_session_mobile_id_seq'::regclass);

