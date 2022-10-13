--9.6.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (154, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 37, 3, NULL, 'Doing What You Love', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (439, 1, 154, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Doing What You Love');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1386, 439, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1387, 439, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1388, 439, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1389, 439, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1390, 439, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2396, 1386, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2397, 1386, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2398, 1386, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2399, 1387, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2400, 1388, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2401, 1389, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2402, 1390, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3119, 2396, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will connect their self-identified passions and visions for success to extracurricular opportunities that they can pursue in high school.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Discuss the benefits of being involved in high school outside of classes</li><li>Generate specific examples of extracurricular activities</li><li>Make a connection between extracurricular opportunities and doing what they love</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/imagine-your-future" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3120, 2397, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3121, 2397, 6, 200, NULL, 'https://docs.google.com/presentation/d/1-b94jhnb6MeDXJdrTO0MuWf3NvwNTDuTTB7dTxkOHkM/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3122, 2398, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3123, 2398, 3, 200, NULL, 'https://vimeo.com/155826732', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3124, 2399, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3125, 2400, 11, 100, NULL, NULL, '<ul><li>Respond to your mentor.</li><li>How are your perspectives similar? Different?</li><li>Does your mentor’s perspective change your definition of success? If so, how?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3126, 2401, 3, 100, NULL, 'https://vimeo.com/155826732', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3127, 2402, 11, 100, NULL, NULL, '<ul><li>How do you currently spend your spare time, outside of classes? If you are involved in any extracurricular activities, share them with your mentor.</li><li>What is one extracurricular activity that you are interested in exploring?</li><li>How does this activity connect to doing what you love?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (678, 3125, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (679, 3127, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (636, 3125, 677, TRUE, 100, 1);

--9.6.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (440, 5, 154, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Doing What You Love');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1391, 440, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1392, 440, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1393, 440, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2403, 1391, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2404, 1392, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2405, 1393, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3128, 2403, 11, 100, NULL, NULL, '<ul><li>Respond to your mentor.</li><li>How are your perspectives similar? Different?</li><li>Does your mentor’s perspective change your definition of success? If so, how?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3129, 2404, 3, 100, NULL, 'https://vimeo.com/155826732', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3130, 2405, 11, 100, NULL, NULL, '<ul><li>How do you currently spend your spare time, outside of classes? If you are involved in any extracurricular activities, share them with your mentor.</li><li>What is one extracurricular activity that you are interested in exploring?</li><li>How does this activity connect to doing what you love?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (680, 3128, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (681, 3130, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (637, 3128, 677, TRUE, 100, 1);

--9.6.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (441, 4, 154, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Doing What You Love');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1394, 441, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1395, 441, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2406, 1394, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2407, 1394, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2408, 1395, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3131, 2406, 11, 100, NULL, NULL, 'Your mentee read and responded to you from last time.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3132, 2407, 11, 100, NULL, NULL, 'Your mentee also considered what they love and how to pursue their passions through extracurricular activities.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3133, 2408, 11, 100, NULL, NULL, 'If your mentee has identified something they love to do, that''s huge! Encourage them by helping them identify tangible steps towards exploring that interest. Ask questions, share ideas, and keep them excited. If your mentee is having some trouble with identifying what they like doing, this is a great opportunity to use what you know about them to offer suggestions.<p><p>Also give your mentee some examples by describing any extracurricular activities that you participated in during high school. Why did you choose them? How did they help shape your future?</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (682, 3133, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (638, 3131, 680, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (639, 3132, 681, TRUE, 100, 0);

--Update 9.6.1 Mentor Lesson

UPDATE canvas_app
SET n_of_total = 1
WHERE id = 1336;

UPDATE canvas_app_copy
SET n_of_total = 1
WHERE parent_id = 1336;