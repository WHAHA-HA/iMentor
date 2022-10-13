--Run a pilot in NYC and Chicago during the summer to prepare for the upcoming school year

begin transaction;

INSERT INTO tasks_recurring_info_update (info_description, is_active)
VALUES ('Mentor Standard Information Update', TRUE);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 1, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 244, 4);

INSERT INTO tasks_recurring_info_update (info_description, is_active)
VALUES ('Mentee Standard Information Update', TRUE);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 1, 5);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 244, 5);

--Make the test task on platformtraining recur very frequently

UPDATE tasks_recurring_info_update
SET interval_days = 1
WHERE id BETWEEN 1 AND 2;

/*
select * from tasks_recurring_info_update order by id asc
select * from tasks_recurring_info_update_localization order by id asc
select name from member_member where id = 244
*/