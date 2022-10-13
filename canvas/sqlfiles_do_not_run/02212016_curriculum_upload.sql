--Update the lesson images for 9.6.3

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/9.6.3.jpg'
WHERE id = 154;

--9.6.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (155, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 37, 4, NULL, 'My Aspirations', '/new_platform/static/canvas/images/9.6.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (442, 1, 155, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Aspirations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1396, 442, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1397, 442, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1398, 442, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1399, 442, 2, 2, 3, 400, 'Extracurricular activities in college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1400, 442, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2409, 1396, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2410, 1396, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2411, 1397, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2412, 1398, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2413, 1399, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2414, 1400, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3134, 2409, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will begin to envision themselves as college students and build excitement about the experience.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Explore examples of extracurriculars in college</li><li>Create a hypothetical schedule for their ideal day in college built around doing what they love</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-aspiration-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3135, 2410, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3136, 2410, 6, 200, NULL, 'https://docs.google.com/presentation/d/1piB2iog0bcnnb01MAizLm9jcuuJkC8D3J7kLmd-1r00/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3137, 2411, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3138, 2412, 11, 100, NULL, NULL, 'Your mentor continued the discussion about extracurricular activities.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3139, 2413, 11, 100, NULL, NULL, 'Explore the University of Connecticut’s <a href="http://uconn.edu/campus-life/activities-recreation/" target="_blank">Activities and Recreation website</a>.<p><p>As you explore the site, identify the following:<ul><li>Recall from our last lesson the extracurricular activity that you said you wanted to explore. Can you find the same activity or something similar at UCONN?</li><li>Explore the categories on the website. Find 3-5 activities that you''d be excited to join.</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3140, 2414, 11, 100, NULL, NULL, '<ul><li>Respond to your mentor</li><li>Share one college extracurricular activity you''d be interested in exploring.</li><li>Share what your ideal college day would look like.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (683, 3140, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (640, 3138, 682, TRUE, 100, 0);

--9.6.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (443, 5, 155, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Aspirations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1401, 443, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1402, 443, 2, 2, 3, 200, 'Extracurricular activities in college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1403, 443, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2415, 1401, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2416, 1402, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2417, 1403, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3141, 2415, 11, 100, NULL, NULL, 'Your mentor continued the discussion about extracurricular activities.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3142, 2416, 11, 100, NULL, NULL, 'Explore the University of Connecticut’s <a href="http://uconn.edu/campus-life/activities-recreation/" target="_blank">Activities and Recreation website</a>.<p><p>As you explore the site, identify the following:<ul><li>Recall from our last lesson the extracurricular activity that you said you wanted to explore. Can you find the same activity or something similar at UCONN?</li><li>Explore the categories on the website. Find 3-5 activities that you''d be excited to join.</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3143, 2417, 11, 100, NULL, NULL, '<ul><li>Respond to your mentor</li><li>Share one college extracurricular activity you''d be interested in exploring.</li><li>Share what your ideal college day would look like.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (684, 3143, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (641, 3141, 682, TRUE, 100, 0);

--9.6.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (444, 4, 155, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Aspirations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1404, 444, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2418, 1404, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2419, 1404, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3144, 2418, 11, 100, NULL, NULL, 'Your mentee used what they learned about extracurricular activities in high school to consider the activities they would like to continue in college.<p><p>To do this, they:<ul><li>Explored the University of Connecticut’s <a href="http://uconn.edu/campus-life/activities-recreation/" target="_blank">Activities and Recreation website</a></li><li>Created a timeline of their ideal college day</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3145, 2419, 11, 100, NULL, NULL, 'Then they shared their thoughts with you.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (642, 3145, 684, TRUE, 100, 0);