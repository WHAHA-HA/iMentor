begin transaction;

INSERT INTO tasks_announcement
(announcement_description, announcement_html, start_date, end_date, is_active)
VALUES ('Celebrate your mentee!', 'Getting to senior year and beyond isn''t easy, but you and your mentee have done an amazing job.<p><p>Want to celebrate all you''ve done together? Consider a donation to iMentor that includes an end-of-high school gift for your mentee.</p></p>Click <a href="https://www.classy.org/campaign/operation-graduation/c81126" target="_blank">here</a> to check out the packages and to purchase one today!</p></p><img src="/new_platform/static/tasks/images/Celebrate_your_mentee.jpg" />', '6/18/16', '8/31/16', TRUE);

INSERT INTO tasks_announcement_localization (partner_id, member_id, announcement_id, role_id)
VALUES (1817, NULL, 4, 4);

INSERT INTO tasks_announcement_localization (partner_id, member_id, announcement_id, role_id)
SELECT
	pp.id AS "partner_id",
	NULL,
	4,
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

update tasks_announcement
set announcement_html = 'Getting to senior year and beyond isn''t easy, but you and your mentee have done an amazing job.<p><p>Want to celebrate all you''ve done together? Consider a donation to iMentor that includes an end-of-high school gift for your mentee.</p></p>Click <a href="https://www.classy.org/campaign/operation-graduation/c81126" target="_blank">here</a> to check out the packages and to purchase one today!</p></p><img src="/new_platform/static/tasks/images/Celebrate_your_mentee.jpg" />'
where id = 6
*/