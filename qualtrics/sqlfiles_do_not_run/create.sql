alter table iuser_qualtrics_surveys rename to old_user_qualtrics_surveys;
alter table qualtrics_ids rename to old_qualtrics_ids;

-- --------------------------------------------------------
DROP TABLE IF EXISTS qualtrics_library_panel cascade;
DROP SEQUENCE IF EXISTS qualtrics_library_panel_id_seq;

CREATE TABLE qualtrics_library_panel (
  id SERIAL NOT NULL,
  library_string TEXT NOT NULL,
  panel_string TEXT NOT NULL,
  record_is_active BOOLEAN NOT NULL default True,
  PRIMARY KEY (id)
);

CREATE SEQUENCE qualtrics_library_panel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE qualtrics_library_panel_id_seq OWNED BY qualtrics_library_panel.id;

ALTER TABLE ONLY qualtrics_library_panel ALTER COLUMN id SET DEFAULT nextval('qualtrics_library_panel_id_seq'::regclass);

alter table qualtrics_library_panel add constraint composite_qualtrics_library_panel_library_panel_key unique(library_string,panel_string);

insert into qualtrics_library_panel (library_string,panel_string) values ('GR_72qpYD0dtt1P9uR','ML_3aWU0pIijbKCzMp');

-- --------------------------------------------------------
DROP TABLE IF EXISTS qualtrics_survey cascade;
DROP SEQUENCE IF EXISTS qualtrics_survey_id_seq;

CREATE TABLE qualtrics_survey (
  id SERIAL NOT NULL,
  description TEXT NOT NULL,
  member_id INTEGER DEFAULT NULL,
  library_string TEXT NOT NULL,
  panel_string TEXT NOT NULL,
  distribution_string TEXT NOT NULL DEFAULT 'BAD VALUE',
  survey_string TEXT NOT NULL DEFAULT 'BAD VALUE',
  survey_is_active BOOLEAN DEFAULT true,
  user_type INTEGER NOT NULL,
  start_date date NOT NULL DEFAULT CURRENT_DATE,
  end_date date DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY(member_id) REFERENCES member_member (id)
);

CREATE SEQUENCE qualtrics_survey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE qualtrics_survey_id_seq OWNED BY qualtrics_survey.id;

ALTER TABLE ONLY qualtrics_survey ALTER COLUMN id SET DEFAULT nextval('qualtrics_survey_id_seq'::regclass);

alter table qualtrics_survey add constraint composite_qualtrics_survey_role_survey_key unique(survey_string,user_type);

-- --------------------------------------------------------
DROP TABLE IF EXISTS qualtrics_invite cascade;
DROP SEQUENCE IF EXISTS qualtrics_invite_id_seq;

CREATE TABLE qualtrics_invite (
  id SERIAL NOT NULL,
  persona_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  invited_by_user_id INTEGER NOT NULL,
  survey_id integer NOT NULL,
  survey_status INTEGER NOT NULL,
  date_invited date NOT NULL DEFAULT CURRENT_DATE,
  last_modified date default null,
  survey_link TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
  FOREIGN KEY(user_id) REFERENCES iuser_user (id),
  FOREIGN KEY(survey_id) REFERENCES qualtrics_survey (id),
  FOREIGN KEY(invited_by_user_id) REFERENCES iuser_user (id)
);

CREATE SEQUENCE qualtrics_invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE qualtrics_invite_id_seq OWNED BY qualtrics_invite.id;

ALTER TABLE ONLY qualtrics_invite ALTER COLUMN id SET DEFAULT nextval('qualtrics_invite_id_seq'::regclass);

alter table qualtrics_invite add constraint composite_qualtrics_invite_user_invite_key unique(user_id,survey_link);

