CREATE TABLE partners_session_curriculum (
        id SERIAL NOT NULL, 
        curr_id INTEGER NOT NULL DEFAULT 0,
        p_session_id INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(curr_id) REFERENCES canvas_curriculum (id), 
        FOREIGN KEY(p_session_id) REFERENCES partners_session (id), 
        PRIMARY KEY (id)
);


CREATE SEQUENCE partners_session_curriculum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE partners_session_curriculum_id_seq OWNED BY partners_session_curriculum.id;
ALTER TABLE ONLY partners_session_curriculum ALTER COLUMN id SET DEFAULT nextval('partners_session_curriculum_id_seq'::regclass);
ALTER TABLE partners_session_curriculum ADD CONSTRAINT partners_session_curriculum_composite_key unique(curr_id,p_session_id);

alter table canvas_set add column created_datetime timestamp default now();

