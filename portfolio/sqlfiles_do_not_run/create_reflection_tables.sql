DROP TABLE IF EXISTS portfolio_reflection;
DROP SEQUENCE IF EXISTS portfolio_reflection_id_seq;
DROP TABLE IF EXISTS reflection_user_response;
DROP SEQUENCE IF EXISTS reflection_user_response_id_seq;
DROP TABLE IF EXISTS reflection_card;
DROP SEQUENCE IF EXISTS reflection_card_id_seq;
DROP TABLE IF EXISTS reflection_user_response_history;
DROP SEQUENCE IF EXISTS reflection_user_response_history_id_seq;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- NOT copied per user, all users see the same copy. Change history is not preserved.
CREATE TABLE portfolio_reflection_card (
    id integer NOT NULL PRIMARY KEY,
    grade_id integer NOT NULL DEFAULT 0,
    unit_id integer NOT NULL DEFAULT 0,
    mentor_card_html TEXT DEFAULT NULL,
    mentee_card_html TEXT DEFAULT NULL
);

CREATE SEQUENCE portfolio_reflection_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE portfolio_reflection_card_id_seq
OWNED BY portfolio_reflection_card.id;

ALTER TABLE ONLY portfolio_reflection_card
ALTER COLUMN id SET DEFAULT nextval('portfolio_reflection_card_id_seq'::regclass);

ALTER TABLE ONLY portfolio_reflection_card
ADD CONSTRAINT portfolio_reflection_card_grade_id FOREIGN KEY (grade_id) REFERENCES canvas_grade_info(id);

ALTER TABLE ONLY portfolio_reflection_card
ADD CONSTRAINT portfolio_reflection_card_unit_id FOREIGN KEY (unit_id) REFERENCES canvas_unit_info(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE portfolio_reflection_user_details (
    id integer NOT NULL PRIMARY KEY,
    grade_id integer NOT NULL DEFAULT 0,
    unit_id integer NOT NULL DEFAULT 0,
    user_id integer NOT NULL DEFAULT 0,
    persona_id integer NOT NULL DEFAULT 0,
    role integer NOT NULL DEFAULT 0,
    reflection_card_id INTEGER NOT NULL DEFAULT 0,
    started TIMESTAMP without time zone DEFAULT NULL,
    completed TIMESTAMP without time zone DEFAULT NULL,
    last_viewed TIMESTAMP without time zone DEFAULT NULL,
    admin_last_viewed TIMESTAMP without time zone DEFAULT NULL
);

CREATE SEQUENCE portfolio_reflection_user_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE portfolio_reflection_user_details_id_seq
OWNED BY portfolio_reflection_user_details.id;

ALTER TABLE ONLY portfolio_reflection_user_details
ALTER COLUMN id SET DEFAULT nextval('portfolio_reflection_user_details_id_seq'::regclass);

ALTER TABLE ONLY portfolio_reflection_user_details
ADD CONSTRAINT portfolio_reflection_user_details_user_id FOREIGN KEY (user_id) REFERENCES iuser_user(id);

ALTER TABLE ONLY portfolio_reflection_user_details
ADD CONSTRAINT portfolio_reflection_user_details_persona_id FOREIGN KEY (persona_id) REFERENCES iuser_persona(id);

ALTER TABLE ONLY portfolio_reflection_user_details
ADD CONSTRAINT portfolio_reflection_user_details_grade_id FOREIGN KEY (grade_id) REFERENCES canvas_grade_info(id);

ALTER TABLE ONLY portfolio_reflection_user_details
ADD CONSTRAINT portfolio_reflection_user_details_unit_id FOREIGN KEY (unit_id) REFERENCES canvas_unit_info(id);

ALTER TABLE ONLY portfolio_reflection_user_details
ADD CONSTRAINT portfolio_reflection_user_details_card_id FOREIGN KEY (reflection_card_id) REFERENCES portfolio_reflection_card(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE portfolio_reflection_user_response (
    id integer NOT NULL PRIMARY KEY,
    user_id integer NOT NULL DEFAULT 0,
    reflection_html TEXT DEFAULT NULL,
    reflection_text TEXT DEFAULT NULL,
    words INTEGER NOT NULL DEFAULT 0,
    chars INTEGER NOT NULL DEFAULT 0,
    reflection_user_details_id INTEGER NOT NULL DEFAULT 0
);

CREATE SEQUENCE portfolio_reflection_user_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE portfolio_reflection_user_response_id_seq
OWNED BY portfolio_reflection_user_response.id;

ALTER TABLE ONLY portfolio_reflection_user_response
ALTER COLUMN id SET DEFAULT nextval('portfolio_reflection_user_response_id_seq'::regclass);

ALTER TABLE ONLY portfolio_reflection_user_response
ADD CONSTRAINT portfolio_reflection_user_response_details_id FOREIGN KEY (reflection_user_details_id) REFERENCES portfolio_reflection_user_details(id);

ALTER TABLE ONLY portfolio_reflection_user_response
ADD CONSTRAINT portfolio_reflection_user_response_user_id FOREIGN KEY (user_id) REFERENCES iuser_user(id);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE portfolio_reflection_user_response_history (
        id SERIAL NOT NULL PRIMARY KEY,
        user_id integer NOT NULL DEFAULT 0,
        reflection_html TEXT DEFAULT NULL,
        reflection_text TEXT DEFAULT NULL,
        words INTEGER NOT NULL DEFAULT 0,
        chars INTEGER NOT NULL DEFAULT 0,
        reflection_user_details_id INTEGER NOT NULL DEFAULT 0,
        added_datetime TIMESTAMP without time zone DEFAULT NULL
);

ALTER SEQUENCE portfolio_reflection_user_response_history_id_seq
OWNED BY portfolio_reflection_user_response_history.id;

ALTER TABLE ONLY portfolio_reflection_user_response_history
ALTER COLUMN id SET DEFAULT nextval('portfolio_reflection_user_response_history_id_seq'::regclass);
