--Lesson 9.1.2

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (10, 1, '6/9/15 00:00:00', '6/9/15 23:59:59', 1, 2, NULL, 'Application');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (20, 1, 10, '6/9/15 00:00:00', '6/9/15 23:59:59', 'Application');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (61, 20, 2, 1, 1, 100, 'Lesson Overview');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (100, 61, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (101, 61, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (102, 61, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (155, 100, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will explore more detailed information about the program and begin their matching applications.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Discover more about the program by generating questions based on the prior week''s lesson</li><li>Learn and practice a technology distribution ritual that they will use weekly in the future</li><li>Begin their matching applications</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-relationships-application-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (156, 101, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editting-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (157, 101, 6, 200, NULL, 'https://docs.google.com/presentation/d/1VjIMMBqlblHZnt4hyo1lz_RJvJ9ZvDr9-FdiFIHS8kg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (158, 102, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (159, 102, 3, 200, NULL, 'https://vimeo.com/136651714', NULL, NULL);

--PDF Test

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (11, 1, '6/10/15 00:00:00', '6/10/15 23:59:59', NULL, NULL, NULL, 'PDF Test');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (21, 1, 11, '6/10/15 00:00:00', '6/10/15 23:59:59', 'PDF Test');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (62, 21, 2, 1, 1, 100, 'Let''s test a PDF');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (103, 62, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (160, 103, 11, 100, NULL, NULL, 'How does the PDF below look?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (161, 103, 8, 200, NULL, '/new_platform/static/canvas/documents/10_Characteristics_of_Great_School_Cultures.pdf', NULL, NULL);