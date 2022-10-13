--Staff Lesson 11.1.3 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (24, 1, '6/23/15 00:00:00', '6/23/15 23:59:59', 3, 1, 3, NULL, 'College Success Toolkit');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (53, 1, 24, '6/23/15 00:00:00', '6/23/15 23:59:59', 'College Success Toolkit');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (155, 53, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (156, 53, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (157, 53, 2, 1, 3, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (158, 53, 2, 2, 3, 400, 'Click through the following strategies');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (159, 53, 2, 3, 3, 500, 'Create accounts');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (252, 155, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (253, 155, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (254, 155, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (255, 156, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (256, 157, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (257, 158, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (258, 159, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (361, 252, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />The purpose of this lesson is to prepare mentees to access and use multiple online resources. Mentees will learn about managing login credentials, designing secure passwords they can remember, and creating accounts for the resources they will use over the next two years.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Examine the purpose and practice of creating strong passwords for online accounts</li><li>Create accounts for the following resources:<ul><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li><li>Other as determined by school partner</li></ul></li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-college-success-toolkit" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (362, 253, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (363, 253, 6, 200, NULL, 'https://docs.google.com/presentation/d/13114zf-VLXJLpsJ2cx6r1AgcO4ltQTCmvSQKfIGojTk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (364, 254, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (365, 254, 3, 200, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (366, 255, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (367, 256, 3, 100, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (368, 256, 11, 200, NULL, NULL, '<ul><li>Can you relate to the video?</li><li>Do you use a strategy for creating and remembering passwords?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (369, 257, 6, 100, NULL, 'https://docs.google.com/presentation/d/1nV7lo8Aw8Su92nJirv9mqTmvTctMdRY130vPTmN-ykk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (370, 258, 11, 100, NULL, NULL, 'Create accounts with strong, memorable passwords for the following websites:<ul><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li></ul><p><p>Your staff member might ask you to create accounts for additional websites.</p></p>', NULL);

--Mentee Lesson 11.1.3 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (54, 5, 24, '6/23/15 00:00:00', '6/23/15 23:59:59', 'College Success Toolkit');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (160, 54, 2, 1, 3, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (161, 54, 2, 2, 3, 200, 'Click through the following strategies');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (162, 54, 2, 3, 3, 300, 'Create accounts');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (259, 160, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (260, 161, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (261, 162, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (371, 259, 3, 100, NULL, 'https://vimeo.com/136625242', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (372, 259, 11, 200, NULL, NULL, '<ul><li>Can you relate to the video?</li><li>Do you use a strategy for creating and remembering passwords?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (373, 260, 6, 100, NULL, 'https://docs.google.com/presentation/d/1nV7lo8Aw8Su92nJirv9mqTmvTctMdRY130vPTmN-ykk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (374, 261, 11, 100, NULL, NULL, 'Create accounts with strong, memorable passwords for the following websites:<ul><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li><li><a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a></li><li><a href="https://www.collegeraptor.com/" target="_blank">College Raptor</a></li></ul><p><p>Your staff member might ask you to create accounts for additional websites.</p></p>', NULL);