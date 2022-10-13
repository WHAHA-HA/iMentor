CREATE TABLE canvas_protocol_message (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        for_user_id INTEGER DEFAULT NULL,
        src_dst INTEGER NOT NULL DEFAULT 0,
        widget_type_send_mask INTEGER NOT NULL DEFAULT 0,
        receive_mask INTEGER NOT NULL DEFAULT 0,
        message_type INTEGER NOT NULL DEFAULT 0,
        command INTEGER NOT NULL DEFAULT 0,
        status INTEGER NOT NULL DEFAULT 0,
        timestamp_ms BIGINT NOT NULL DEFAULT 0,
        received_by_server TIMESTAMP DEFAULT NULL,
        sent_to_recipient TIMESTAMP DEFAULT NULL,
        json_data TEXT DEFAULT NULL,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id), 
        FOREIGN KEY(for_user_id) REFERENCES iuser_user (id), 
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_protocol_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_protocol_message_id_seq OWNED BY canvas_protocol_message.id;
ALTER TABLE ONLY canvas_protocol_message ALTER COLUMN id SET DEFAULT nextval('canvas_protocol_message_id_seq'::regclass);
CREATE INDEX sent_to_recipient_idx ON canvas_protocol_message USING btree (sent_to_recipient);
CREATE INDEX timestamp_ms_idx ON canvas_protocol_message USING btree (timestamp_ms);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_live_widget_state (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        live_datetime TIMESTAMP DEFAULT NULL,
        recv_mask INTEGER NOT NULL DEFAULT 0,
        widget_type_send_mask INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id), 
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_live_widget_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_live_widget_state_id_seq OWNED BY canvas_live_widget_state.id;
ALTER TABLE ONLY canvas_live_widget_state ALTER COLUMN id SET DEFAULT nextval('canvas_live_widget_state_id_seq'::regclass);
ALTER TABLE canvas_live_widget_state ADD CONSTRAINT composite_lws_smask_key unique(user_id,widget_type_send_mask);


-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_grade_info (
        id SERIAL NOT NULL, 
        grade_number INTEGER DEFAULT NULL,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_grade_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_grade_info_id_seq OWNED BY canvas_grade_info.id;
ALTER TABLE ONLY canvas_grade_info ALTER COLUMN id SET DEFAULT nextval('canvas_grade_info_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_unit_info (
        id SERIAL NOT NULL, 
        unit_number INTEGER DEFAULT NULL,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_unit_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_unit_info_id_seq OWNED BY canvas_unit_info.id;
ALTER TABLE ONLY canvas_unit_info ALTER COLUMN id SET DEFAULT nextval('canvas_unit_info_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_curriculum (
        id SERIAL NOT NULL, 
        canvas_type INTEGER NOT NULL DEFAULT 0,
        start_datetime TIMESTAMP DEFAULT NULL,
        end_datetime TIMESTAMP DEFAULT NULL,
        description TEXT DEFAULT NULL,
        grade INTEGER DEFAULT NULL,
        unit INTEGER DEFAULT NULL,
        member_id INTEGER DEFAULT NULL, -- optional
        FOREIGN KEY(grade) REFERENCES canvas_grade_info (id),
        FOREIGN KEY(unit) REFERENCES canvas_unit_info (id),
        FOREIGN KEY(member_id) REFERENCES member_member (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_curriculum_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_curriculum_id_seq OWNED BY canvas_curriculum.id;
ALTER TABLE ONLY canvas_curriculum ALTER COLUMN id SET DEFAULT nextval('canvas_curriculum_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_set (
        id SERIAL NOT NULL, 
        start_datetime TIMESTAMP DEFAULT NULL,
        end_datetime TIMESTAMP DEFAULT NULL,
        curriculum_id INTEGER NOT NULL DEFAULT 0,
        role INTEGER NOT NULL DEFAULT 0,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(curriculum_id) REFERENCES canvas_curriculum (id)
);


CREATE SEQUENCE canvas_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_set_id_seq OWNED BY canvas_set.id;
ALTER TABLE ONLY canvas_set ALTER COLUMN id SET DEFAULT nextval('canvas_set_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_app (
        id SERIAL NOT NULL, 
        canvas_set_id INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        app_type INTEGER NOT NULL DEFAULT 0,
        n_of_total INTEGER NOT NULL DEFAULT 0,
        total INTEGER NOT NULL DEFAULT 0,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(canvas_set_id) REFERENCES canvas_set (id)
);


CREATE SEQUENCE canvas_app_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_app_id_seq OWNED BY canvas_app.id;
ALTER TABLE ONLY canvas_app ALTER COLUMN id SET DEFAULT nextval('canvas_app_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_widget (
        id SERIAL NOT NULL, 
        canvas_app_id INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(canvas_app_id) REFERENCES canvas_app (id)
);


CREATE SEQUENCE canvas_widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_id_seq OWNED BY canvas_widget.id;
ALTER TABLE ONLY canvas_widget ALTER COLUMN id SET DEFAULT nextval('canvas_widget_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_widget_content (
        id SERIAL NOT NULL, 
        widget_id INTEGER NOT NULL DEFAULT 0,
        content_type INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        filename TEXT DEFAULT NULL,
        url TEXT DEFAULT NULL,
        html TEXT DEFAULT NULL,
        plain_text TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(widget_id) REFERENCES canvas_widget (id)
);


CREATE SEQUENCE canvas_widget_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_id_seq OWNED BY canvas_widget_content.id;
ALTER TABLE ONLY canvas_widget_content ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE canvas_widget_content_response_marker (
        id SERIAL NOT NULL, 
        widget_content_id INTEGER NOT NULL DEFAULT 0,
        response_type INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        position INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(widget_content_id) REFERENCES canvas_widget_content (id)
);


CREATE SEQUENCE canvas_widget_content_response_marker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_response_marker_id_seq OWNED BY canvas_widget_content_response_marker.id;
ALTER TABLE ONLY canvas_widget_content_response_marker ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_response_marker_id_seq'::regclass);

CREATE TABLE canvas_widget_content_marker_reference (
        id SERIAL NOT NULL, 
        widget_content_id INTEGER NOT NULL DEFAULT 0,
        other_marker_id INTEGER NOT NULL DEFAULT 0,
        read_only BOOLEAN NOT NULL DEFAULT true,
        ordinal INTEGER NOT NULL DEFAULT 0,
        position INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(widget_content_id) REFERENCES canvas_widget_content (id)
        -- No.
        --FOREIGN KEY(marker_id) REFERENCES canvas_widget_content_response_marker (id)
);


CREATE SEQUENCE canvas_widget_content_marker_reference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_marker_reference_id_seq OWNED BY canvas_widget_content_marker_reference.id;
ALTER TABLE ONLY canvas_widget_content_marker_reference ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_marker_reference_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_curriculum_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        canvas_type INTEGER NOT NULL DEFAULT 0,
        start_datetime TIMESTAMP DEFAULT NULL,
        end_datetime TIMESTAMP DEFAULT NULL,
        grade INTEGER DEFAULT NULL,
        unit INTEGER DEFAULT NULL,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_curriculum (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(grade) REFERENCES canvas_grade_info (id),
        FOREIGN KEY(unit) REFERENCES canvas_unit_info (id)
);


CREATE SEQUENCE canvas_curriculum_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_curriculum_copy_id_seq OWNED BY canvas_curriculum_copy.id;
ALTER TABLE ONLY canvas_curriculum_copy ALTER COLUMN id SET DEFAULT nextval('canvas_curriculum_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_set_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        curriculum_id INTEGER NOT NULL DEFAULT 0,
        role INTEGER NOT NULL DEFAULT 0,
        start_datetime TIMESTAMP DEFAULT NULL,
        end_datetime TIMESTAMP DEFAULT NULL,
        user_started TIMESTAMP DEFAULT NULL,
        user_completed TIMESTAMP DEFAULT NULL,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_set (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(curriculum_id) REFERENCES canvas_curriculum_copy (id)
);


CREATE SEQUENCE canvas_set_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_set_copy_id_seq OWNED BY canvas_set_copy.id;
ALTER TABLE ONLY canvas_set_copy ALTER COLUMN id SET DEFAULT nextval('canvas_set_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_app_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        canvas_set_id INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        app_type INTEGER NOT NULL DEFAULT 0,
        user_started TIMESTAMP DEFAULT NULL,
        user_completed TIMESTAMP DEFAULT NULL,
        n_of_total INTEGER NOT NULL DEFAULT 0,
        total INTEGER NOT NULL DEFAULT 0,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(canvas_set_id) REFERENCES canvas_set_copy (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_app (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id)
);


CREATE SEQUENCE canvas_app_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_app_copy_id_seq OWNED BY canvas_app_copy.id;
ALTER TABLE ONLY canvas_app_copy ALTER COLUMN id SET DEFAULT nextval('canvas_app_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_widget_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        canvas_app_id INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(canvas_app_id) REFERENCES canvas_app_copy (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_widget (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id)
);


CREATE SEQUENCE canvas_widget_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_copy_id_seq OWNED BY canvas_widget_copy.id;
ALTER TABLE ONLY canvas_widget_copy ALTER COLUMN id SET DEFAULT nextval('canvas_widget_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_widget_content_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        widget_id INTEGER NOT NULL DEFAULT 0,
        content_type INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        filename TEXT DEFAULT NULL,
        url TEXT DEFAULT NULL,
        html TEXT DEFAULT NULL,
        orig_doc_id TEXT DEFAULT NULL,
        new_doc_id TEXT DEFAULT NULL,
        plain_text TEXT DEFAULT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_widget_content (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(widget_id) REFERENCES canvas_widget_copy (id)
);


CREATE SEQUENCE canvas_widget_content_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_copy_id_seq OWNED BY canvas_widget_content_copy.id;
ALTER TABLE ONLY canvas_widget_content_copy ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE canvas_widget_content_response_marker_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        widget_content_id INTEGER NOT NULL DEFAULT 0,
        response_type INTEGER NOT NULL DEFAULT 0,
        ordinal INTEGER NOT NULL DEFAULT 0,
        position INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_widget_content_response_marker (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(widget_content_id) REFERENCES canvas_widget_content_copy (id)
);


CREATE SEQUENCE canvas_widget_content_response_marker_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_response_marker_copy_id_seq OWNED BY canvas_widget_content_response_marker_copy.id;
ALTER TABLE ONLY canvas_widget_content_response_marker_copy ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_response_marker_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE canvas_widget_content_marker_reference_copy (
        id SERIAL NOT NULL, 
        parent_id INTEGER NOT NULL DEFAULT 0,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        widget_content_id INTEGER NOT NULL DEFAULT 0,
        other_marker_id INTEGER NOT NULL DEFAULT 0,
        read_only BOOLEAN NOT NULL DEFAULT true,
        ordinal INTEGER NOT NULL DEFAULT 0,
        position INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY(widget_content_id) REFERENCES canvas_widget_content_copy (id),
        FOREIGN KEY(parent_id) REFERENCES canvas_widget_content_marker_reference (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id)
        -- No.
        --FOREIGN KEY(marker_id) REFERENCES canvas_widget_content_response_marker_copy (id)
);


CREATE SEQUENCE canvas_widget_content_marker_reference_copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_widget_content_marker_reference_copy_id_seq OWNED BY canvas_widget_content_marker_reference_copy.id;
ALTER TABLE ONLY canvas_widget_content_marker_reference_copy ALTER COLUMN id SET DEFAULT nextval('canvas_widget_content_marker_reference_copy_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE TABLE canvas_content_user_response (
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
        PRIMARY KEY (id),
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(marker_id) REFERENCES canvas_widget_content_response_marker_copy (id)
);


CREATE SEQUENCE canvas_content_user_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_content_user_response_id_seq OWNED BY canvas_content_user_response.id;
ALTER TABLE ONLY canvas_content_user_response ALTER COLUMN id SET DEFAULT nextval('canvas_content_user_response_id_seq'::regclass);

-- # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
