CREATE TABLE flag_type (
        id SERIAL NOT NULL, 
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);

CREATE TABLE flag_canvas (
        id SERIAL NOT NULL, 
        flag_type_id INTEGER NOT NULL DEFAULT 0,
        canvas_id INTEGER NOT NULL DEFAULT 0,
        admin_added_id INTEGER NOT NULL DEFAULT 0,
        admin_added_datetime TIMESTAMP DEFAULT NULL,
        admin_removed_id INTEGER NOT NULL DEFAULT 0,
        admin_removed_datetime TIMESTAMP DEFAULT NULL,
        notes TEXT DEFAULT NULL,
        FOREIGN KEY(flag_type_id) REFERENCES flag_type (id),
        FOREIGN KEY(canvas_id) REFERENCES canvas_set_copy (id),
        FOREIGN KEY(admin_added_id) REFERENCES iuser_user (id),
        FOREIGN KEY(admin_removed_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);

CREATE INDEX flag_canvas_flag_type_id_idx ON flag_canvas (flag_type_id);
CREATE INDEX flag_canvas_canvas_id_idx ON flag_canvas (canvas_id);
CREATE INDEX flag_canvas_admin_added_id_idx ON flag_canvas (admin_added_id);
CREATE INDEX flag_canvas_admin_removed_id_idx ON flag_canvas (admin_removed_id);

CREATE TABLE flag_conversation (
        id SERIAL NOT NULL, 
        flag_type_id INTEGER NOT NULL DEFAULT 0,
        conversation_id INTEGER NOT NULL DEFAULT 0,
        admin_added_id INTEGER NOT NULL DEFAULT 0,
        admin_added_datetime TIMESTAMP DEFAULT NULL,
        admin_removed_id INTEGER NOT NULL DEFAULT 0,
        admin_removed_datetime TIMESTAMP DEFAULT NULL,
        notes TEXT DEFAULT NULL,
        FOREIGN KEY(flag_type_id) REFERENCES flag_type (id),
        FOREIGN KEY(conversation_id) REFERENCES conversation (id),
        FOREIGN KEY(admin_added_id) REFERENCES iuser_user (id),
        FOREIGN KEY(admin_removed_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);

CREATE INDEX flag_conversation_flag_type_id_idx ON flag_conversation (flag_type_id);
CREATE INDEX flag_conversation_conversation_id_idx ON flag_conversation (conversation_id);
CREATE INDEX flag_conversation_admin_added_id_idx ON flag_conversation (admin_added_id);
CREATE INDEX flag_conversation_admin_removed_id_idx ON flag_conversation (admin_removed_id);

CREATE TABLE flag_reflection (
        id SERIAL NOT NULL, 
        flag_type_id INTEGER NOT NULL DEFAULT 0,
        reflection_id INTEGER NOT NULL DEFAULT 0,
        admin_added_id INTEGER NOT NULL DEFAULT 0,
        admin_added_datetime TIMESTAMP DEFAULT NULL,
        admin_removed_id INTEGER NOT NULL DEFAULT 0,
        admin_removed_datetime TIMESTAMP DEFAULT NULL,
        notes TEXT DEFAULT NULL,
        FOREIGN KEY(flag_type_id) REFERENCES flag_type (id),
        FOREIGN KEY(reflection_id) REFERENCES portfolio_reflection_user_details (id),
        FOREIGN KEY(admin_added_id) REFERENCES iuser_user (id),
        FOREIGN KEY(admin_removed_id) REFERENCES iuser_user (id),
        PRIMARY KEY (id)
);

CREATE INDEX flag_reflection_flag_type_id_idx ON flag_reflection (flag_type_id);
CREATE INDEX flag_reflection_reflection_id_idx ON flag_reflection (reflection_id);
CREATE INDEX flag_reflection_admin_added_id_idx ON flag_reflection (admin_added_id);
CREATE INDEX flag_reflection_admin_removed_id_idx ON flag_reflection (admin_removed_id);