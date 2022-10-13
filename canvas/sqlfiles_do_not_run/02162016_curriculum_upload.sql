--9.7.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (152, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 36, 4, NULL, 'Building My Social Network', '/new_platform/static/canvas/images/9.7.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (433, 1, 152, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Social Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1371, 433, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1372, 433, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1373, 433, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1374, 433, 2, 2, 2, 400, 'Consider your social network');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2368, 1371, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2369, 1371, 200);

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2371, 1372, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2372, 1373, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2373, 1373, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2374, 1374, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2375, 1374, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3088, 2368, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore visualizations of a social network, create visuals for their own networks, and identify areas of growth based on their areas of interest.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review visualizations of a social network.</li><li>Create maps of their own current social networks.</li><li>Identify areas of interest where they''d like to meet new people and grow their networks.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-my-social-network" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3089, 2369, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3090, 2369, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Nvu_h-9SnuEuXFfiBVEk66fOk5Awu62G8TXYfsYyOPM/embed', NULL, NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3093, 2371, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3094, 2372, 11, 100, NULL, NULL, 'Your mentor shared the following with you:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3095, 2373, 11, 100, NULL, NULL, 'Respond to your mentor:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3096, 2374, 9, 100, NULL, '/new_platform/static/canvas/images/Social_Network_Graph.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3097, 2375, 11, 100, NULL, NULL, '<ul><li>What did you learn about yourself through this activity? Who''s in your social network?</li><li>In what areas would you like to grow your network and meet new people?</li><li>How can your mentor help you do this?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (669, 3095, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (670, 3097, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (626, 3094, 667, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (627, 3094, 668, TRUE, 200, 0);

--9.7.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (434, 5, 152, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Social Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1375, 434, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1376, 434, 2, 2, 2, 200, 'Consider your social network');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2376, 1375, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2377, 1375, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2378, 1376, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2379, 1376, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3098, 2376, 11, 100, NULL, NULL, 'Your mentor shared the following with you:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3099, 2377, 11, 100, NULL, NULL, 'Respond to your mentor:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3100, 2378, 9, 100, NULL, '/new_platform/static/canvas/images/Social_Network_Graph.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3101, 2379, 11, 100, NULL, NULL, '<ul><li>What did you learn about yourself through this activity? Who''s in your social network?</li><li>In what areas would you like to grow your network and meet new people?</li><li>How can your mentor help you do this?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (671, 3099, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (672, 3101, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (628, 3098, 667, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (629, 3098, 668, TRUE, 200, 0);

--9.7.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (435, 4, 152, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Social Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1377, 435, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2380, 1377, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3102, 2380, 11, 100, NULL, NULL, 'Your mentee responded to you from last week and considered how they can build their social networks.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (630, 3102, 671, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (631, 3102, 672, TRUE, 200, 0);

--9.6.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (153, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 37, 2, NULL, 'My Treasure', '/new_platform/static/canvas/images/9.6.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (436, 1, 153, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Treasure');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1378, 436, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1379, 436, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1380, 436, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1381, 436, 2, 2, 2, 400, 'Optimism and Success');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2381, 1378, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2382, 1378, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2383, 1379, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2384, 1380, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2385, 1380, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2386, 1381, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2387, 1381, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3103, 2381, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will build on the previous lesson by defining their visions for success and identifying the role of optimism in achieving this vision.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define success for themselves</li><li>Write a letter to their future selves</li><li>Reflect on the role of optimism in their future</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-treasure" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3104, 2382, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3105, 2382, 6, 200, NULL, 'https://docs.google.com/presentation/d/10kw2uXsmtA0h-24A0M6Lv-Vh2cNCAs0ahBIlqeUvdiw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3106, 2383, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3107, 2384, 11, 100, NULL, NULL, 'Your mentor shared about the role optimism has played in their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3108, 2385, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3109, 2386, 9, 100, NULL, '/new_platform/static/canvas/images/Success_Happiness_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3110, 2387, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>When you think about the future version of yourself, what makes you most excited? Most nervous?</li><li>Why is it important to feel optimistic about your future?</li><li>How would you say that optimism is related to success?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (673, 3108, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (674, 3110, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (632, 3107, 657, TRUE, 100, 0);

--9.6.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (437, 5, 153, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Treasure');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1382, 437, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1383, 437, 2, 2, 2, 200, 'Optimism and Success');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2388, 1382, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2389, 1382, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2390, 1383, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2391, 1383, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3111, 2388, 11, 100, NULL, NULL, 'Your mentor shared about the role optimism has played in their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3112, 2389, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3113, 2390, 9, 100, NULL, '/new_platform/static/canvas/images/Success_Happiness_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3114, 2391, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>When you think about the future version of yourself, what makes you most excited? Most nervous?</li><li>Why is it important to feel optimistic about your future?</li><li>How would you say that optimism is related to success?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (675, 3112, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (676, 3114, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (633, 3111, 657, TRUE, 100, 0);

--9.6.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (438, 4, 153, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Treasure');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1384, 438, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1385, 438, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2392, 1384, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2393, 1384, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2394, 1384, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2395, 1385, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3115, 2392, 9, 100, NULL, '/new_platform/static/canvas/images/Success_Happiness_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3116, 2393, 11, 100, NULL, NULL, 'Your mentee read about your own experiences with optimism and responded.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3117, 2394, 11, 100, NULL, NULL, 'Your mentee also considered how optimism is connected to success and then reflected on how that shows up in their own life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3118, 2395, 11, 100, NULL, NULL, '<ul><li>Respond to your mentee.</li><li>What is your personal definition of success?</li><li>How would you say that optimism is related to success?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (677, 3118, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (634, 3116, 675, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (635, 3117, 676, TRUE, 100, 0);