drop table if exists conversation;
drop sequence if exists conversation_id_seq;

CREATE TABLE conversation (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        recipient_user_id INTEGER NOT NULL DEFAULT 0,
        received_by_server TIMESTAMP DEFAULT NULL, -- Notice no time zone
        sent_to_recipient TIMESTAMP DEFAULT NULL, -- Notice no time zone
        admin_last_viewed TIMESTAMP DEFAULT NULL, -- Notice no time zone
        data TEXT DEFAULT NULL,
        word_count INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(recipient_user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE conversation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE conversation_id_seq OWNED BY conversation.id;
ALTER TABLE ONLY conversation ALTER COLUMN id SET DEFAULT nextval('conversation_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
drop table if exists conversation_auto_save;
drop sequence if exists conversation_auto_save_id_seq;

CREATE TABLE conversation_auto_save (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        recipient_user_id INTEGER NOT NULL DEFAULT 0,
        received_by_server TIMESTAMP DEFAULT NULL, -- Notice no time zone
        data TEXT DEFAULT NULL,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(recipient_user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE conversation_auto_save_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE conversation_auto_save_id_seq OWNED BY conversation_auto_save.id;
ALTER TABLE ONLY conversation_auto_save ALTER COLUMN id SET DEFAULT nextval('conversation_auto_save_id_seq'::regclass);

