--
-- forms_form:: forms for member sites: forms_form_member_site, who can edit: forms_form_role
--          \
--      forms_section:: sections of forms
--            \ 
--        forms_section_question:: questions in sections
--              \ 
--          forms_section_answer:: potential answers for questions
--
--
-- forms_form_copy:: users' form, one user and member site. who can edit: forms_form_role_copy
--          \
--      forms_section_copy:: users' section, one member site.
--            \ 
--        forms_section_question_copy :: users' question
--              \ 
--          forms_section_answer_copy :: users' potential answers
--
--
-- Answers have a foreign key to questions, questions to sections, and sections to forms.
--
-- User responses contain user-provided answers. Answers contain potential answers,if
-- there are any, for the corresponding question.
--

CREATE TABLE forms_form (
	id SERIAL NOT NULL, 
        copied_from_id INTEGER DEFAULT 0,
	description TEXT NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT true,
	PRIMARY KEY (id)
);


CREATE SEQUENCE forms_form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE forms_form_id_seq OWNED BY forms_form.id;

ALTER TABLE ONLY forms_form ALTER COLUMN id SET DEFAULT nextval('forms_form_id_seq'::regclass);

ALTER TABLE ONLY forms_form
    ADD CONSTRAINT forms_form_pkey PRIMARY KEY (id);

CREATE TABLE forms_form_member_site (
	id SERIAL NOT NULL, 
	member_site_id INTEGER NOT NULL DEFAULT 0, 
	form_id INTEGER NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	FOREIGN KEY(member_site_id) REFERENCES member_member (id), 
	FOREIGN KEY(form_id) REFERENCES forms_form (id)
);

CREATE TABLE forms_form_role_can_modify (
	id SERIAL NOT NULL, 
	form_id INTEGER NOT NULL DEFAULT 0, 
	role_id_can_modify INTEGER NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	FOREIGN KEY(role_id_can_modify) REFERENCES iuser_usertype (id),
	FOREIGN KEY(form_id) REFERENCES forms_form (id)
);

CREATE TABLE forms_form_role_can_answer (
	id SERIAL NOT NULL, 
	form_id INTEGER NOT NULL DEFAULT 0, 
	role_id_can_answer INTEGER NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	FOREIGN KEY(role_id_can_answer) REFERENCES iuser_usertype (id),
	FOREIGN KEY(form_id) REFERENCES forms_form (id)
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section (
	id SERIAL NOT NULL, 
	ordinal INTEGER NOT NULL DEFAULT 0, 
	is_active BOOLEAN NOT NULL DEFAULT true,
        copied_from_id INTEGER DEFAULT 0,
	description TEXT NOT NULL, 
	form_id INTEGER NOT NULL DEFAULT 0, 
	-- section_id INTEGER NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	FOREIGN KEY(form_id) REFERENCES forms_form (id)
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section_question (
	id SERIAL NOT NULL, 
	is_active BOOLEAN NOT NULL DEFAULT true,
        copied_from_id INTEGER DEFAULT 0,
	weighted_val INTEGER NOT NULL DEFAULT 0, 
	is_required BOOLEAN NOT NULL DEFAULT false,
	is_visible BOOLEAN NOT NULL DEFAULT true, 
	is_immutable BOOLEAN NOT NULL DEFAULT false, 
	dependent_on_question_id INTEGER DEFAULT NULL,
	dependent_on_noanswer_question_id INTEGER DEFAULT NULL, 
	if_answered_goto_question INTEGER DEFAULT NULL, 
	answer_matches_goto_question TEXT DEFAULT NULL, 
	section_id INTEGER NOT NULL DEFAULT 0, 
	ordinal INTEGER NOT NULL DEFAULT 0, 
	sub_ordinal INTEGER NOT NULL DEFAULT 0, 
	question_type INTEGER NOT NULL DEFAULT 0, 
	question_text TEXT NOT NULL DEFAULT 'NULL', 
	PRIMARY KEY (id), 
	FOREIGN KEY(dependent_on_question_id) REFERENCES forms_section_question (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(dependent_on_noanswer_question_id) REFERENCES forms_section_question (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(if_answered_goto_question) REFERENCES forms_section_question (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(section_id) REFERENCES forms_section (id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


CREATE TABLE forms_section_answer (
	id SERIAL NOT NULL, 
	is_active BOOLEAN NOT NULL DEFAULT true,
        copied_from_id INTEGER DEFAULT 0,
	ordinal INTEGER NOT NULL DEFAULT 0, 
	question_id INTEGER NOT NULL DEFAULT 0, 
	is_immutable BOOLEAN NOT NULL DEFAULT false, 
	answer_text TEXT DEFAULT NULL, 
	answer_char VARCHAR(500) DEFAULT NULL, 
	answer_bool BOOLEAN DEFAULT NULL, 
	answer_int INTEGER DEFAULT NULL,
	answer_datetime TIMESTAMP DEFAULT NULL,
	is_from_query BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	FOREIGN KEY(question_id) REFERENCES forms_section_question (id)
);


CREATE TABLE forms_answer_dependency (
	id SERIAL NOT NULL, 
        question_id INTEGER NOT NULL DEFAULT 0,
	dependent_on_answer_id_for_question_id INTEGER DEFAULT NULL, 
	dependent_on_answer_value_for_question_id TEXT DEFAULT NULL, 
	and_or TEXT DEFAULT 'OR', 
	PRIMARY KEY (id),
	FOREIGN KEY(dependent_on_answer_id_for_question_id) REFERENCES forms_section_answer (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(question_id) REFERENCES forms_section_question (id) DEFERRABLE INITIALLY DEFERRED
);


-- User Portion ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_form_copy (
	id SERIAL NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT true,
	parent_id INTEGER DEFAULT NULL, 
	user_id INTEGER NOT NULL DEFAULT 0,
	persona_id INTEGER NOT NULL DEFAULT 0,
	member_site_id INTEGER NOT NULL DEFAULT 0,
	description TEXT NOT NULL,
        form_was_completed BOOLEAN DEFAULT False,
	form_was_completed_datetime TIMESTAMP DEFAULT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(parent_id) REFERENCES forms_form (id), 
	FOREIGN KEY(user_id) REFERENCES iuser_user (id), 
	FOREIGN KEY(persona_id) REFERENCES iuser_persona (id), 
	FOREIGN KEY(member_site_id) REFERENCES member_member (id)
);



CREATE TABLE forms_form_role_can_modify_copy (
	id SERIAL NOT NULL,
	--section_id INTEGER NOT NULL DEFAULT 0,
	form_id INTEGER NOT NULL DEFAULT 0,
	role_id_can_modify INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY(form_id) REFERENCES forms_form_copy (id),
	FOREIGN KEY(role_id_can_modify) REFERENCES iuser_usertype (id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section_copy (
	id SERIAL NOT NULL,
	ordinal INTEGER NOT NULL DEFAULT 0, 
	is_active BOOLEAN NOT NULL DEFAULT true,
	user_id INTEGER NOT NULL DEFAULT 0,
	persona_id INTEGER NOT NULL DEFAULT 0,
	parent_id INTEGER DEFAULT NULL,
	form_id INTEGER NOT NULL DEFAULT 0,
	member_site_id INTEGER NOT NULL DEFAULT 0,
	description TEXT NOT NULL, 
	PRIMARY KEY (id),
	FOREIGN KEY(user_id) REFERENCES iuser_user (id),
	FOREIGN KEY(persona_id) REFERENCES iuser_persona (id), 
	FOREIGN KEY(member_site_id) REFERENCES member_member (id),
	FOREIGN KEY(parent_id) REFERENCES forms_section (id),
	FOREIGN KEY(form_id) REFERENCES forms_form_copy (id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section_question_copy (
	id SERIAL NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT true,
	user_id INTEGER NOT NULL DEFAULT 0,
	persona_id INTEGER NOT NULL DEFAULT 0,
	parent_id INTEGER DEFAULT NULL,
	member_site_id INTEGER NOT NULL DEFAULT 0,
	weighted_val INTEGER NOT NULL DEFAULT 0,
	is_required BOOLEAN NOT NULL DEFAULT false,
	is_visible BOOLEAN NOT NULL DEFAULT true,
	is_immutable BOOLEAN NOT NULL DEFAULT false,
	dependent_on_question_id INTEGER DEFAULT NULL,
	dependent_on_noanswer_question_id INTEGER DEFAULT NULL,
	if_answered_goto_question INTEGER default NULL,
	answer_matches_goto_question TEXT DEFAULT NULL,
	section_id INTEGER NOT NULL DEFAULT 0,
	ordinal INTEGER NOT NULL DEFAULT 0,
	sub_ordinal INTEGER NOT NULL DEFAULT 0,
	question_type INTEGER NOT NULL DEFAULT 0,
	question_text TEXT NOT NULL DEFAULT 'NULL',
	PRIMARY KEY (id),
	FOREIGN KEY(user_id) REFERENCES iuser_user (id),
	FOREIGN KEY(persona_id) REFERENCES iuser_persona (id), 
	FOREIGN KEY(member_site_id) REFERENCES member_member (id),
	FOREIGN KEY(parent_id) REFERENCES forms_section_question (id),
	FOREIGN KEY(dependent_on_question_id) REFERENCES forms_section_question_copy (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(dependent_on_noanswer_question_id) REFERENCES forms_section_question_copy (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(if_answered_goto_question) REFERENCES forms_section_question_copy (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(section_id) REFERENCES forms_section_copy (id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section_answer_copy (
	id SERIAL NOT NULL,
	is_active BOOLEAN NOT NULL DEFAULT true,
	ordinal INTEGER NOT NULL DEFAULT 0,
	question_id INTEGER DEFAULT 0,
	is_immutable BOOLEAN NOT NULL DEFAULT false,
	user_id INTEGER NOT NULL DEFAULT 0,
	persona_id INTEGER NOT NULL DEFAULT 0,
	parent_id INTEGER DEFAULT NULL,
	member_site_id INTEGER DEFAULT 0,
	answer_text TEXT,
	answer_char VARCHAR(500),
	answer_bool BOOLEAN,
	answer_int INTEGER,
	answer_datetime TIMESTAMP DEFAULT NULL,
	is_from_query BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY (id),
	FOREIGN KEY(question_id) REFERENCES forms_section_question_copy (id),
	FOREIGN KEY(user_id) REFERENCES iuser_user (id),
	FOREIGN KEY(persona_id) REFERENCES iuser_persona (id), 
	FOREIGN KEY(member_site_id) REFERENCES member_member (id),
	FOREIGN KEY(parent_id) REFERENCES forms_section_answer (id)
);


CREATE TABLE forms_answer_dependency_copy (
	id SERIAL NOT NULL, 
	parent_id INTEGER DEFAULT NULL, 
        question_id INTEGER NOT NULL DEFAULT 0,
	dependent_on_answer_id_for_question_id INTEGER DEFAULT NULL, 
	dependent_on_answer_value_for_question_id TEXT DEFAULT NULL, 
	and_or TEXT DEFAULT 'OR', 
	PRIMARY KEY (id),
	FOREIGN KEY(parent_id) REFERENCES forms_answer_dependency (id), 
	FOREIGN KEY(dependent_on_answer_id_for_question_id) REFERENCES forms_section_answer_copy (id) DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY(question_id) REFERENCES forms_section_question_copy (id) DEFERRABLE INITIALLY DEFERRED
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE forms_section_user_response (
	id SERIAL NOT NULL,
	user_id INTEGER NOT NULL DEFAULT 0,
	question_id INTEGER DEFAULT 0,
	answer_id INTEGER DEFAULT NULL,
        selected_id INTEGER DEFAULT NULL,
        user_response TEXT,
	PRIMARY KEY (id),
	FOREIGN KEY(user_id) REFERENCES iuser_user (id),
	FOREIGN KEY(question_id) REFERENCES forms_section_question_copy (id),
	FOREIGN KEY(answer_id) REFERENCES forms_section_answer_copy (id)
);


