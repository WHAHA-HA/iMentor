drop table if exists safety_phrase;
drop sequence if exists safety_phrase_id_seq;

drop table if exists safety_word_contact;
drop sequence if exists safety_word_contact_id_seq;

drop table if exists safety_word_source;
drop sequence if exists safety_word_source_id_seq;

drop table if exists safety_check_tracking;
drop sequence if exists safety_check_tracking_id_seq;

CREATE TABLE safety_word_source (
        id SERIAL NOT NULL,
        name VARCHAR(300) not null default 'Not Set',
        PRIMARY KEY (id)
);


CREATE SEQUENCE safety_word_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE safety_word_source_id_seq OWNED BY safety_word_source.id;
ALTER TABLE ONLY safety_word_source ALTER COLUMN id SET DEFAULT nextval('safety_word_source_id_seq'::regclass);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
CREATE TABLE safety_word_contact (
        id SERIAL NOT NULL,
        alert_recipient_user_id INTEGER DEFAULT NULL,
        additional_recipient_emails TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);


CREATE SEQUENCE safety_word_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE safety_word_contact_id_seq OWNED BY safety_word_contact.id;
ALTER TABLE ONLY safety_word_contact ALTER COLUMN id SET DEFAULT nextval('safety_word_contact_id_seq'::regclass);
ALTER TABLE safety_word_contact ADD CONSTRAINT composite__alert_recipient_user_id__additional_recipient_emails unique(alert_recipient_user_id,additional_recipient_emails);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
-- ALERT_FREQUENCY_HOURLY = 1
-- ALERT_FREQUENCY_DAILY  = 2
-- see models.py for details

CREATE TABLE safety_phrase (
        id SERIAL NOT NULL,
        word_or_phrase VARCHAR(200) NOT NULL DEFAULT 'Not Set',
        word_source_id INTEGER NOT NULL DEFAULT 0,
        member_site_id INTEGER DEFAULT NULL,
        partner_site_id INTEGER DEFAULT NULL,
        alert_user_info_id INTEGER DEFAULT NULL, --  NULL = all member sites, no addt'l emails
        alert_frequency INTEGER NOT NULL DEFAULT 2,
        FOREIGN KEY(word_source_id) REFERENCES safety_word_source (id),
        FOREIGN KEY(member_site_id) REFERENCES member_member (id),
        FOREIGN KEY(partner_site_id) REFERENCES partners_partner (id),
        FOREIGN KEY(alert_user_info_id) REFERENCES safety_word_contact (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE safety_phrase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE safety_phrase_id_seq OWNED BY safety_phrase.id;
ALTER TABLE ONLY safety_phrase ALTER COLUMN id SET DEFAULT nextval('safety_phrase_id_seq'::regclass);
ALTER TABLE safety_phrase ADD CONSTRAINT composite__word_or_phrase__member_site_id__partner_site_id unique(word_or_phrase,member_site_id,partner_site_id);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
-- SAFETY_CHECK_CANVAS        =1
-- SAFETY_CHECK_PORTFOLIO     =2
-- SAFETY_CHECK_CONVERSATIONS =3

CREATE TABLE safety_check_tracking (
        id SERIAL NOT NULL,
        app INTEGER NOT NULL DEFAULT 0,
        frequency INTEGER NOT NULL DEFAULT 0,
        epoch_time_last_checked BIGINT NOT NULL DEFAULT 0,
        PRIMARY KEY (id)
);


CREATE SEQUENCE safety_check_tracking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE safety_check_tracking_id_seq OWNED BY safety_check_tracking.id;
ALTER TABLE ONLY safety_check_tracking ALTER COLUMN id SET DEFAULT nextval('safety_check_tracking_id_seq'::regclass);
ALTER TABLE safety_check_tracking ADD CONSTRAINT composite_app_freq_key unique(app,frequency);
