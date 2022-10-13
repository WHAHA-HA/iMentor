-- maintenanc-y things here...
alter table tasks_period rename to tasks_ratings_period;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE tasks_announcement (
    id SERIAL not null,
    announcement_description TEXT not null default 'UNSET',
    announcement_html TEXT not null default 'UNSET',
    start_date TIMESTAMP without time zone NOT NULL default (NOW() AT TIME ZONE 'utc'),
    end_date TIMESTAMP without time zone NOT NULL default (NOW() AT TIME ZONE 'utc'),
    is_active BOOLEAN NOT NULL default true,
    PRIMARY KEY (id)
);

CREATE SEQUENCE tasks_announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE tasks_announcement_id_seq OWNED BY tasks_announcement.id;
ALTER TABLE ONLY tasks_announcement ALTER COLUMN id SET DEFAULT nextval('tasks_announcement_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE tasks_announcement_ack (
    id SERIAL not null,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES iuser_user (id),
    user_acked_date TIMESTAMP without time zone NOT NULL default (NOW() AT TIME ZONE 'utc'),
    announcement_id INTEGER NOT NULL,
    FOREIGN KEY (announcement_id) REFERENCES tasks_announcement (id),
    PRIMARY KEY (id)
);

CREATE SEQUENCE tasks_announcement_ack_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE tasks_announcement_ack_id_seq OWNED BY tasks_announcement_ack.id;
ALTER TABLE ONLY tasks_announcement_ack ALTER COLUMN id SET DEFAULT nextval('tasks_announcement_ack_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE tasks_announcement_localization (
    id SERIAL not null,
    partner_id INTEGER default NULL,
    FOREIGN KEY (partner_id) REFERENCES partners_partner (id),
    member_id INTEGER default NULL,
    FOREIGN KEY (member_id) REFERENCES member_member (id),
    role_id numeric CHECK (role_id > 0), CHECK (role_id < 7),
    announcement_id INTEGER NOT NULL,
    FOREIGN KEY (announcement_id) REFERENCES tasks_announcement (id),
    PRIMARY KEY (id)
);

CREATE SEQUENCE tasks_announcement_localization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE tasks_announcement_localization_id_seq OWNED BY tasks_announcement_localization.id;
ALTER TABLE ONLY tasks_announcement_localization ALTER COLUMN id SET DEFAULT nextval('tasks_announcement_localization_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
