-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drop table if exists canvas_content_user_response_history;

CREATE TABLE canvas_content_user_response_history (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        marker_id INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        response_html TEXT DEFAULT NULL,
        response_text TEXT DEFAULT NULL,
        response_url TEXT DEFAULT NULL,
        response_id INTEGER DEFAULT NULL,
        external_table_id INTEGER DEFAULT NULL,
        words INTEGER NOT NULL DEFAULT 0,
        chars INTEGER NOT NULL DEFAULT 0,
        added_datetime TIMESTAMP DEFAULT NULL,
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_content_user_response_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_content_user_response_history_id_seq OWNED BY canvas_content_user_response_history.id;
ALTER TABLE ONLY canvas_content_user_response_history ALTER COLUMN id SET DEFAULT nextval('canvas_content_user_response_history_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
