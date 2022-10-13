drop table if exists tasks_period;
drop table if exists tasks_ratings;

CREATE TABLE tasks_period (
    id SERIAL not null,
    frequency_month INTEGER DEFAULT '1' NOT NULL, 
    frequency_day INTEGER DEFAULT '0' NOT NULL, 
    frequency_hour INTEGER DEFAULT '0' NOT NULL, 
    frequency_minute INTEGER DEFAULT '0' NOT NULL, 
    start_date DATE NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (frequency_month, start_date)
);

CREATE SEQUENCE tasks_period_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE tasks_period_id_seq OWNED BY tasks_period.id;
ALTER TABLE ONLY tasks_period ALTER COLUMN id SET DEFAULT nextval('tasks_period_id_seq'::regclass);
alter table tasks_period add constraint composite_t_p_key unique(frequency_month,start_date);

-- -----------------------------------------------------------------------------------

CREATE TABLE tasks_ratings (
    id SERIAL not null,
    mentee_persona_id INTEGER NOT NULL, 
    mentor_persona_id INTEGER NOT NULL, 
    mentor_rating INTEGER DEFAULT NULL, 
    mentee_rating INTEGER DEFAULT NULL, 
    mentor_rated_on TIMESTAMP WITHOUT TIME ZONE, 
    mentee_rated_on TIMESTAMP WITHOUT TIME ZONE, 
    mentee_user_id INTEGER NOT NULL, 
    mentor_user_id INTEGER NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(mentee_persona_id) REFERENCES iuser_persona (id), 
    FOREIGN KEY(mentor_persona_id) REFERENCES iuser_persona (id), 
    FOREIGN KEY(mentee_user_id) REFERENCES iuser_user (id), 
    FOREIGN KEY(mentor_user_id) REFERENCES iuser_user (id)
);


CREATE SEQUENCE tasks_ratings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE tasks_ratings_id_seq OWNED BY tasks_ratings.id;
ALTER TABLE ONLY tasks_ratings ALTER COLUMN id SET DEFAULT nextval('tasks_ratings_id_seq'::regclass);


