CREATE TABLE canvas_flagged_lesson (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        parent_curriculum_id INTEGER NOT NULL DEFAULT 0,
        partner_site_id INTEGER NOT NULL DEFAULT 0,
        parent_widget_content_id INTEGER NOT NULL DEFAULT 0,
        flag_name VARCHAR(50) not null default 'Not Set',
        flag_bool_value BOOLEAN NOT NULL DEFAULT true,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(parent_curriculum_id) REFERENCES canvas_curriculum (id),
        FOREIGN KEY(partner_site_id) REFERENCES partners_partner (id),
        FOREIGN KEY(parent_widget_content_id) REFERENCES canvas_widget_content (id),
        PRIMARY KEY (id)
);


CREATE SEQUENCE canvas_flagged_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_flagged_lesson_id_seq OWNED BY canvas_flagged_lesson.id;
ALTER TABLE ONLY canvas_flagged_lesson ALTER COLUMN id SET DEFAULT nextval('canvas_flagged_lesson_id_seq'::regclass);
ALTER TABLE canvas_flagged_lesson ADD CONSTRAINT composite__canvas_flagged_lesson_unique unique(user_id,parent_curriculum_id,partner_site_id,parent_widget_content_id,flag_name);


alter table canvas_widget_content_copy add column is_visible boolean not null default true;

