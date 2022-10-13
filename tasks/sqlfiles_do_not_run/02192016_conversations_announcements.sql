begin transaction;

--Mentor announcement
insert into tasks_announcement
(announcement_description, announcement_html, start_date, end_date, is_active)
values ('Conversations is coming soon!', 'We are excited to announce "Conversations", which is your tool to exchange messages as a pair.<p><p><iframe src="https://player.vimeo.com/video/156582313" width="640" height="360" frameborder="0" allowFullScreen  sandbox="allow-scripts allow-same-origin allow-popups" ></iframe></p></p>In a few weeks, you will see the Conversations icon at the top right of your screen, which you can click to take Conversations for a spin.<p><p>Want more info? Click <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">here</a>.</p></p>', '3/7/16', '5/1/16', FALSE);

insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1817, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2338, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2339, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2340, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2341, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2211, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2212, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2213, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2372, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2373, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2375, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2376, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2377, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1962, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1963, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1964, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1965, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1930, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1931, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1932, NULL, 1, 4);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1933, NULL, 1, 4);

--Mentee announcement
insert into tasks_announcement
(announcement_description, announcement_html, start_date, end_date, is_active)
values ('Conversations is coming soon!', 'We are excited to announce "Conversations", which is your tool to exchange messages as a pair.<p><p><iframe src="https://player.vimeo.com/video/156743516" width="640" height="360" frameborder="0" allowFullScreen  sandbox="allow-scripts allow-same-origin allow-popups" ></iframe></p></p>In a few weeks, you will see the Conversations icon at the top right of your screen, which you can click to take Conversations for a spin.<p><p>Want more info? Click <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">here</a>.</p></p>', '3/7/16', '5/1/16', FALSE);

insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1817, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2338, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2339, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2340, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2341, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2211, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2212, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2213, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2372, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2373, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2375, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2376, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (2377, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1962, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1963, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1964, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1965, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1930, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1931, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1932, NULL, 2, 5);
insert into tasks_announcement_localization (partner_id, member_id, announcement_id, role_id) values (1933, NULL, 2, 5);

/*
select * from tasks_announcement
select * from tasks_announcement_localization
select * from tasks_announcement_ack
*/