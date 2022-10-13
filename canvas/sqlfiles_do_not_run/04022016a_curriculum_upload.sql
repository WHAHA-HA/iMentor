--Lesson Image Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.10.1.jpg'
WHERE id = 160;

--12.10.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (162, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 40, 2, NULL, 'My Matriculation Steps', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (462, 1, 162, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Matriculation Steps');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1442, 462, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1443, 462, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1444, 462, 2, 1, 1, 300, 'My matriculation steps');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2471, 1442, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2472, 1442, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2473, 1443, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2474, 1444, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2475, 1444, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3208, 2471, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will research their specific matriculation steps for their selected postsecondary option.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and understand a general list of college matriculation steps.</li><li>Research the specific steps and deadlines for their own selected college.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-matriculation-steps" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3209, 2472, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3210, 2472, 6, 200, NULL, 'https://docs.google.com/presentation/d/1TMHiPcBiKuNe8YbMSMQNm3JkzRao4rXtc_C2dv2DqCk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3211, 2473, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3212, 2474, 11, 100, NULL, NULL, 'Your mentor shared ways they can help you through the matriculation process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3213, 2475, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Provide a college process update to your mentor. Where are you in the process? Where do you think you''ll need additional support?</li><li>What are you most excited about?</li><li>What are you most anxious about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (696, 3213, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (652, 3212, 695, TRUE, 100, 0);

--12.10.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (463, 5, 162, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Matriculation Steps');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1445, 463, 2, 1, 1, 100, 'My matriculation steps');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2476, 1445, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2477, 1445, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3214, 2476, 11, 100, NULL, NULL, 'Your mentor shared ways they can help you through the matriculation process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3215, 2477, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Provide a college process update to your mentor. Where are you in the process? Where do you think you''ll need additional support?</li><li>What are you most excited about?</li><li>What are you most anxious about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (697, 3215, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (653, 3214, 695, TRUE, 100, 0);

--12.10.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (464, 4, 162, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Matriculation Steps');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1446, 464, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1447, 464, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2478, 1446, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2479, 1446, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2480, 1447, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3216, 2478, 11, 100, NULL, NULL, 'Your mentee researched the specific matriculation steps they’ll need to complete to enter college.<p><p>You can see a sample matriculation guide <a href="/new_platform/static/canvas/documents/Matriculation_Steps.pdf" target="_blank">here</a>.</p></p>Note: We recommend you download or save the matriculation guide so you can support your mentee through these critical steps.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3217, 2479, 11, 100, NULL, NULL, 'Your mentee also updated you on their progress and let you know how you could help them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3218, 2480, 11, 100, NULL, NULL, 'Respond to your mentee:<ul><li>Address any specific requests.</li><li>After reviewing the <a href="/new_platform/static/canvas/documents/Matriculation_Steps.pdf" target="_blank">matriculation guide</a>, how else might you help?</li><li>Be sure to share some words of encouragement.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (698, 3218, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (654, 3217, 697, TRUE, 100, 0);