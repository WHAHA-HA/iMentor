--Staff Lesson 12.1.5 (NYC)

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (28, 1, '6/27/15 00:00:00', '6/27/15 23:59:59', 4, 5, 5, 1, 'Completing My College List (NYC)');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (64, 1, 28, '6/27/15 00:00:00', '6/27/15 23:59:59', 'Completing My College List (NYC)');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (193, 64, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (194, 64, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (195, 64, 2, 1, 1, 300, 'College List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (316, 193, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (317, 193, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (318, 194, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (319, 195, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (352, 195, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (442, 316, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees review important college concepts and complete their college lists.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and re-define the concepts of safety, target, and reach colleges.</li><li>Review their college lists and work to narrow it down and/or complete it.</li><li>Using the College List tool, enter schools that are on their list.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/completing-college-list" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (443, 317, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (444, 317, 6, 200, NULL, 'https://docs.google.com/presentation/d/1IkaofzCpDVxbFxaKBtvDA-tIrL8UuIqQRVq0OoejXiE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (445, 318, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (446, 319, 11, 100, NULL, NULL, '<ul><li>If you have not completed your list, what remaining questions do you have? How can your mentor help you to address these questions?</li><li>Select two schools on your list and describe why you chose these schools. What about these schools are you excited about?</li><li>Share any concerns you have about the application process. What support can your mentor provide during the application process?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (489, 352, 11, 100, NULL, NULL, 'Today, you will be finishing your college list <a href="/cchklist/" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (79, 446, 100, 0, 2);

--Mentee Lesson 12.1.5 (NYC)

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (65, 5, 28, '6/27/15 00:00:00', '6/27/15 23:59:59', 'Completing My College List (NYC)');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (196, 65, 2, 1, 1, 100, 'College List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (320, 196, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (353, 196, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (447, 320, 11, 100, NULL, NULL, '<ul><li>If you have not completed your list, what remaining questions do you have? How can your mentor help you to address these questions?</li><li>Select two schools on your list and describe why you chose these schools. What about these schools are you excited about?</li><li>Share any concerns you have about the application process. What support can your mentor provide during the application process?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (490, 353, 11, 100, NULL, NULL, 'Today, you will be finishing your college list <a href="/cchklist/" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (80, 447, 100, 0, 2);

--Mentor Lesson 12.1.5 (NYC)

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (66, 4, 28, '6/27/15 00:00:00', '6/27/15 23:59:59', 'Completing My College List (NYC)');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (197, 66, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (198, 66, 2, 2, 3, 200, 'Learn about college lists');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (199, 66, 2, 3, 3, 300, 'Write your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (321, 197, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (322, 198, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (323, 198, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (324, 199, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (325, 199, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (326, 199, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (448, 321, 11, 100, NULL, NULL, 'In today''s lesson, mentees reviewed the concepts of safety, target, and reach schools. They used these concepts to refine their college lists.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (449, 322, 11, 100, NULL, NULL, 'Over the next two weeks, your priority should be helping your mentee complete their college list.<p><p>Learn more about what makes a balanced college list by clicking through the slideshow.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (450, 322, 6, 200, NULL, 'https://docs.google.com/presentation/d/1oKgY7eNPzstmaGEyJyY7hysVPyz31M5xhp_tAIhOmvs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (451, 323, 11, 100, NULL, NULL, 'Now review your mentee''s college list <a href="/cchklist/" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (452, 324, 11, 100, NULL, NULL, 'Here is your mentee’s response and the questions they responded to:<ul><li>What remaining questions do you have and how can your mentor help you?</li><li>What about the 2 schools you selected are you excited about?</li><li>What concerns do you have about the college application process and how can your mentor support you?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (453, 325, 11, 100, NULL, NULL, 'Respond to your mentee and consider the following:<ul><li>Does the list align with your conversations with your mentee?</li><li>Is there anything missing? Are there other factors your mentee should be considering?</li><li>What excites you about the colleges on their list?</li><li>Respond to your mentee''s questions.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (454, 326, 11, 100, NULL, NULL, 'Now share your own experiences with applying to college.<ul><li>What did your college list look like?</li><li>What is something you know now about college "fit" that you didn''t know when applying to college?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (81, 453, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (82, 454, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (73, 452, 80, TRUE, 100, 0);