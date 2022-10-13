--Staff Lesson 9.1.3 Update

UPDATE canvas_app
SET total = 2
WHERE id = 83;

UPDATE canvas_app_copy
SET total = 2
WHERE parent_id = 83;

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (178, 28, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (179, 28, 2, 1, 2, 300, 'Today in class you will…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (180, 28, 2, 2, 2, 400, 'Optional Activity: 6-Word Memoir');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (297, 178, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (298, 179, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (299, 180, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (416, 297, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (417, 298, 11, 100, NULL, NULL, '<ul><li>Learn the purpose of using surveys to collect data</li><li>Complete the pre-course survey</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (418, 299, 11, 100, NULL, NULL, 'After finishing the survey, complete a 6-word memoir.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (419, 299, 9, 200, NULL, '/new_platform/static/canvas/images/6_Word_Memoir.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (420, 299, 11, 300, NULL, NULL, 'Ask your staff member for the handout to get started.<p><p>Be sure to click “Finish” when you are done for today.</p></p>', NULL);

--Mentee Lesson 9.1.3

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (60, 5, 14, '6/13/15 00:00:00', '6/13/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (181, 60, 2, 1, 2, 100, 'Today in class you will…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (182, 60, 2, 2, 2, 200, 'Optional Activity: 6-Word Memoir');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (300, 181, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (301, 182, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (421, 300, 11, 100, NULL, NULL, '<ul><li>Learn the purpose of using surveys to collect data</li><li>Complete the pre-course survey</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (422, 301, 11, 100, NULL, NULL, 'After finishing the survey, complete a 6-word memoir.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (423, 301, 9, 200, NULL, '/new_platform/static/canvas/images/6_Word_Memoir.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (424, 301, 11, 300, NULL, NULL, 'Ask your staff member for the handout to get started.<p><p>Be sure to click “Finish” when you are done for today.</p></p>', NULL);