--12.10.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (166, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 40, 3, NULL, 'Being a College Pair', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (474, 1, 166, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Being a College Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1457, 474, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1458, 474, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1459, 474, 2, 1, 1, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2490, 1457, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2491, 1457, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2492, 1458, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2493, 1459, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2494, 1459, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3228, 2490, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages mentees in a conversation about their pair experience and explores a variety of methods to stay in contact with their mentor during college and what topics they can and should reach out to them for. The lesson will focus on the behaviors that will best set them up to succeed.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and recap role of mentor in college.</li><li>Review and recap college program.</li><li>Identify skills and behaviors that will set pairs up to be successful in college.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/college-pair" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3229, 2491, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3230, 2491, 6, 200, NULL, 'https://docs.google.com/presentation/d/1lqu4gUmwZwy7IoCnwVc5eVcMDaI3WE8A3mYzT5ZloEo/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3231, 2492, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3232, 2493, 11, 100, NULL, NULL, 'Your mentor suggested the ways they can help.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3233, 2494, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>Respond to any specific recommendations they made.</li><li>Share the 2-3 skills and behaviors you selected as most important in class and explain why you think these will help you be a successful pair.</li><li>Give an update on your college enrollment.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (699, 3233, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (655, 3232, 698, TRUE, 100, 0);

--12.10.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (475, 5, 166, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Being a College Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1460, 475, 2, 1, 1, 100, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2495, 1460, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2496, 1460, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3234, 2495, 11, 100, NULL, NULL, 'Your mentor suggested the ways they can help.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3235, 2496, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>Respond to any specific recommendations they made.</li><li>Share the 2-3 skills and behaviors you selected as most important in class and explain why you think these will help you be a successful pair.</li><li>Give an update on your college enrollment.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (700, 3235, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (656, 3234, 698, TRUE, 100, 0);

--12.10.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (476, 4, 166, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Being a College Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1461, 476, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2497, 1461, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2498, 1461, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3236, 2497, 11, 100, NULL, NULL, 'The school year is winding down! Now is the time to continue building a plan for how you and your mentee will effectively work through any challenges over the summer and into next year.<p><p>Your mentee offered the following skills and behaviors they think will make you effective as a pair.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3237, 2498, 11, 100, NULL, NULL, 'Respond to your mentee:<ul><li>What are your reactions to the list of skills and behaviors that your mentee shared?</li><li>Based on what you know about your mentee and your relationship as a pair, what skills and behaviors do you think will help you be successful after high school?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (701, 3237, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (657, 3236, 700, TRUE, 100, 0);