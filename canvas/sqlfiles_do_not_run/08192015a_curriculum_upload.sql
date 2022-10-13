--Staff Lesson 10.1.2

INSERT into canvas_unit_info (id, unit_number, description) VALUES (4, 1, 'Reconnecting and Setting Goals');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (12, 1, '6/11/15 00:00:00', '6/11/15 23:59:59', 2, 4, NULL, 'Survey');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (22, 1, 12, '6/11/15 00:00:00', '6/11/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (63, 22, 2, 1, 1, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (64, 22, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (65, 22, 2, 1, 2, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (66, 22, 2, 2, 2, 400, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (104, 63, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (105, 63, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (106, 63, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (107, 63, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (108, 64, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (109, 65, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (110, 66, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (162, 104, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will re-familiarize themselves with the purpose and process of surveying in the program and complete their first program survey of the year.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Recall and apply the purpose of using a pre-course survey to collect data and provide feedback</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/survey-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (163, 105, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editting-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (164, 105, 6, 200, NULL, 'https://docs.google.com/presentation/d/1adjRE4Va3TeaH29d4u8x-nU7JeX_Eh8EABK8eoLVcZo/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (165, 106, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (166, 106, 3, 200, NULL, 'https://vimeo.com/136623206', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (167, 107, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (168, 107, 3, 200, NULL, 'https://vimeo.com/136623205', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (169, 108, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (170, 109, 11, 100, NULL, NULL, 'Your mentor had a chance to respond to your summer experiences and share his or her own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (171, 110, 11, 100, NULL, NULL, 'Remember to respond to your mentor and ask good clarifying questions when you want to learn more. ', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (18, 171, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (5, 170, 14, TRUE, 100, 0);

--Refine the unit description

UPDATE canvas_curriculum
SET unit_id = 4
WHERE id = 7;

--Mentee Lesson 10.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (23, 5, 12, '6/11/15 00:00:00', '6/11/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (67, 23, 2, 1, 2, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (68, 23, 2, 2, 2, 200, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (111, 67, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (112, 68, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (172, 111, 11, 100, NULL, NULL, 'Your mentor had a chance to respond to your summer experiences and share his or her own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (173, 112, 11, 100, NULL, NULL, 'Remember to respond to your mentor and ask good clarifying questions when you want to learn more. ', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (19, 173, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (6, 172, 14, TRUE, 100, 0);

--Mentor Lesson 10.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (24, 4, 12, '6/11/15 00:00:00', '6/11/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (69, 24, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (70, 24, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (113, 69, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (114, 70, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (174, 113, 11, 100, NULL, NULL, 'Your mentee spent most of class learning about the purpose of surveys and taking our program survey.<p><p>Are you curious about how surveys improve the quality of our program? Click <a href="https://learn.imentor.org/help/article/link/how-surveys-help-to-improve-our-program" target="_blank">here</a>.</p></p>After finishing the survey, your mentee was then able to read about your summer experiences from last week and respond.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (175, 114, 11, 100, NULL, NULL, '<ul><li>Respond to your mentee’s questions.</li><li>Share experience where you were part of a great team. What qualities made that team successful?</li><li>Share qualities that you’d like to build with your mentee this year.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (20, 175, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (7, 174, 19, TRUE, 100, 0);