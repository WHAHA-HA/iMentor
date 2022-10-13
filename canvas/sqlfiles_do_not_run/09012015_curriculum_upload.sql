--Staff Lesson 11.1.4 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (23, 1, '6/22/15 00:00:00', '6/22/15 23:59:59', 3, 3, 4, NULL, 'College Success Toolkit');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (48, 1, 23, '6/22/15 00:00:00', '6/22/15 23:59:59', 'College Success Toolkit');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (135, 48, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (136, 48, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (137, 48, 2, 1, 4, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (138, 48, 2, 2, 4, 400, 'Click through the following strategies');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (139, 48, 2, 3, 4, 500, 'Create accounts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (140, 48, 2, 4, 4, 600, 'Reconnect with your mentor…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (221, 135, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (222, 135, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (223, 135, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (224, 136, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (225, 137, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (226, 138, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (227, 139, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (228, 140, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (229, 140, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (316, 221, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />The purpose of this lesson is to introduce and prepare mentees to access and use multiple online resources. Mentees will learn about managing log-in credentials, designing secure passwords they can remember, and creating accounts for the resources they will use over the next two years.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Examine the purpose and practice of creating strong passwords for online accounts</li><li>Create accounts for the following resources:<ul style="list-style-type: circle"><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li><li>Other as determined by school partner</li></ul></li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-college-success-toolkit" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (317, 222, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (318, 222, 6, 200, NULL, 'https://docs.google.com/presentation/d/1iMDxW-Xgi3pnU9aFU0E4RE_i4a_wu1p4Fr99otnhH4U/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (319, 223, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (320, 223, 3, 200, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (321, 224, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (322, 225, 3, 100, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (323, 225, 11, 200, NULL, NULL, '<ul><li>Can you relate to the video?</li><li>Do you use a strategy for creating and remembering passwords?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (324, 226, 6, 100, NULL, 'https://docs.google.com/presentation/d/1nV7lo8Aw8Su92nJirv9mqTmvTctMdRY130vPTmN-ykk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (325, 227, 11, 200, NULL, NULL, 'Create accounts with strong, memorable passwords for the following websites:<ul><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li></ul><p><p>Your staff member might ask you to create accounts for additional websites.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (326, 228, 11, 100, NULL, NULL, 'Your mentor responded to you:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (327, 229, 11, 100, NULL, NULL, 'Respond to you mentor. Do you have any questions about the resources they suggested?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (52, 327, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (34, 326, 44, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (35, 326, 45, TRUE, 200, 0);

--Mentee Lesson 11.1.4 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (49, 5, 23, '6/22/15 00:00:00', '6/22/15 23:59:59', 'College Success Toolkit');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (141, 49, 2, 1, 4, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (142, 49, 2, 2, 4, 200, 'Click through the following strategies');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (143, 49, 2, 3, 4, 300, 'Create accounts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (144, 49, 2, 4, 4, 400, 'Reconnect with your mentor…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (230, 141, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (231, 142, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (232, 143, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (233, 144, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (234, 144, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (328, 230, 3, 100, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (329, 230, 11, 200, NULL, NULL, '<ul><li>Can you relate to the video?</li><li>Do you use a strategy for creating and remembering passwords?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (330, 231, 6, 100, NULL, 'https://docs.google.com/presentation/d/1nV7lo8Aw8Su92nJirv9mqTmvTctMdRY130vPTmN-ykk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (331, 232, 11, 200, NULL, NULL, 'Create accounts with strong, memorable passwords for the following websites:<ul><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li></ul><p><p>Your staff member might ask you to create accounts for additional websites.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (332, 233, 11, 100, NULL, NULL, 'Your mentor responded to you:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (333, 234, 11, 100, NULL, NULL, 'Respond to you mentor. Do you have any questions about the resources they suggested?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (53, 333, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (36, 332, 44, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (37, 332, 45, TRUE, 200, 0);

--Mentor Lesson 11.1.4 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (50, 4, 23, '6/22/15 00:00:00', '6/22/15 23:59:59', 'College Success Toolkit');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (145, 50, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (146, 50, 2, 2, 2, 200, 'Reconnect with your mentee…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (235, 145, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (236, 145, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (237, 146, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (238, 146, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (334, 235, 11, 100, NULL, NULL, 'Your mentee learned about password management.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (335, 235, 3, 200, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (336, 235, 6, 300, NULL, 'https://docs.google.com/presentation/d/1nV7lo8Aw8Su92nJirv9mqTmvTctMdRY130vPTmN-ykk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (337, 236, 11, 100, NULL, NULL, 'The class then set up accounts for websites they’ll be using during the college exploration process, including <a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a> and <a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (338, 237, 11, 100, NULL, NULL, 'Your mentee responded to you:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (339, 238, 11, 100, NULL, NULL, 'Respond to your mentee:', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (54, 339, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (38, 338, 53, TRUE, 100, 0);