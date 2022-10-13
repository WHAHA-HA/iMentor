--11.99.1 Staff, Mentee, and Mentor Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (42, 99, 'My College Essay', 'my_files', 'We''ll use Story2 to connect.');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (42, 3, 42, '<ul><li>This unit is all about Story2, so there is no reflection.</li><li>Enjoy!</li></ul>', '<ul><li>This unit is all about Story2, so there is no reflection.</li><li>Enjoy!</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (168, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 1, 244, 'Story2 A', '/new_platform/static/canvas/images/Story2_A.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (480, 1, 168, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 A');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (481, 5, 168, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 A');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (482, 4, 168, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 A');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1468, 480, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1469, 480, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1470, 480, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1471, 481, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1472, 482, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1473, 482, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2508, 1468, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2509, 1469, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2510, 1470, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2511, 1471, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2512, 1472, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2513, 1473, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3248, 2508, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3249, 2509, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3250, 2510, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3251, 2511, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3252, 2512, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3253, 2513, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);

--11.99.2 Staff, Mentee, and Mentor Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (169, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 2, 244, 'Story2 B', '/new_platform/static/canvas/images/Story2_B.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (483, 1, 169, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 B');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (484, 5, 169, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 B');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (485, 4, 169, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 B');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1474, 483, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1475, 483, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1476, 483, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1477, 484, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1478, 485, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1479, 485, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2514, 1474, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2515, 1475, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2516, 1476, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2517, 1477, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2518, 1478, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2519, 1479, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3254, 2514, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3255, 2515, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3256, 2516, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3257, 2517, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3258, 2518, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3259, 2519, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);

--11.99.3 Staff, Mentee, and Mentor Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (170, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 3, 244, 'Story2 C', '/new_platform/static/canvas/images/Story2_C.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (486, 1, 170, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 C');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (487, 5, 170, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 C');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (488, 4, 170, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 C');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1480, 486, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1481, 486, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1482, 486, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1483, 487, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1484, 488, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1485, 488, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2520, 1480, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2521, 1481, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2522, 1482, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2523, 1483, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2524, 1484, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2525, 1485, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3260, 2520, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3261, 2521, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3262, 2522, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3263, 2523, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3264, 2524, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3265, 2525, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);

--11.99.4 Staff, Mentee, and Mentor Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (171, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 4, 244, 'Story2 D', '/new_platform/static/canvas/images/Story2_D.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (489, 1, 171, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 D');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (490, 5, 171, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 D');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (491, 4, 171, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 D');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1486, 489, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1487, 489, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1488, 489, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1489, 490, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1490, 491, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1491, 491, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2526, 1486, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2527, 1487, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2528, 1488, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2529, 1489, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2530, 1490, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2531, 1491, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3266, 2526, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3267, 2527, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3268, 2528, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3269, 2529, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3270, 2530, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3271, 2531, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);

--11.99.5 Staff, Mentee, and Mentor Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (172, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 5, 244, 'Story2 E', '/new_platform/static/canvas/images/Story2_E.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (492, 1, 172, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 E');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (493, 5, 172, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 E');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (494, 4, 172, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 E');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1492, 492, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1493, 492, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1494, 492, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1495, 493, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1496, 494, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1497, 494, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2532, 1492, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2533, 1493, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2534, 1494, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2535, 1495, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2536, 1496, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2537, 1497, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3272, 2532, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3273, 2533, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3274, 2534, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3275, 2535, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3276, 2536, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3277, 2537, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);

--11.99.6 Staff, Mentee, and Mentor Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (173, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 42, 6, 244, 'Story2 F', '/new_platform/static/canvas/images/Story2_F.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (495, 1, 173, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 F');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (496, 5, 173, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 F');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (497, 4, 173, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Story2 F');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1498, 495, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1499, 495, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1500, 495, 2, 1, 1, 300, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1501, 496, 2, 1, 1, 100, 'Story2 and the College Essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1502, 497, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1503, 497, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2538, 1498, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2539, 1499, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2540, 1500, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2541, 1501, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2542, 1502, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2543, 1503, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3278, 2538, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />During this unit, pairs will be using <a href="https://www.story2.com/" target="_blank">Story2</a> to collaborate on a college essay. While the work will take place on the Story2 website, pairs should connect through Conversations on the iMentor platform.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3279, 2539, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3280, 2540, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3281, 2541, 11, 100, NULL, NULL, 'During this unit, you will be building your college essay using the Story2 website. Your mentor and teacher will be your team to help you create a great essay that truly represents you.<ol><li>Send your mentor a message in Conversations.</li><li>Then log in to the <a href="https://www.story2.com/account/login" target="_blank">Story2</a> website to work on your essay.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3282, 2542, 11, 100, NULL, NULL, 'Your mentee is working on their college essay on the Story2 website, which will allow you to play an active role in collaborating with them on this important project.<p><p>For more info about the partnership between iMentor and Story2, click <a href="/new_platform/static/canvas/documents/Story2_and_iMentor.pdf" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3283, 2543, 11, 100, NULL, NULL, '<ol><li><b>Send your mentee a message in Conversations on the iMentor platform.</b> All your work on the college essay should happen in Story2, but be sure to send them a personal message through Conversations each week to stay in touch.</li><li><b>Visit the <a href="https://www.story2.com/" target="_blank">Story2 website</a>.</b> You should have received an email with your login credentials from your College Success Coach. If you are unsure about your username and password, reach out and we will help you.</li><li><b>Leave comments for your mentee.</b> The Story2 website will display what your mentee has completed and give you an opportunity to leave comments.<ul style="list-style-type: circle"><li>Your job is to help them tell their authentic story in a compelling way that makes them stand out.</li><li>Their English teacher will help them with the grammar, spelling, structure, etc.</li></ul></li></ol>', NULL);