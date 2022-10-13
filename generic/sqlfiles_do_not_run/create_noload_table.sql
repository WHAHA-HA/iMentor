CREATE TABLE noload_content_type (
        id SERIAL NOT NULL, 
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);

CREATE TABLE noload_product_type (
        id SERIAL NOT NULL, 
        description TEXT DEFAULT NULL,
        PRIMARY KEY (id)
);

CREATE TABLE noload_error (
        id SERIAL NOT NULL,
        user_id INTEGER NOT NULL DEFAULT 0,
        persona_id INTEGER NOT NULL DEFAULT 0,
        product_type_id INTEGER NOT NULL DEFAULT 0,
        product_record_id INTEGER NOT NULL DEFAULT 0,
        content_type_id INTEGER NOT NULL DEFAULT 0,
        content_url TEXT DEFAULT NULL,
        error_datetime TIMESTAMP DEFAULT NULL,
        FOREIGN KEY(user_id) REFERENCES iuser_user (id),
        FOREIGN KEY(persona_id) REFERENCES iuser_persona (id),
        FOREIGN KEY(product_type_id) REFERENCES canvas_set_copy (id),
        FOREIGN KEY(content_type_id) REFERENCES noload_content_type (id),
        PRIMARY KEY (id)
);

CREATE INDEX user_id_idx ON noload_error (user_id);
CREATE INDEX persona_id_idx ON noload_error (persona_id);
CREATE INDEX product_type_id_idx ON noload_error (product_type_id);
CREATE INDEX content_type_id_idx ON noload_error (content_type_id);

INSERT INTO noload_content_type (description) VALUES ('Google');
INSERT INTO noload_content_type (description) VALUES ('Vimeo');
INSERT INTO noload_content_type (description) VALUES ('YouTube');
INSERT INTO noload_content_type (description) VALUES ('SoundCloud');

INSERT INTO noload_product_type (description) VALUES ('Canvas');
INSERT INTO noload_product_type (description) VALUES ('Tasks');