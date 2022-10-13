--9.8.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (39, 8, 'Closing Out', 'closing_out', 'What did we accomplish this year?<p>What are we looking forward to next year?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (39, 1, 39, '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>', '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (156, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 39, 1, NULL, 'End of Year Recap and Reflection', '/new_platform/static/canvas/images/9.8.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (445, 1, 156, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Recap and Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1405, 445, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1406, 445, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1407, 445, 2, 1, 2, 300, 'Review your year');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1408, 445, 2, 2, 2, 400, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2420, 1405, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2421, 1405, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2422, 1406, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2423, 1407, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2424, 1408, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3146, 2420, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will recap what they accomplished this year and reflect on their experiences with their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review the units and topics they covered this year.</li><li>Reflect on what went well and what was challenging.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-reflection-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3147, 2421, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3148, 2421, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Dj5f4UkaFtXtOYFWtf7_60yNcedGadw71KFdYkEaDDY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3149, 2422, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3150, 2423, 11, 100, NULL, NULL, 'Take a moment to visit Portfolio and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3151, 2424, 11, 100, NULL, NULL, '<ul><li>What were some of your favorite moments with your mentor this year? Why?</li><li>When did you feel like you were really getting to know each other?</li><li>What topics did you enjoy learning about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (685, 3151, 100, 0, 2);

--9.8.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (446, 5, 156, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Recap and Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1409, 446, 2, 1, 2, 100, 'Review your year');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1410, 446, 2, 2, 2, 200, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2425, 1409, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2426, 1410, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3152, 2425, 11, 100, NULL, NULL, 'Take a moment to visit Portfolio and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3153, 2426, 11, 100, NULL, NULL, '<ul><li>What were some of your favorite moments with your mentor this year? Why?</li><li>When did you feel like you were really getting to know each other?</li><li>What topics did you enjoy learning about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (686, 3153, 100, 0, 2);

--9.8.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (447, 4, 156, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Recap and Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1411, 447, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1412, 447, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2427, 1411, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2428, 1412, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3154, 2427, 11, 100, NULL, NULL, 'Your mentee revisited previous units to see what they’ve accomplished this year. Here’s what they had to share:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3155, 2428, 11, 100, NULL, NULL, 'Visit Portfolio and pick out your highlights from the year.<ul><li>What was your favorite unit or event?</li><li>What was your favorite conversation with your mentee?</li><li>What activity did you enjoy the most?</li></ul><p><p>Then share those moments with your mentee. Be sure to include why they were your highlights.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (687, 3155, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (643, 3154, 686, TRUE, 100, 0);

--9.8.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (157, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 39, 2, NULL, 'Summer Plans', '/new_platform/static/canvas/images/9.8.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (448, 1, 157, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1413, 448, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1414, 448, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1415, 448, 2, 1, 1, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2429, 1413, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2430, 1413, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2431, 1414, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2432, 1415, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2433, 1415, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3156, 2429, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will share their summer plans with their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Share summer plans with mentor</li><li>Complete end of year survey (optional)</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/summer-plans-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3157, 2430, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3158, 2430, 6, 200, NULL, 'https://docs.google.com/presentation/d/1dCtnx2SuGjR_FEzTD_ZIVWwvFcXqo7yv0a000a1z8iE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3159, 2431, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3160, 2432, 11, 100, NULL, NULL, 'Your mentor shared their favorite memories from the year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3161, 2433, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Share one thing you are looking forward to during the summer.</li><li>Share one way they can use their summer to prepare for their next year in high school.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (688, 3161, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (644, 3160, 687, TRUE, 100, 0);

--9.8.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (449, 5, 157, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1416, 449, 2, 1, 1, 100, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2434, 1416, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2435, 1416, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3162, 2434, 11, 100, NULL, NULL, 'Your mentor shared their favorite memories from the year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3163, 2435, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Share one thing you are looking forward to during the summer.</li><li>Share one way they can use their summer to prepare for their next year in high school.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (689, 3163, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (645, 3162, 687, TRUE, 100, 0);

--My Files Update

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1UvlJUgUc1DnoO90Xnf42l89jhlQcOsT-WhnidkqvB94', 'Mentor Thank You Card');

--9.8.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (450, 4, 157, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1417, 450, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1418, 450, 2, 2, 2, 200, 'Create a thank you card');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2436, 1417, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2437, 1417, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2438, 1418, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3164, 2436, 11, 100, NULL, NULL, 'Your mentee considered their summer plans, both what they are most excited about and what they need to do to prepare for next year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3165, 2437, 11, 100, NULL, NULL, 'Respond to your mentee. What are your summer plans? How can you help your mentee stay on track over the summer?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3166, 2438, 11, 100, NULL, NULL, 'Create a thank you card for your mentee. Open the template by clicking <a href="https://docs.google.com/a/imentor.org/drawings/d/1UvlJUgUc1DnoO90Xnf42l89jhlQcOsT-WhnidkqvB94/edit?usp=sharing" target="_blank">here</a>.<p><p><i>Note: Your thank you card will save automatically.</i></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (690, 3165, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (646, 3164, 689, TRUE, 100, 0);