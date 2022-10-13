begin transaction;

UPDATE tasks_announcement
SET end_date = '4/15/16 23:59:59', is_active = FALSE
WHERE id BETWEEN 1 AND 2;

INSERT INTO tasks_announcement
(announcement_description, announcement_html, start_date, end_date, is_active)
VALUES ('College Program texts start soon!', 'As part of the College Program, you will receive text messages that highlight topics and resources you''ll need to support your mentee.<p><p>Texting is our primary way of communicating with you in the College Program. Replying to these texts helps us support you along the way, so please reply! You can learn more about the program by reading the following articles:<ul><li><a href="https://learn.imentor.org/help/article/link/about-the-imentor-college-program" target="_blank">About the College Program</a></li><li><a href="https://learn.imentor.org/help/article/link/the-mentors-role-from-high-school-to-college" target="_blank">The Mentor''s Role: From High School to College</a></li><li><a href="https://learn.imentor.org/help/article/link/faq-text-reminders-in-the-college-program" target="_blank">FAQ: Text Reminders in the College Program</a></li></ul></p></p>', '4/16/16', '6/1/16', TRUE);

INSERT INTO tasks_announcement_localization (partner_id, member_id, announcement_id, role_id)
VALUES (1817, NULL, 3, 4);

INSERT INTO tasks_announcement_localization (partner_id, member_id, announcement_id, role_id)
SELECT
	pp.id AS "partner_id",
	NULL,
	3,
	4
FROM partners_partner AS pp
JOIN member_school AS mm ON mm.id = pp.graduating_class_id
WHERE pp.status_id = 1
	AND pp.is_alumni = FALSE
	AND mm.graduating_class = 2016
	AND pp.member_id = 1;

/*
select * from tasks_announcement
select * from tasks_announcement_localization order by id desc limit 30
select * from tasks_announcement_ack order by id desc limit 5
*/