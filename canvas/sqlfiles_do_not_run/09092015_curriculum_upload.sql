--Staff Lesson 11.1.4 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (26, 1, '6/25/15 00:00:00', '6/25/15 23:59:59', 3, 1, 4, NULL, 'Survey');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (58, 1, 26, '6/25/15 00:00:00', '6/25/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (172, 58, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (173, 58, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (174, 58, 2, 1, 2, 300, 'Today in class you will…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (175, 58, 2, 2, 2, 400, 'Optional Activity: 6-Word Memoir');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (290, 172, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (291, 172, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (292, 173, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (293, 174, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (294, 175, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (404, 290, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will learn about the purpose and process of surveying in the program and complete their first program survey.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Learn and articulate their understanding of the purpose of using a pre-course survey to collect data</li><li>Complete matching applications</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-new-pairs-survey" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (405, 291, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (406, 291, 6, 200, NULL, 'https://docs.google.com/presentation/d/1AJdo75n9LvJ6iQv-Bit5PW4ANvC6EKIn7tu6VWGpN2g/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (407, 292, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (408, 293, 11, 100, NULL, NULL, '<ul><li>Learn the purpose of using surveys to collect data</li><li>Complete the pre-course survey</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (409, 294, 11, 100, NULL, NULL, 'After finishing the survey, complete a 6-word memoir.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (410, 294, 9, 200, NULL, '/new_platform/static/canvas/images/6_Word_Memoir.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (411, 294, 11, 300, NULL, NULL, 'Ask your staff member for the handout to get started.<p><p>Be sure to click “Finish” when you are done for today.</p></p>', NULL);

--Mentee Lesson 11.1.4 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (59, 5, 26, '6/25/15 00:00:00', '6/25/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (176, 59, 2, 1, 2, 100, 'Today in class you will…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (177, 59, 2, 2, 2, 200, 'Optional Activity: 6-Word Memoir');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (295, 176, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (296, 177, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (412, 295, 11, 100, NULL, NULL, '<ul><li>Learn the purpose of using surveys to collect data</li><li>Complete the pre-course survey</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (413, 296, 11, 100, NULL, NULL, 'After finishing the survey, complete a 6-word memoir.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (414, 296, 9, 200, NULL, '/new_platform/static/canvas/images/6_Word_Memoir.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (415, 296, 11, 300, NULL, NULL, 'Ask your staff member for the handout to get started.<p><p>Be sure to click “Finish” when you are done for today.</p></p>', NULL);