CREATE TABLE mentee_readiness_school (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        school_attendance INTEGER NOT NULL DEFAULT 0,
        program_readiness INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id), 
        PRIMARY KEY (id)
);


CREATE SEQUENCE mentee_readiness_school_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE mentee_readiness_school_id_seq OWNED BY mentee_readiness_school.id;
ALTER TABLE ONLY mentee_readiness_school ALTER COLUMN id SET DEFAULT nextval('mentee_readiness_school_id_seq'::regclass);
