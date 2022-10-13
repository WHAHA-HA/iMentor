CREATE OR REPLACE FUNCTION count_not_nulls(variadic p_array anyarray)
RETURNS BIGINT AS
$$
    SELECT count(x) FROM unnest($1) AS x
$$ LANGUAGE SQL IMMUTABLE;

--uncomment me if you need replace the existing table!
DROP TABLE IF EXISTS sms_invalid_response;
DROP TABLE IF EXISTS sms_message;
DROP TABLE IF EXISTS sms_stop;

CREATE TABLE sms_stop (
    id SERIAL NOT NULL, 
    user_id INTEGER DEFAULT NULL,
    from_phone CHARACTER(12) DEFAULT NULL, 
    date_stopped TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc'),
    FOREIGN KEY(user_id) REFERENCES iuser_user (id)
    );

CREATE SEQUENCE sms_stop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE sms_stop_id_seq OWNED BY sms_stop.id;
ALTER TABLE ONLY sms_stop ALTER COLUMN id SET DEFAULT nextval('sms_stop_id_seq'::regclass);


CREATE TABLE sms_message (
    id SERIAL NOT NULL, 
    text TEXT NOT NULL DEFAULT '', 
    date_sent TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc'),
    to_phone CHARACTER(10) DEFAULT NULL, 
    from_phone CHARACTER(12) DEFAULT NULL, 
    admin_id INTEGER DEFAULT NULL,

    -- one of these must be present
    sender_id INTEGER DEFAULT NULL,
    recipient_id INTEGER DEFAULT NULL,

    -- both of these must be present or neither present
    foreign_table_name CHARACTER(256) DEFAULT NULL,
    foreign_table_id INTEGER DEFAULT NULL,

    sid CHARACTER(34) NOT NULL DEFAULT '', 
    created TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc'),
    updated TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc'),
    parent_id INTEGER DEFAULT NULL,

    FOREIGN KEY(sender_id) REFERENCES iuser_user (id), 
    FOREIGN KEY(recipient_id) REFERENCES iuser_user (id), 
    FOREIGN KEY(admin_id) REFERENCES iuser_user (id), 
    PRIMARY KEY (id),

    CONSTRAINT ensure_sender_or_recipient CHECK (count_not_nulls(sender_id, recipient_id) > 0),
    CONSTRAINT valid_generic_fk CHECK (foreign_table_name is not null and foreign_table_id is not null or foreign_table_name is null and foreign_table_id is null)
);

CREATE SEQUENCE sms_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE sms_message_id_seq OWNED BY sms_message.id;
ALTER TABLE ONLY sms_message ALTER COLUMN id SET DEFAULT nextval('sms_message_id_seq'::regclass);

CREATE TABLE sms_invalid_response (
    id SERIAL NOT NULL, 
    response CHARACTER(160) NOT NULL DEFAULT '', 
    date_received TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc'),
    message_id INTEGER DEFAULT NULL,
    FOREIGN KEY(message_id) REFERENCES sms_message (id)
);

CREATE SEQUENCE sms_invalid_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE sms_invalid_response_id_seq OWNED BY sms_invalid_response.id;
ALTER TABLE ONLY sms_invalid_response ALTER COLUMN id SET DEFAULT nextval('sms_invalid_response_id_seq'::regclass);


COMMENT ON COLUMN sms_message.id is 'Primary key';
COMMENT ON COLUMN sms_message.text is 'Text of SMS message';
COMMENT ON COLUMN sms_message.date_sent is 'Date SMS message sent';
COMMENT ON COLUMN sms_message.to_phone is 'Phone number of recipient';
COMMENT ON COLUMN sms_message.from_phone is 'Phone number of sender';
COMMENT ON COLUMN sms_message.admin_id is 'Admin user that sent message';
COMMENT ON COLUMN sms_message.sender_id is 'User that sent message';
COMMENT ON COLUMN sms_message.recipient_id is 'User that received that message';
COMMENT ON COLUMN sms_message.foreign_table_name is 'Associated table';
COMMENT ON COLUMN sms_message.foreign_table_id is 'ID of row in associated table';
COMMENT ON COLUMN sms_message.sid is 'Unique identifier for SMS message';
COMMENT ON COLUMN sms_message.created is '';
COMMENT ON COLUMN sms_message.updated is '';
COMMENT ON COLUMN sms_message.parent_id is 'Message that this message is a response to';



-- TESTS

-- test insert valid sms_message
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', 1, 2, null, null, '', null);

-- test insert valid sms_message w/ foreign table
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', 1, 2, 'some_table', 1, '', null);

-- test insert valid sms_message w/ sender only
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', 1, null, 'some_table', 1, '', null);

-- test insert valid sms_message w/ recipient only
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', null, 2, 'some_table', 1, '', null);

-- test validation error for missing id for foreign table 
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', 1, 2, 'some_table', null, '', null);

-- test validation error for missing name for foreign table
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', 1, 2, null, 5, '', null);

-- test validation error for missing both recipient and sender 
-- insert into sms_message (text, to_phone, from_phone, sender_id, recipient_id, foreign_table_name, foreign_table_id, sid, parent_id)  values ('hello', '5555555555', '5555555555', null, null, null, null, '', null);
