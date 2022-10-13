CREATE TABLE program_year (
        id SERIAL NOT NULL, 
        start_datetime TIMESTAMP DEFAULT NULL,
        end_datetime TIMESTAMP DEFAULT NULL,
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);

INSERT INTO program_year (start_datetime, end_datetime, description)
VALUES ('8/17/15', '8/16/16', '2015-16');
INSERT INTO program_year (start_datetime, end_datetime, description)
VALUES ('8/17/16', '8/16/17', '2016-17');

CREATE TABLE mentor_rubric (
        id SERIAL NOT NULL, 
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        strengths_based INTEGER NOT NULL DEFAULT 0,
        resources INTEGER NOT NULL DEFAULT 0,
        response_time INTEGER NOT NULL DEFAULT 0,
        curriculum INTEGER NOT NULL DEFAULT 0,
        program_year_id INTEGER NOT NULL DEFAULT 0,
        admin_completed_datetime TIMESTAMP DEFAULT NULL,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(program_year_id) REFERENCES program_year (id),
        PRIMARY KEY (id)
);

CREATE INDEX mentor_rubric_user_id_idx ON mentor_rubric (user_id);
CREATE INDEX mentor_rubric_persona_id_idx ON mentor_rubric (persona_id);
CREATE INDEX mentor_rubric_program_year_id_idx ON mentor_rubric (program_year_id);