begin transaction;

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 248, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 248, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 191, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 191, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 196, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 196, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 195, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 195, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 233, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 233, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 245, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 245, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 246, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 246, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 237, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 237, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 231, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 231, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 247, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 247, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 236, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 236, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 234, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 234, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 249, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 249, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 250, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 250, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 251, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 251, 5);

INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (3, 252, 4);
INSERT INTO tasks_recurring_info_update_localization (recurring_info_update_id, member_id, role_id)
VALUES (4, 252, 5);

/*
select distinct member_id from tasks_recurring_info_update_localization order by member_id asc
select * from tasks_recurring_info_update_localization
select * from tasks_recurring_info_update
select * from tasks_recurring_info_update_ack order by id desc limit 1

select distinct
	iu.member_id
from tasks_recurring_info_update_ack as t
join iuser_user as iu on iu.id = t.user_id
*/