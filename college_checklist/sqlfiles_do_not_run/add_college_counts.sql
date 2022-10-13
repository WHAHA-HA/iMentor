CREATE TABLE college_count (
    id integer NOT NULL,
    college_id integer NOT NULL DEFAULT 0,
    selected_by_mentees integer NOT NULL DEFAULT 0,
    selected_by_mentors integer NOT NULL DEFAULT 0
);

CREATE SEQUENCE college_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE college_count_id_seq OWNED BY college_count.id;

ALTER TABLE ONLY college_count ALTER COLUMN id SET DEFAULT nextval('college_count_id_seq'::regclass);

ALTER TABLE ONLY college_count
    ADD CONSTRAINT college_count_pkey PRIMARY KEY (id);

-- Add random number to guarantee uniqueness.
ALTER TABLE ONLY college_count
    ADD CONSTRAINT college_count_college_id FOREIGN KEY (college_id) REFERENCES utils_college(id);

CREATE INDEX college_count_selected_by_mentors ON college_count USING btree (selected_by_mentors);
CREATE INDEX college_count_selected_by_mentees ON college_count USING btree (selected_by_mentees);


