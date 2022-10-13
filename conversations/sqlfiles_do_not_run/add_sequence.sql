ALTER TABLE ONLY conversation ADD COLUMN visible BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE ONLY conversation ADD COLUMN sequence INTEGER NOT NULL DEFAULT 0;
CREATE INDEX idx_sequence ON conversation USING btree (sequence);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drop table if exists conversation_latest_poll;
drop sequence if exists conversation_latest_poll_id_seq;

CREATE TABLE conversation_latest_poll (
        id SERIAL NOT NULL,
        user_id INTEGER UNIQUE NOT NULL DEFAULT 0,
        latest_poll_timestamp BIGINT NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE conversation_latest_poll_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE conversation_latest_poll_id_seq OWNED BY conversation_latest_poll.id;
ALTER TABLE ONLY conversation_latest_poll ALTER COLUMN id SET DEFAULT nextval('conversation_latest_poll_id_seq'::regclass);
