--Staff Lesson 11.1.6 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (38, 1, '7/7/15 00:00:00', '7/7/15 23:59:59', 3, 1, 6, NULL, 'Finding Similarities and Celebrating Differences');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (94, 1, 38, '7/7/15 00:00:00', '7/7/15 23:59:59', 'Finding Similarities and Celebrating Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (288, 94, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (289, 94, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (290, 94, 2, 1, 2, 300, 'The Parable of Hodja and The Foreigner');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (291, 94, 2, 2, 2, 400, 'Finding similarities and celebrating differences');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (475, 288, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (476, 288, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (477, 288, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (478, 289, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (479, 290, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (480, 290, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (481, 291, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (482, 291, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (655, 475, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will watch and review a parable and use it to identify similarities and differences between them and their mentor.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze a story to determine how cultural worldview, assumptions, and communication errors impact our interactions with other people</li><li>Apply this information to their new relationship with their mentor</li><li>Identify and celebrate similarities and differences with their mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-finding-similarities-and-differences" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (656, 476, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (657, 476, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Tv-U7Uu4Q41RfhzcsxxUyMGw17VTGNokijIAJHQ-HPU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (658, 477, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (659, 477, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (660, 478, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (661, 479, 11, 100, NULL, NULL, 'Watch the video and write down the following:<ul><li>What is the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem or challenge in the story?</li><li>What assumptions was Hodja making? The foreigner?</li><li>What is the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (662, 479, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (663, 480, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What did you learn from the parable?</li><li>How might the challenges and lesson presented in the parable apply to your relationship with your mentor?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (664, 481, 11, 100, NULL, NULL, 'Your mentor responded to your “I Am From” poem and  also wrote one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (665, 482, 11, 100, NULL, NULL, 'After reviewing each, respond to your mentor and share the following:<ul><li>What do you have in common?</li><li>What differences would you like to recognize and celebrate?</li><li>What questions do you have about your mentor based on what you learned about them in their poem?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (118, 663, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (119, 665, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (110, 664, 116, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (111, 664, 117, TRUE, 200, 0);

--Mentee Lesson 11.1.6 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (95, 5, 38, '7/7/15 00:00:00', '7/7/15 23:59:59', 'Finding Similarities and Celebrating Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (292, 95, 2, 1, 2, 100, 'The Parable of Hodja and The Foreigner');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (293, 95, 2, 2, 2, 200, 'Finding similarities and celebrating differences');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (483, 292, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (484, 292, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (485, 293, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (486, 293, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (666, 483, 11, 100, NULL, NULL, 'Watch the video and write down the following:<ul><li>What is the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem or challenge in the story?</li><li>What assumptions was Hodja making? The foreigner?</li><li>What is the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (667, 483, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (668, 484, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What did you learn from the parable?</li><li>How might the challenges and lesson presented in the parable apply to your relationship with your mentor?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (669, 485, 11, 100, NULL, NULL, 'Your mentor responded to your “I Am From” poem and  also wrote one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (670, 486, 11, 100, NULL, NULL, 'After reviewing each, respond to your mentor and share the following:<ul><li>What do you have in common?</li><li>What differences would you like to recognize and celebrate?</li><li>What questions do you have about your mentor based on what you learned about them in their poem?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (120, 668, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (121, 670, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (112, 669, 116, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (113, 669, 117, TRUE, 200, 0);

--Mentor Lesson 11.1.6 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (96, 4, 38, '7/7/15 00:00:00', '7/7/15 23:59:59', 'Finding Similarities and Celebrating Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (294, 96, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (295, 96, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (487, 294, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (488, 294, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (489, 295, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (490, 295, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (671, 487, 11, 100, NULL, NULL, 'Your mentee watched the video, Hodja and The Foreigner.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (672, 487, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (673, 488, 11, 100, NULL, NULL, 'After watching the video, your mentee discussed the following questions in class:<ul><li>What is the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem or challenge in the story?</li><li>What assumptions was Hodja making? The foreigner?</li><li>What is the story trying to teach us?</li><li>How do assumptions, point of view, and worldview, impact relationships?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (674, 489, 11, 100, NULL, NULL, 'Your mentee shared the following with you:<ul><li>Reflections and lessons learned from the parable</li><li>Ways that you are similar and different</li><li>Questions they have for you based on what they learned about you from your poem</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (675, 490, 11, 100, NULL, NULL, 'Respond to your mentee, answer their questions, and share the following:<ul><li>What did you learn from the parable?</li><li>How might your point of view, assumptions and worldview impact your relationship?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (122, 675, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (114, 674, 120, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (115, 674, 121, TRUE, 200, 0);

--Staff Lesson 11.1.7 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (39, 1, '7/8/15 00:00:00', '7/8/15 23:59:59', 3, 1, 7, NULL, 'Becoming a PPPAIR');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (97, 1, 39, '7/8/15 00:00:00', '7/8/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (296, 97, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (297, 97, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (298, 97, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (299, 97, 2, 2, 3, 400, 'Social Contracts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (300, 97, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (491, 296, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (492, 296, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (493, 297, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (494, 298, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (495, 298, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (496, 299, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (497, 299, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (498, 299, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (499, 300, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (676, 491, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Addressing differences in opinion can be difficult, especially when a person feels strongly about a topic or when it’s emotionally charged. This lesson provides a framework within which pairs can work towards keeping their communication frequent and productive. It can also help pairs to develop tools to address diverse cultural differences.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review an article</li><li>Define a social contract</li><li>Differentiate between the two types of culture: visible and deep</li><li>Apply the PPPAIR social contract framework to their mentee/mentor relationship</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-becoming-a-pppair" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (677, 492, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (678, 492, 6, 100, NULL, 'https://docs.google.com/presentation/d/1NgdJTz2m4cPfH6yeUCEKwX9EDl29buRlV0uY3plN_PI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (679, 493, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (680, 494, 11, 100, NULL, NULL, 'Your mentor watched the parable video and responded to your thoughts from last time.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (681, 495, 11, 100, NULL, NULL, 'What did they learn from the parable? How similar or different was it than what you learned?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (682, 496, 9, 100, NULL, '/new_platform/static/canvas/images/TheSocialContract_Canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (683, 496, 11, 200, NULL, NULL, 'Examine the image and answer the following questions:<ul><li>What do you think this image means?</li><li>What is a social contract?</li><li>What role do social contracts have between people?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (684, 497, 11, 100, NULL, NULL, 'Read the article. What steps and strategies help build an epic relationship?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (685, 497, 8, 200, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (686, 498, 11, 100, NULL, NULL, 'Review the following slides on the PPPAIR framework. How can you use this framework with your mentor?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (687, 498, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (688, 499, 11, 100, NULL, NULL, 'Apply what you discussed about social contracts and the PPPAIR framework and share the following with your mentor:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentor?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (123, 681, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (124, 688, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (116, 680, 122, TRUE, 100, 0);

--Mentee Lesson 11.1.7 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (98, 5, 39, '7/8/15 00:00:00', '7/8/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (301, 98, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (302, 98, 2, 2, 3, 200, 'Social Contracts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (303, 98, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (500, 301, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (501, 301, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (502, 302, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (503, 302, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (504, 302, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (505, 303, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (689, 500, 11, 100, NULL, NULL, 'Your mentor watched the parable video and responded to your thoughts from last time.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (690, 501, 11, 100, NULL, NULL, 'What did they learn from the parable? How similar or different was it than what you learned?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (691, 502, 9, 100, NULL, '/new_platform/static/canvas/images/TheSocialContract_Canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (692, 502, 11, 200, NULL, NULL, 'Examine the image and answer the following questions:<ul><li>What do you think this image means?</li><li>What is a social contract?</li><li>What role do social contracts have between people?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (693, 503, 11, 100, NULL, NULL, 'Read the article. What steps and strategies help build an epic relationship?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (694, 503, 8, 200, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (695, 504, 11, 100, NULL, NULL, 'Review the following slides on the PPPAIR framework. How can you use this framework with your mentor?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (696, 504, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (697, 505, 11, 100, NULL, NULL, 'Apply what you discussed about social contracts and the PPPAIR framework and share the following with your mentor:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentor?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (125, 690, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (126, 697, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (117, 689, 122, TRUE, 100, 0);

--Mentor Lesson 11.1.7 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (99, 4, 39, '7/8/15 00:00:00', '7/8/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (304, 99, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (305, 99, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (506, 304, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (507, 304, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (508, 305, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (509, 305, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (510, 305, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (698, 506, 9, 100, NULL, '/new_platform/static/canvas/images/TheSocialContract_Canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (699, 506, 11, 200, NULL, NULL, 'Your mentee explored social contracts and reviewed an article on steps and strategies for building strong relationships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (700, 506, 8, 300, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (701, 507, 11, 100, NULL, NULL, 'They were introduced to the PPPAIR framework. Click through the following slides to learn more.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (702, 507, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (703, 508, 11, 100, NULL, NULL, 'Your mentee responded to your thoughts on the parable video:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (704, 509, 11, 100, NULL, NULL, 'They then wrote to you about how social contracts and the PPPAIR framework could strengthen your relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (705, 510, 11, 100, NULL, NULL, 'Respond to your mentee. Consider the following questions:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentee?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (127, 705, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (118, 703, 125, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (119, 704, 126, TRUE, 100, 0);

--Staff Lesson 11.1.8 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (40, 1, '7/9/15 00:00:00', '7/9/15 23:59:59', 3, 1, 8, NULL, '11th Grade SMART Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (100, 1, 40, '7/9/15 00:00:00', '7/9/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (306, 100, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (307, 100, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (308, 100, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (309, 100, 2, 2, 3, 400, 'Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (310, 100, 2, 3, 3, 500, 'Setting 11th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (511, 306, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (512, 306, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (513, 307, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (514, 308, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (515, 308, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (516, 309, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (517, 309, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (518, 310, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (706, 511, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the SMART goal setting framework and help mentees set goals for 11th grade.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Introduce and examine the SMART goal framework.</li><li>Create short and long term goals based on their 11th grade timeline.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-smart-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (707, 512, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (800, 512, 6, 200, NULL, 'https://docs.google.com/presentation/d/1R_P5H6s-7qi9uRmrcWlAuUtl4fAigrhj_42YKOwL4Fg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (708, 513, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (709, 514, 11, 100, NULL, NULL, 'Read your mentor’s response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (710, 515, 11, 100, NULL, NULL, 'Respond to your mentor and think about the following:<ul><li>What commitments did they make?</li><li>How can you keep each other accountable?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (711, 516, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (712, 516, 11, 200, NULL, NULL, 'Review the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (713, 517, 11, 100, NULL, NULL, 'Read the article on your 11th grade timeline. Highlight the following:<ul><li>What would you like to accomplish this month?</li><li>What would you like to accomplish this semester?</li><li>What would you like to accomplish this year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (714, 517, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (715, 518, 11, 100, NULL, NULL, 'Use the template below to draft your own SMART goal(s). Reminder: you will use this document with your mentor to track progress and keep each other accountable. So be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (716, 518, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1Bt6MpQGbG8KcwfnueyCxGxeUkJHkIK8HWODZmddrElA/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (128, 710, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (120, 709, 127, TRUE, 100, 0);

--Mentee Lesson 11.1.8 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (101, 5, 40, '7/9/15 00:00:00', '7/9/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (311, 101, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (312, 101, 2, 2, 3, 200, 'Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (313, 101, 2, 3, 3, 300, 'Setting 11th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (519, 311, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (520, 311, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (521, 312, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (522, 312, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (523, 313, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (717, 519, 11, 100, NULL, NULL, 'Read your mentor’s response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (718, 520, 11, 100, NULL, NULL, 'Respond to your mentor and think about the following:<ul><li>What commitments did they make?</li><li>How can you keep each other accountable?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (719, 521, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (720, 521, 11, 200, NULL, NULL, 'Review the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (721, 522, 11, 100, NULL, NULL, 'Read the article on your 11th grade timeline. Highlight the following:<ul><li>What would you like to accomplish this month?</li><li>What would you like to accomplish this semester?</li><li>What would you like to accomplish this year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (722, 522, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (723, 523, 11, 100, NULL, NULL, 'Use the template below to draft your own SMART goal(s). Reminder: you will use this document with your mentor to track progress and keep each other accountable. So be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (724, 523, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1Bt6MpQGbG8KcwfnueyCxGxeUkJHkIK8HWODZmddrElA/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (129, 718, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (121, 717, 127, TRUE, 100, 0);

--Mentor Lesson 11.1.8 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (102, 4, 40, '7/9/15 00:00:00', '7/9/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (314, 102, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (315, 102, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (524, 314, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (525, 314, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (526, 315, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (527, 315, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (725, 524, 11, 100, NULL, NULL, 'Today, your mentee focused on the importance and process of goal setting. They were introduced to and discussed the SMART goal setting framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (726, 524, 9, 200, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (727, 525, 11, 100, NULL, NULL, 'They reviewed their 11th grade timeline to highlight what they’d like to accomplish this month, semester, and year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (728, 525, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (729, 526, 11, 100, NULL, NULL, 'Read your mentee’s response from last time:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (730, 527, 11, 100, NULL, NULL, 'Now review their SMART goal(s). Respond to your mentee by writing your questions, notes and suggestions directly into the goal setting document.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (731, 527, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1Bt6MpQGbG8KcwfnueyCxGxeUkJHkIK8HWODZmddrElA/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (122, 729, 129, TRUE, 100, 0);

--Staff Lesson 11.1.7 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (41, 1, '7/10/15 00:00:00', '7/10/15 23:59:59', 3, 3, 7, NULL, '11th Grade SMART Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (103, 1, 41, '7/10/15 00:00:00', '7/10/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (316, 103, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (317, 103, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (318, 103, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (319, 103, 2, 2, 3, 400, 'Re-Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (320, 103, 2, 3, 3, 500, 'Setting 11th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (528, 316, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (529, 316, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (530, 317, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (531, 318, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (532, 318, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (533, 319, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (534, 319, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (535, 320, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (732, 528, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will re-introduce the SMART goal setting framework and help mentees set goals for 11th grade.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Re-examine the SMART goal framework.</li><li>Create short and long term goals based on their 11th grade timeline.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-smart-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (733, 529, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (734, 529, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Aa5UY0I2nUUYNFhDoNTAZMrZMp7Od7D_RVy7H1vT6RI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (735, 530, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (736, 531, 11, 100, NULL, NULL, 'Your mentor also wrote about how you can use the PPPAIR framework in your relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (737, 532, 11, 100, NULL, NULL, 'Respond to your mentor and think about the following:<ul><li>What commitments did they make?</li><li>How can you keep each other accountable?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (738, 533, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (739, 533, 11, 200, NULL, NULL, 'Review the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (740, 534, 11, 100, NULL, NULL, 'Read the article on your 11th grade timeline.<p><p>Think about  the following:<ul><li>What would you like to accomplish this month?</li><li>What would you like to accomplish this semester?</li><li>What would you like to accomplish this year?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (741, 534, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (742, 535, 11, 100, NULL, NULL, 'Use the template below to draft your own SMART goal(s). Reminder: you will use this document with your mentor to track progress and keep each other accountable. So be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (743, 535, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1nLCLXFsKfs1nNhmbxA3-RXgyuus9KBQwp9117V3EBq4/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (130, 737, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (123, 736, 113, TRUE, 100, 0);

--Mentee Lesson 11.1.7 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (104, 5, 41, '7/10/15 00:00:00', '7/10/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (321, 104, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (322, 104, 2, 2, 3, 200, 'Re-Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (323, 104, 2, 3, 3, 300, 'Setting 11th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (536, 321, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (537, 321, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (538, 322, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (539, 322, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (540, 323, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (744, 536, 11, 100, NULL, NULL, 'Your mentor also wrote about how you can use the PPPAIR framework in your relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (745, 537, 11, 100, NULL, NULL, 'Respond to your mentor and think about the following:<ul><li>What commitments did they make?</li><li>How can you keep each other accountable?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (746, 538, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (747, 538, 11, 200, NULL, NULL, 'Review the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (748, 539, 11, 100, NULL, NULL, 'Read the article on your 11th grade timeline.<p><p>Think about  the following:<ul><li>What would you like to accomplish this month?</li><li>What would you like to accomplish this semester?</li><li>What would you like to accomplish this year?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (749, 539, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (750, 540, 11, 100, NULL, NULL, 'Use the template below to draft your own SMART goal(s). Reminder: you will use this document with your mentor to track progress and keep each other accountable. So be clear and specific.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (751, 540, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1nLCLXFsKfs1nNhmbxA3-RXgyuus9KBQwp9117V3EBq4/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (131, 745, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (124, 744, 113, TRUE, 100, 0);

--Mentor Lesson 11.1.7 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (105, 4, 41, '7/10/15 00:00:00', '7/10/15 23:59:59', '11th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (324, 105, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (325, 105, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (541, 324, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (542, 324, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (543, 325, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (544, 325, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (752, 541, 11, 100, NULL, NULL, 'Today, your mentee re-examined the SMART goal setting framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (753, 541, 9, 200, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (754, 542, 11, 100, NULL, NULL, 'They reviewed their 11th grade timeline to highlight what they’d like to accomplish this month, semester, and year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (755, 542, 8, 200, NULL, '/new_platform/static/canvas/documents/11th_Grade_College_Planning_Timeline.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (756, 543, 11, 100, NULL, NULL, 'Read your mentee’s response from last time:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (757, 544, 11, 100, NULL, NULL, 'Now review their SMART goal(s). Respond to your mentee by writing your questions, notes and suggestions directly into the goal setting document.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (758, 544, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1nLCLXFsKfs1nNhmbxA3-RXgyuus9KBQwp9117V3EBq4/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (125, 756, 131, TRUE, 100, 0);

--Staff Lesson 9.1.8

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (42, 1, '7/11/15 00:00:00', '7/11/15 23:59:59', 1, 2, 8, NULL, 'Healthy Relationships');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (106, 1, 42, '7/11/15 00:00:00', '7/11/15 23:59:59', 'Healthy Relationships');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (326, 106, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (327, 106, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (328, 106, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (329, 106, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (330, 106, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (545, 326, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (546, 326, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (547, 326, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (548, 327, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (549, 328, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (550, 329, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (551, 330, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (552, 330, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (759, 545, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, we will explore what mentees think are and should be the most important qualities in a healthy relationship. The lesson will ask mentees to reflect on other relationships they have and identify the common traits that encourage healthy relationships.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and define the qualities of strong and weak relationships.</li><li>Define and provide examples of a healthy relationship.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/healthy-relationships" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (760, 546, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (761, 546, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ASpTEhMrhilMUu7M5QW9uaEcWOQl5orwKxonXFNQBXQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (762, 547, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (763, 547, 3, 200, NULL, 'https://vimeo.com/139585605', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (764, 548, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (765, 549, 11, 100, NULL, NULL, 'Your mentor responded to your thoughts on the Hodja and The Foreigner video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (766, 550, 3, 100, NULL, 'https://vimeo.com/139585605', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (767, 550, 11, 200, NULL, NULL, 'Reflect on the following questions:<ul><li>What are the qualities that build strong and healthy relationships?</li><li>What are the qualities and behaviors that weaken relationships?</li><li>How would you define a “healthy relationship”?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (768, 551, 11, 100, NULL, NULL, 'What is a healthy relationship? Share your thoughts with your mentor by answering the following questions:<ul><li>What is a healthy relationship? How would you define it to your mentor?</li><li>What qualities are most important to you when building a healthy relationship?</li><li>What is an example of a healthy relationship you have right now? Who is it with and why did you choose to share it?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (769, 552, 11, 100, NULL, NULL, 'How will you build a healthy relationship with your mentor? Share your thoughts with your mentor by answering the following questions:<ul><li>What can you do together this year to build a healthy relationship?</li><li>What disappoints and frustrates you most in your relationships?</li><li>What can you and your mentor do to avoid them?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (132, 768, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (133, 769, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (126, 765, 108, TRUE, 100, 0);

--Mentee Lesson 9.1.8

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (107, 5, 42, '7/11/15 00:00:00', '7/11/15 23:59:59', 'Healthy Relationships');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (331, 107, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (332, 107, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (333, 107, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (553, 331, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (554, 332, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (555, 333, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (556, 333, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (770, 553, 11, 100, NULL, NULL, 'Your mentor responded to your thoughts on the Hodja and The Foreigner video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (771, 554, 3, 100, NULL, 'https://vimeo.com/139585605', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (772, 554, 11, 200, NULL, NULL, 'Reflect on the following questions:<ul><li>What are the qualities that build strong and healthy relationships?</li><li>What are the qualities and behaviors that weaken relationships?</li><li>How would you define a “healthy relationship”?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (773, 555, 11, 100, NULL, NULL, 'What is a healthy relationship? Share your thoughts with your mentor by answering the following questions:<ul><li>What is a healthy relationship? How would you define it to your mentor?</li><li>What qualities are most important to you when building a healthy relationship?</li><li>What is an example of a healthy relationship you have right now? Who is it with and why did you choose to share it?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (774, 556, 11, 100, NULL, NULL, 'How will you build a healthy relationship with your mentor? Share your thoughts with your mentor by answering the following questions:<ul><li>What can you do together this year to build a healthy relationship?</li><li>What disappoints and frustrates you most in your relationships?</li><li>What can you and your mentor do to avoid them?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (134, 773, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (135, 774, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (127, 770, 108, TRUE, 100, 0);

--Mentor Lesson 9.1.8

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (108, 4, 42, '7/11/15 00:00:00', '7/11/15 23:59:59', 'Healthy Relationships');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (334, 108, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (335, 108, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (557, 334, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (558, 334, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (559, 334, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (560, 335, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (775, 557, 11, 100, NULL, NULL, 'Your mentee watched the following video:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (776, 557, 3, 200, NULL, 'https://vimeo.com/139585605', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (777, 558, 11, 100, NULL, NULL, 'They then discussed the following:<ul><li>Different types of relationships</li><li>Qualities that strengthen relationships</li><li>Qualities that weaken relationships</li><li>Defined what a “healthy relationship” is</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (778, 559, 11, 100, NULL, NULL, 'Then your mentee shared what they think a healthy relationship is and how you can build one over the year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (779, 560, 11, 100, NULL, NULL, 'Respond to your mentee and consider the following:<ul><li>How would you define a “healthy relationship”?</li><li>How similar or different is your definition from your mentee’s?</li><li>Share an example of a healthy relationship in your life right now. Who is it with and what about it would you like to share?</li><li>What can you and your mentee do to build a healthy relationship this year?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (136, 779, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (128, 778, 134, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (129, 778, 135, TRUE, 200, 0);

--Staff Lesson 9.1.9

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (43, 1, '7/12/15 00:00:00', '7/12/15 23:59:59', 1, 2, 9, NULL, 'Interview Your Mentor');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (109, 1, 43, '7/12/15 00:00:00', '7/12/15 23:59:59', 'Interview Your Mentor');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (336, 109, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (337, 109, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (338, 109, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (339, 109, 2, 2, 3, 400, 'Who would you like to interview?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (340, 109, 2, 3, 3, 500, 'Interviewing your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (561, 336, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (562, 336, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (563, 337, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (564, 338, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (565, 338, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (566, 339, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (567, 339, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (568, 340, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (780, 561, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will continue to get to know their mentors by discussing the purpose of an interview, practicing the art of asking good questions, and generating a list of interview questions specifically for their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and define the purpose of an interview</li><li>Differentiate between strong and weak interview questions and types of questions</li><li>Use prior knowledge of their mentors to generate a list of interview questions for their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/interview-your-mentor" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (781, 562, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (782, 562, 6, 200, NULL, 'https://docs.google.com/presentation/d/14a8jPDUPnMLnlST_w088RSRkExztvuG16Y98B_7do-0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (783, 563, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (784, 564, 11, 100, NULL, NULL, 'Your mentor wrote to you about healthy relationships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (785, 565, 11, 100, NULL, NULL, 'Respond to your mentor. Answer the following questions:<ul><li>What do you think about your mentor’s definition of a healthy relationship? How similar or different is it from yours?</li><li>What questions do you have about the example of healthy relationship your mentor shared?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (786, 566, 11, 100, NULL, NULL, 'Click through the slideshow and pick a person to interview:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (787, 566, 6, 200, NULL, 'https://docs.google.com/presentation/d/17aces--6sTkYIjru1E7dhljLyzNoma-On3oZWtbWH-Q/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (788, 567, 11, 100, NULL, NULL, 'Based on what you already know about the person, think about the following:<ul><li>What interview questions would be the most informative?</li><li>What would give you insight into who this person really is?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (789, 568, 11, 100, NULL, NULL, '<ul><li>Review what you already know about your mentor</li><li>Generate a list of at least 5 interview questions that you''d like to ask your mentor.</li><li>Consider things you already know but would like to know more about as well as things you don’t know about them.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (137, 785, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (138, 789, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (130, 784, 136, TRUE, 100, 0);

--Mentee Lesson 9.1.9

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (110, 5, 43, '7/12/15 00:00:00', '7/12/15 23:59:59', 'Interview Your Mentor');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (341, 110, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (342, 110, 2, 2, 3, 200, 'Who would you like to interview?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (343, 110, 2, 3, 3, 300, 'Interviewing your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (569, 341, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (570, 341, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (571, 342, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (572, 342, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (573, 343, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (790, 569, 11, 100, NULL, NULL, 'Your mentor wrote to you about healthy relationships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (791, 570, 11, 100, NULL, NULL, 'Respond to your mentor. Answer the following questions:<ul><li>What do you think about your mentor’s definition of a healthy relationship?</li><li>How can you apply what your mentor wrote to your relationship with them this year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (792, 571, 11, 100, NULL, NULL, 'Click through the slideshow and pick a person to interview:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (793, 571, 6, 200, NULL, 'https://docs.google.com/presentation/d/17aces--6sTkYIjru1E7dhljLyzNoma-On3oZWtbWH-Q/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (794, 572, 11, 100, NULL, NULL, 'Based on what you already know about the person, think about the following:<ul><li>What interview questions would be the most informative?</li><li>What would give you insight into who this person really is?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (795, 573, 11, 100, NULL, NULL, '<ul><li>Review what you already know about your mentor</li><li>Generate a list of at least 5 interview questions that you''d like to ask your mentor.</li><li>Consider things you already know but would like to know more about as well as things you don’t know about them.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (139, 791, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (140, 795, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (131, 790, 136, TRUE, 100, 0);

--Mentor Lesson 9.1.9

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (111, 4, 43, '7/12/15 00:00:00', '7/12/15 23:59:59', 'Interview Your Mentor');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (344, 111, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (345, 111, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (574, 344, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (575, 344, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (576, 344, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (577, 345, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (796, 574, 11, 100, NULL, NULL, 'Your mentee responded to what you wrote about healthy relationships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (797, 575, 11, 100, NULL, NULL, 'Then your mentee discussed the purpose of interviews and the difference between good and bad interview questions.<p><p>They used that discussion to generate a list of interview questions for you. Here are their questions.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (798, 576, 11, 100, NULL, NULL, 'Answer your mentee’s questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (799, 577, 11, 100, NULL, NULL, 'Think of share at least 5 interview questions of your own. What else would you like to know about your mentee? What follow up questions do you have about things your mentee may have shared in previous lessons?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (141, 798, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (142, 799, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (132, 796, 139, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (133, 797, 140, TRUE, 100, 0);

--Staff Lesson 9.1.10

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (44, 1, '7/13/15 00:00:00', '7/13/15 23:59:59', 1, 2, 10, NULL, 'Becoming a Pair');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (112, 1, 44, '7/13/15 00:00:00', '7/13/15 23:59:59', 'Becoming a Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (346, 112, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (347, 112, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (348, 112, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (349, 112, 2, 2, 3, 400, 'Expectation vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (350, 112, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (578, 346, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (579, 346, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (580, 347, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (581, 348, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (582, 348, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (583, 349, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (584, 350, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (801, 578, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will share their relationship expectations with their mentors. They will also share what they hope to learn from their mentors and what they hope their mentors will learn from them.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Apply their definitions of a healthy relationship to their relationship with their mentor</li><li>Identify and define the importance of setting clear expectations</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/becoming-a-pair-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (802, 579, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (803, 579, 6, 200, NULL, 'https://docs.google.com/presentation/d/1e6dXJzGqvYi_yT_9jlpMED3y6F447QKzZql1z49t9X0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (804, 580, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (805, 581, 11, 100, NULL, NULL, 'Read your mentor’s responses to your interview questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (806, 582, 11, 100, NULL, NULL, 'Your mentor created a list of interview questions for you. Read your mentor’s questions and answer them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (807, 583, 9, 100, NULL, '/new_platform/static/canvas/images/Expectation_vs_Reality.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (808, 583, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Why is setting expectations important?</li><li>What does “expectations vs reality” mean?</li><li>Why are they often opposed?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (809, 584, 11, 100, NULL, NULL, 'Now that you’ve discussed the importance of setting clear expectations, share the following with your mentor:<ul><li>What 2-3 things do you hope to learn from your mentor over the next year?</li><li>What 2-3 things can your mentor hope to learn from you over the next year?</li><li>What do you expect from your mentor to help you build a healthy relationship?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (143, 806, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (144, 809, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (134, 805, 141, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (135, 806, 142, TRUE, 100, 0);

--Mentee Lesson 9.1.10

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (113, 5, 44, '7/13/15 00:00:00', '7/13/15 23:59:59', 'Becoming a Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (351, 113, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (352, 113, 2, 2, 3, 200, 'Expectation vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (353, 113, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (585, 351, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (586, 351, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (587, 352, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (588, 353, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (810, 585, 11, 100, NULL, NULL, 'Read your mentor’s responses to your interview questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (811, 586, 11, 100, NULL, NULL, 'Your mentor created a list of interview questions for you. Read your mentor’s questions and answer them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (812, 587, 9, 100, NULL, '/new_platform/static/canvas/images/Expectation_vs_Reality.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (813, 587, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Why is setting expectations important?</li><li>What does “expectations vs reality” mean?</li><li>Why are they often opposed?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (814, 588, 11, 100, NULL, NULL, 'Now that you’ve discussed the importance of setting clear expectations, share the following with your mentor:<ul><li>What 2-3 things do you hope to learn from your mentor over the next year?</li><li>What 2-3 things can your mentor hope to learn from you over the next year?</li><li>What do you expect from your mentor to help you build a healthy relationship?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (145, 811, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (146, 814, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (136, 810, 141, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (137, 811, 142, TRUE, 100, 0);

--Mentor Lesson 9.1.10

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (114, 4, 44, '7/13/15 00:00:00', '7/13/15 23:59:59', 'Becoming a Pair');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (354, 114, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (355, 114, 2, 2, 2, 200, 'Setting expectations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (589, 354, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (590, 354, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (591, 355, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (592, 355, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (815, 589, 11, 100, NULL, NULL, 'Your mentee read and answered your interview questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (816, 590, 9, 100, NULL, '/new_platform/static/canvas/images/Expectation_vs_Reality.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (817, 590, 11, 200, NULL, NULL, 'The class also discussed how expectations are sometimes different from reality. They then discussed the importance of setting clear expectations to help build a healthy relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (818, 591, 11, 100, NULL, NULL, 'Your mentee shared what they’d like to learn from you, what you could learn from them, and what expectations they will have of you this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (819, 592, 11, 100, NULL, NULL, 'Respond to your mentee and share the following:<ul><li>What 2-3 things do you hope to learn from your mentee this year?</li><li>What 2-3 things can your mentee hope to learn from you over the next year?</li><li>What do you expect from your mentee as you build a healthy relationship?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (147, 819, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (138, 815, 145, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (139, 818, 146, TRUE, 100, 0);

--Staff Lesson 9.1.11

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (45, 1, '7/14/15 00:00:00', '7/14/15 23:59:59', 1, 2, 11, NULL, '9th Grade SMART Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (115, 1, 45, '7/14/15 00:00:00', '7/14/15 23:59:59', '9th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (356, 115, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (357, 115, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (358, 115, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (359, 115, 2, 2, 3, 400, 'Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (360, 115, 2, 3, 3, 500, 'Setting 9th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (593, 356, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (594, 356, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (595, 357, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (596, 358, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (597, 358, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (598, 359, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (599, 359, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (600, 360, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (820, 593, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will examine the SMART goal setting framework and create 9th grade SMART goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Examine and understand the SMART goal framework</li><li>Create 1 short and long-term goal</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/9th-grade-smart-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (821, 594, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (822, 594, 6, 200, NULL, 'https://docs.google.com/presentation/d/1reUnZ9n5zmqIDKMvqrDQVNqyATBFu7St1hDRtUMujeY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (823, 595, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (824, 596, 11, 100, NULL, NULL, 'Your mentor responded and shared their expectations of you and what they hope you can learn from each other.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (825, 597, 11, 100, NULL, NULL, 'Respond to your mentor. Think about the following:<ul><li>How similar or different are your expectations?</li><li>What are you excited about to learn from your mentor?</li><li>What are you excited to teach your mentor?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (826, 598, 9, 100, NULL, '/new_platform/static/canvas/images/Goal_Plan_Wish.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (827, 598, 11, 200, NULL, NULL, 'Reflect on the following questions:<ul><li>What do you think this quote means?</li><li>Why would this be true?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (828, 599, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (829, 599, 11, 200, NULL, NULL, 'Read the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (830, 600, 11, 100, NULL, NULL, 'Now draft your own SMART goals using the framework you just learned.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (831, 600, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rT5j53TzWqJAebmdF1GO3zpaiVlmdBJnIA9ZI8U6C9Q/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (148, 825, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (140, 824, 147, TRUE, 100, 0);

--Mentee Lesson 9.1.11

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (116, 5, 45, '7/14/15 00:00:00', '7/14/15 23:59:59', '9th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (361, 116, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (362, 116, 2, 2, 3, 200, 'Introduction to SMART Goals');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (363, 116, 2, 3, 3, 300, 'Setting 9th Grade SMART Goals');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (601, 361, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (602, 361, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (603, 362, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (604, 362, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (605, 363, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (832, 601, 11, 100, NULL, NULL, 'Your mentor responded and shared their expectations of you and what they hope you can learn from each other.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (833, 602, 11, 100, NULL, NULL, 'Respond to your mentor. Think about the following:<ul><li>How similar or different are your expectations?</li><li>What are you excited about to learn from your mentor?</li><li>What are you excited to teach your mentor?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (834, 603, 9, 100, NULL, '/new_platform/static/canvas/images/Goal_Plan_Wish.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (835, 603, 11, 200, NULL, NULL, 'Reflect on the following questions:<ul><li>What do you think this quote means?</li><li>Why would this be true?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (836, 604, 9, 100, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (837, 604, 11, 200, NULL, NULL, 'Read the infographic and reflect on the following questions:<ul><li>How would you define these terms in your own words?</li><li>Why are each of these steps important to setting goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (838, 605, 11, 100, NULL, NULL, 'Now draft your own SMART goals using the framework you just learned.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (839, 605, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rT5j53TzWqJAebmdF1GO3zpaiVlmdBJnIA9ZI8U6C9Q/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (149, 833, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (141, 832, 147, TRUE, 100, 0);

--Mentor Lesson 9.1.11

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (117, 4, 45, '7/14/15 00:00:00', '7/14/15 23:59:59', '9th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (364, 117, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (365, 117, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (606, 364, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (607, 364, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (608, 364, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (609, 365, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (840, 606, 11, 100, NULL, NULL, 'Your mentee responded to you from last time.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (841, 607, 11, 100, NULL, NULL, 'They then moved on to goal setting.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (842, 607, 9, 200, NULL, '/new_platform/static/canvas/images/Goal_Plan_Wish.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (843, 608, 11, 100, NULL, NULL, 'Your mentee learned about setting SMART goals. Use the infographic below to review the components of the SMART goal framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (844, 608, 9, 200, NULL, '/new_platform/static/canvas/images/SMART_Goals.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (845, 609, 11, 100, NULL, NULL, 'Your mentee set their own SMART goal. Use their SMART goal setting sheet below and share notes and suggestions for each of the five components.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (846, 609, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rT5j53TzWqJAebmdF1GO3zpaiVlmdBJnIA9ZI8U6C9Q/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (142, 840, 149, TRUE, 100, 0);

--Staff Lesson 10.1.5

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (46, 1, '7/15/15 00:00:00', '7/15/15 23:59:59', 2, 4, 5, NULL, 'Growth Mindset Revisited');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (118, 1, 46, '7/15/15 00:00:00', '7/15/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (366, 118, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (367, 118, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (368, 118, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (369, 118, 2, 2, 3, 400, 'Growth Mindset Self-Assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (370, 118, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (610, 366, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (611, 366, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (612, 367, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (613, 368, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (614, 369, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (615, 369, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (616, 369, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (617, 369, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (618, 369, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (619, 369, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (620, 369, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (621, 369, 800);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (622, 370, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (847, 610, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will revisit the difference between a growth and fixed mindset and apply that concept as mentees reflect on their progress.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define and explain the characteristics of a fixed mindset</li><li>Define and explain the characteristics of a growth mindset</li><li>Complete a growth mindset self-assessment and share reflections with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/growth-mindset-revisited-10" target="_blank">here</a>.</b<', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (848, 611, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (849, 611, 6, 200, NULL, 'https://docs.google.com/presentation/d/1142bL9QKtJ_H_hAi0a4EpWLpDJeiREIiE4NhX3UgAek/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (850, 612, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (851, 613, 11, 100, NULL, NULL, 'Read your mentor’s responses. Your mentor responded to the differences and challenges you’ve identified between 9th and 10th grade and shared strategies for how you might address them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (852, 614, 11, 100, NULL, NULL, 'Rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (853, 615, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (854, 616, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (855, 617, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (856, 618, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (857, 619, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (858, 620, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (859, 621, 11, 100, NULL, NULL, 'Review your self-assessment and select 1-2 areas that you''d like to improve in this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (860, 622, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What areas of improvement did you choose and why did you choose them?</li><li>What are some steps you can take to improve in those areas?</li><li>How can your mentor help you to improve in those areas?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (150, 853, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (151, 854, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (152, 855, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (153, 856, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (154, 857, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (155, 858, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (156, 860, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (143, 851, 51, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (144, 851, 50, TRUE, 200, 0);

--Mentee Lesson 10.1.5

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (119, 5, 46, '7/15/15 00:00:00', '7/15/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (371, 119, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (372, 119, 2, 2, 3, 200, 'Growth Mindset Self-Assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (373, 119, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (623, 371, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (624, 372, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (625, 372, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (626, 372, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (627, 372, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (628, 372, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (629, 372, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (630, 372, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (631, 372, 800);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (632, 373, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (861, 623, 11, 100, NULL, NULL, 'Read your mentor’s responses. Your mentor responded to the differences and challenges you’ve identified between 9th and 10th grade and shared strategies for how you might address them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (862, 624, 11, 100, NULL, NULL, 'Rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (863, 625, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (864, 626, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (865, 627, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (866, 628, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (867, 629, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (868, 630, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (869, 631, 11, 100, NULL, NULL, 'Review your self-assessment and select 1-2 areas that you''d like to improve in this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (870, 632, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What areas of improvement did you choose and why did you choose them?</li><li>What are some steps you can take to improve in those areas?</li><li>How can your mentor help you to improve in those areas?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (157, 863, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (158, 864, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (159, 865, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (160, 866, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (161, 867, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (162, 868, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (163, 870, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (145, 861, 51, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (146, 861, 50, TRUE, 200, 0);

--Mentor Lesson 10.1.5

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (120, 4, 46, '7/15/15 00:00:00', '7/15/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (374, 120, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (375, 120, 2, 2, 3, 200, 'Read and respond to your mentee’s assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (376, 120, 2, 3, 3, 300, 'Growth mindset in your relationship');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (633, 374, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (634, 375, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (635, 375, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (636, 375, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (637, 375, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (638, 375, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (639, 375, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (640, 375, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (641, 376, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (642, 376, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (871, 633, 11, 100, NULL, NULL, 'Your mentee reflected on how they utilize a growth mindset and completed a self-assessment. Want to learn more about what a growth mindset is and how to help your mentee utilize one? Click <a href="https://learn.imentor.org/help/article/link/how-to-develop-a-growth-mindset-voice" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (872, 634, 11, 100, NULL, NULL, 'Your mentee ranked themselves from 1-5 on the following statements. Read your mentee’s response and share your thoughts about their self-assessment.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (873, 635, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (874, 636, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (875, 637, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (876, 638, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (877, 639, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (878, 640, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (879, 641, 11, 100, NULL, NULL, 'After completing their self-assessments, mentees selected 1-2 areas of improvement they’d like to focus on this year and shared why they chose them, what steps they plan to take, and how you can help.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (880, 642, 11, 100, NULL, NULL, 'Respond to your mentee and share your reflection on their overall self-assessment and areas of improvement.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (164, 873, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (165, 874, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (166, 875, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (167, 876, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (168, 877, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (169, 878, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (170, 880, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (147, 873, 157, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (148, 874, 158, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (149, 875, 159, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (150, 876, 160, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (151, 877, 161, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (152, 878, 162, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (153, 879, 163, TRUE, 100, 0);

--Update text errors across multiple lessons

UPDATE canvas_widget_content
SET html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.'
WHERE id IN (399,875);

UPDATE canvas_widget_content
SET html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>'
WHERE html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>';

UPDATE canvas_widget_content_copy
SET html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>'
WHERE html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>';

UPDATE canvas_widget_content
SET html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.'
WHERE html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.';

UPDATE canvas_widget_content_copy
SET html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.'
WHERE html = 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.';