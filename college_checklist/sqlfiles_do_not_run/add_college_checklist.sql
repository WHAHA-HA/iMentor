-- PICK_TYPES = (
--     ('1','Safety'),
--     ('2','Target'),
--     ('3','Reach')
--     )

-- ALL 0 values below mean the variable has not yet been set.

CREATE TABLE college_checklist (
	id integer NOT NULL PRIMARY KEY,
        college_id integer NOT NULL DEFAULT 0,
        user_id integer NOT NULL DEFAULT 0,
	app_deadline date DEFAULT NULL,
	app_completion integer NOT NULL DEFAULT 0, -- Y/N (don't make this Boolean)
	app_review integer NOT NULL DEFAULT 0,     -- Y/N/Not applicable from here down.
	app_submission date DEFAULT NULL,
	fee_payment integer NOT NULL DEFAULT 0,
	transcript_submission integer NOT NULL DEFAULT 0,
	test_submission integer NOT NULL DEFAULT 0,
	essay_submission integer NOT NULL DEFAULT 0,
	recommendation_submission integer NOT NULL DEFAULT 0,
	fafsa_submission integer NOT NULL DEFAULT 0,
        category integer NOT NULL DEFAULT 0,
        result integer NOT NULL DEFAULT 0,
        choice integer NOT NULL DEFAULT 0,
        CHECK (app_completion > -1 and app_completion < 3),
        CHECK (app_review > -1 and app_review < 4),
        CHECK (fee_payment > -1 and fee_payment < 4),
        CHECK (transcript_submission > -1 and transcript_submission < 4),
        CHECK (test_submission > -1 and test_submission < 4),
        CHECK (essay_submission > -1 and essay_submission < 4),
        CHECK (recommendation_submission > -1 and recommendation_submission < 4),
        CHECK (fafsa_submission > -1 and fafsa_submission < 4),
        CHECK (category > -1 AND category < 4), --target/safety/reach
        CHECK (result > -1 AND result < 4), --accepted/rejected/waitlisted
        CHECK (choice > -1 AND choice < 3) --going/not going (don't make boolean)
);

CREATE SEQUENCE college_checklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE college_checklist_id_seq OWNED BY college_checklist.id;

ALTER TABLE ONLY college_checklist ALTER COLUMN id SET DEFAULT nextval('college_checklist_id_seq'::regclass);


ALTER TABLE ONLY college_checklist
    ADD CONSTRAINT college_checklist_college_id FOREIGN KEY (college_id) REFERENCES utils_college(id);

ALTER TABLE ONLY college_checklist
    ADD CONSTRAINT college_checklist_user_id FOREIGN KEY (user_id) REFERENCES iuser_user(id);



