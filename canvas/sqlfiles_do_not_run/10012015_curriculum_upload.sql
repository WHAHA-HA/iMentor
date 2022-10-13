--Staff Lesson 10.1.6

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (47, 1, '7/16/15 00:00:00', '7/16/15 23:59:59', 2, 4, 6, NULL, 'Getting Better: Pair Strength');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (121, 1, 47, '7/16/15 00:00:00', '7/16/15 23:59:59', 'Getting Better: Pair Strength');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (377, 121, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (378, 121, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (379, 121, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (380, 121, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (643, 377, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (644, 377, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (645, 378, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (646, 379, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (647, 380, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (648, 380, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (649, 380, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (881, 643, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will review their mentor''s responses to their self-assessments, reflect on the process, and share feedback on how they might improve as a pair.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on what they learned through the self-assessment process.</li><li>Identify ways that they and their mentor can improve as a pair over this next year.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/getting-better-pair-strength" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (882, 644, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (883, 644, 6, 200, NULL, 'https://docs.google.com/presentation/d/1UxsF5jyRV4vpZQezAb1uQoTV-kiHGN8GifmebVEg7ZY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (884, 645, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (885, 646, 11, 100, NULL, NULL, 'Your mentor read your self-assessment and shared their thoughts for each section. As you read their response, be sure to highlight or note the responses that you’d like to explore further.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (886, 647, 11, 100, NULL, NULL, 'Your mentor also shared a reflection on your overall self-assessment and how they might support you in your selected areas of growth.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (887, 648, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>What did you learn about yourself as part of this self-assessment process?</li><li>Which of your mentor’s responses to your self-assessment would you like to respond to?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (888, 649, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>In what ways can you improve as a mentee?</li><li>In what ways can your mentor improve?</li><li>How you can you improve as a pair?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (171, 887, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (172, 888, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (154, 885, 157, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (155, 885, 164, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (156, 885, 158, TRUE, 300, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (157, 885, 165, TRUE, 400, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (158, 885, 159, TRUE, 500, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (159, 885, 166, TRUE, 600, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (160, 885, 160, TRUE, 700, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (161, 885, 167, TRUE, 800, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (162, 885, 161, TRUE, 900, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (163, 885, 168, TRUE, 1000, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (164, 885, 162, TRUE, 1100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (165, 885, 169, TRUE, 1200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (166, 886, 163, TRUE, 100, 0);

--Mentee Lesson 10.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (122, 5, 47, '7/16/15 00:00:00', '7/16/15 23:59:59', 'Getting Better: Pair Strength');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (381, 122, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (382, 122, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (650, 381, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (651, 382, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (652, 382, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (653, 382, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (889, 650, 11, 100, NULL, NULL, 'Your mentor read your self-assessment and shared their thoughts for each section. As you read their response, be sure to highlight or note the responses that you’d like to explore further.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (890, 651, 11, 100, NULL, NULL, 'Your mentor also shared a reflection on your overall self-assessment and how they might support you in your selected areas of growth.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (891, 652, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>What did you learn about yourself as part of this self-assessment process?</li><li>Which of your mentor’s responses to your self-assessment would you like to respond to?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (892, 653, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>In what ways can you improve as a mentee?</li><li>In what ways can your mentor improve?</li><li>How you can you improve as a pair?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (173, 891, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (174, 892, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (167, 889, 157, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (168, 889, 164, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (169, 889, 158, TRUE, 300, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (170, 889, 165, TRUE, 400, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (171, 889, 159, TRUE, 500, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (172, 889, 166, TRUE, 600, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (173, 889, 160, TRUE, 700, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (174, 889, 167, TRUE, 800, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (175, 889, 161, TRUE, 900, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (176, 889, 168, TRUE, 1000, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (177, 889, 162, TRUE, 1100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (178, 889, 169, TRUE, 1200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (179, 890, 170, TRUE, 100, 0);

--Mentor Lesson 10.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (123, 4, 47, '7/16/15 00:00:00', '7/16/15 23:59:59', 'Getting Better: Pair Strength');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (383, 123, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (384, 123, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (654, 383, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (655, 384, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (656, 384, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (893, 654, 11, 100, NULL, NULL, 'Today, your mentee used your responses to their self-assessment and identified specific ways they and you can improve as mentees, mentors and pairs.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (894, 655, 11, 100, NULL, NULL, 'Your mentee shared the following with you:<ul><li>Their responses to your reflection on their self-assessment.</li><li>Suggestions for how they and you can improve as mentees, mentors and pairs in the program.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (895, 656, 11, 100, NULL, NULL, 'Respond to your mentee. What additional suggestions do you have on how you as a mentor, your mentee, and you both as a pair, can improve this year?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (175, 895, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (180, 894, 173, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (181, 894, 174, TRUE, 200, 0);

--Staff Lesson 10.1.7

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (48, 1, '7/17/15 00:00:00', '7/17/15 23:59:59', 2, 4, 7, NULL, 'Getting SMART: Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (124, 1, 48, '7/17/15 00:00:00', '7/17/15 23:59:59', 'Getting SMART: Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (385, 124, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (386, 124, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (387, 124, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (388, 124, 2, 2, 3, 400, '10th Grade SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (389, 124, 2, 3, 3, 500, 'Setting 10th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (657, 385, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (658, 385, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (659, 386, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (660, 387, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (661, 387, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (662, 388, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (663, 388, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (664, 389, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (896, 657, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will re-examine the SMART goal-setting framework and create 10th grade SMART goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Examine and understand the SMART goal framework</li><li>Create 1 SMART goal</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/10th-grade-smart-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (897, 658, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (898, 658, 6, 200, NULL, 'https://docs.google.com/presentation/d/1p_2I9vHZ_BTJ1Hp3k1WsLJCwpOgG6nLkBKAGjIedyxk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (899, 659, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (900, 660, 11, 100, NULL, NULL, 'Read your mentor’s response. They read and reflected on your areas of improvement and provided suggestions of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (901, 661, 11, 100, NULL, NULL, 'Respond to your mentor. What do you think of their suggestions and feedback?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (902, 662, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (903, 662, 11, 200, NULL, NULL, 'Read the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (904, 663, 8, 100, NULL, '/new_platform/static/canvas/documents/10th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (905, 663, 11, 200, NULL, NULL, 'Review the 10th grade timeline and highlight and consider the following:<ul><li>Goals you’d like to accomplish this month.</li><li>Goals you’d like to accomplish this semester.</li><li>Goals you’d like to accomplish this year.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (906, 664, 11, 100, NULL, NULL, 'Use the template below to apply the SMART goal framework to what you’d like to accomplish this month. Remember, you and your mentor will use this document to track progress and keep each other accountable, so be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (907, 664, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1ilaZ_qcd1ntSE18H50UfnfOR9FAZoiDI1_lO5zPPVs0/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (176, 901, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (182, 900, 175, TRUE, 100, 0);

--Mentee Lesson 10.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (125, 5, 48, '7/17/15 00:00:00', '7/17/15 23:59:59', 'Getting SMART: Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (390, 125, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (391, 125, 2, 2, 3, 200, '10th Grade SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (392, 125, 2, 3, 3, 300, 'Setting 10th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (665, 390, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (666, 390, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (667, 391, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (668, 391, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (669, 392, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (908, 665, 11, 100, NULL, NULL, 'Read your mentor’s response. They read and reflected on your areas of improvement and provided suggestions of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (909, 666, 11, 100, NULL, NULL, 'Respond to your mentor. What do you think of their suggestions and feedback?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (910, 667, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (911, 667, 11, 200, NULL, NULL, 'Read the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (912, 668, 8, 100, NULL, '/new_platform/static/canvas/documents/10th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (913, 668, 11, 200, NULL, NULL, 'Review the 10th grade timeline and highlight and consider the following:<ul><li>Goals you’d like to accomplish this month.</li><li>Goals you’d like to accomplish this semester.</li><li>Goals you’d like to accomplish this year.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (914, 669, 11, 100, NULL, NULL, 'Use the template below to apply the SMART goal framework to what you’d like to accomplish this month. Remember, you and your mentor will use this document to track progress and keep each other accountable, so be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (915, 669, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1ilaZ_qcd1ntSE18H50UfnfOR9FAZoiDI1_lO5zPPVs0/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (177, 909, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (183, 908, 175, TRUE, 100, 0);

--Mentor Lesson 10.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (126, 4, 48, '7/17/15 00:00:00', '7/17/15 23:59:59', 'Getting SMART: Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (393, 126, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (394, 126, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (670, 393, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (671, 393, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (672, 393, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (673, 393, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (674, 394, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (916, 670, 11, 100, NULL, NULL, 'Your mentee responded to your suggestions from last time:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (917, 671, 11, 100, NULL, NULL, 'The class then examined the SMART goal framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (918, 671, 9, 200, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (919, 672, 11, 100, NULL, NULL, 'They also reviewed their 10th grade timeline:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (920, 672, 8, 200, NULL, '/new_platform/static/canvas/documents/10th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (921, 673, 11, 100, NULL, NULL, 'Finally, they used what they learned about SMART goals to identify things they’d like to accomplish this month, semester, and year. They then filled out the SMART goal template below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (922, 674, 11, 100, NULL, NULL, 'Review your mentee’s SMART goal(s). Be sure to share your questions, notes and suggestions directly in the template.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (923, 674, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1ilaZ_qcd1ntSE18H50UfnfOR9FAZoiDI1_lO5zPPVs0/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (184, 916, 177, TRUE, 100, 0);