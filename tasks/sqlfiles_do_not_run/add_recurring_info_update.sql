CREATE TABLE tasks_recurring_info_update (
    id SERIAL not null,
    info_description TEXT not null default 'UNSET',
    interval_days INTEGER default 180,
    is_active BOOLEAN NOT NULL default true,
    PRIMARY KEY (id)
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE tasks_recurring_info_update_ack (
    id SERIAL not null,
    user_id INTEGER NOT NULL,
    user_acked_date TIMESTAMP without time zone NOT NULL default (NOW() AT TIME ZONE 'utc'),
    recurring_info_update_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES iuser_user (id),
    FOREIGN KEY (recurring_info_update_id) REFERENCES tasks_recurring_info_update (id),
    PRIMARY KEY (id)
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE tasks_recurring_info_update_localization (
    id SERIAL not null,
    recurring_info_update_id INTEGER NOT NULL,
    member_id INTEGER default NULL,
    partner_id INTEGER default NULL,
    role_id numeric CHECK (role_id > 0), CHECK (role_id < 7),
    FOREIGN KEY (recurring_info_update_id) REFERENCES tasks_recurring_info_update (id),
    FOREIGN KEY (member_id) REFERENCES member_member (id),
    FOREIGN KEY (partner_id) REFERENCES partners_partner (id),
    PRIMARY KEY (id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSERT INTO tasks_recurring_info_update (info_description, is_active)
VALUES ('Mentor Standard Information Update', TRUE);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (1, 197, 4);

INSERT INTO tasks_recurring_info_update (info_description, is_active)
VALUES ('Mentee Standard Information Update', TRUE);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (2, 197, 5);