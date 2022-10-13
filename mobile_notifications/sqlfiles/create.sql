drop table if exists mobile_push_notification;
drop sequence if exists mobile_push_notification_id_seq;

drop table if exists mobile_push_device;
drop sequence if exists mobile_push_device_id_seq;

CREATE TABLE mobile_push_device (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        push_token TEXT NOT NULL DEFAULT 'No Value',
        badge INTEGER NOT NULL DEFAULT 0,
        device_notes TEXT DEFAULT NULL,
        device_type TEXT DEFAULT NULL,
        active BOOLEAN NOT NULL DEFAULT TRUE,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE mobile_push_device_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE mobile_push_device_id_seq OWNED BY mobile_push_device.id;
ALTER TABLE ONLY mobile_push_device ALTER COLUMN id SET DEFAULT nextval('mobile_push_device_id_seq'::regclass);
ALTER TABLE mobile_push_device ADD CONSTRAINT composite__user_id__token unique(user_id,push_token,device_type);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
CREATE TABLE mobile_push_notification (
        id SERIAL NOT NULL,
        push_device_id INTEGER NOT NULL DEFAULT 0,
        message TEXT DEFAULT NULL,
        badge_value INTEGER NOT NULL DEFAULT 0,
        sound TEXT DEFAULT NULL,
        push_datetime TIMESTAMP DEFAULT NULL, -- Notice no time zone
        FOREIGN KEY(push_device_id) REFERENCES mobile_push_device (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE mobile_push_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE mobile_push_notification_id_seq OWNED BY mobile_push_notification.id;
ALTER TABLE ONLY mobile_push_notification ALTER COLUMN id SET DEFAULT nextval('mobile_push_notification_id_seq'::regclass);

