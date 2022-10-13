CREATE TABLE attendance_detail (
        id SERIAL NOT NULL, 
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);

INSERT INTO attendance_detail (description)
VALUES ('Not taken');
INSERT INTO attendance_detail (description)
VALUES ('Present');
INSERT INTO attendance_detail (description)
VALUES ('Absent');

CREATE TABLE attendance (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        partner_id INTEGER NOT NULL DEFAULT 0,
        curriculum_id INTEGER NOT NULL DEFAULT 0,
        detail_id INTEGER NOT NULL DEFAULT 0,
        admin_completed_datetime TIMESTAMP DEFAULT NULL,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(partner_id) REFERENCES partners_partner (id),
        FOREIGN KEY(curriculum_id) REFERENCES canvas_curriculum (id),
        FOREIGN KEY(detail_id) REFERENCES attendance_detail (id),
        PRIMARY KEY (id)
);

CREATE INDEX attendance_user_id_idx ON attendance (user_id);
CREATE INDEX attendance_persona_id_idx ON attendance (persona_id);
CREATE INDEX attendance_partner_id_idx ON attendance (partner_id);
CREATE INDEX attendance_curriculum_id_idx ON attendance (curriculum_id);
CREATE INDEX attendance_detail_id_idx ON attendance (detail_id);