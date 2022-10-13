--9.3.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (73, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 17, 2, NULL, 'What Are You Best At?', '/new_platform/static/canvas/images/9.3.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (199, 1, 73, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What Are You Best At?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (643, 199, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (644, 199, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (645, 199, 2, 1, 3, 300, 'Read your mentor’s example');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (646, 199, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (647, 199, 2, 3, 3, 500, 'Describe your success');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1148, 643, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1149, 643, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1150, 643, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1151, 644, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1152, 645, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1153, 645, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1154, 646, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1155, 647, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1156, 647, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1157, 647, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1508, 1148, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore the process of learning to learn by focusing on an area in which they excel in and reflecting on how they learned these skills.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on a personal skill and the process of developing this skill</li><li>Identify specific growth mindset actions that contribute to success</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-what-are-you-best-at" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1509, 1149, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1510, 1149, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ehNT-ShygeI-i-RihusXdix9ClJFpmKv8BJHxpAgKNk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1511, 1150, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1512, 1150, 3, 200, NULL, 'https://vimeo.com/140669042', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1513, 1151, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1514, 1152, 11, 100, NULL, NULL, 'Your mentor wrote to you about your definitions of “growth mindset” and “fixed mindset”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1515, 1153, 11, 100, NULL, NULL, 'Read your mentor’s example about how they utilize a growth mindset in their work or personal lives.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1516, 1154, 11, 100, NULL, NULL, 'Watch the following video of a post-game interview with a HS football player after a close win. As you watch, consider the following.<ul><li>Why is Apollos so animated about his team’s success?</li><li>Do you think he would have been this excited if his team was winning from the beginning of the game? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1517, 1154, 3, 200, NULL, 'https://vimeo.com/140669042', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1518, 1155, 11, 100, NULL, NULL, 'What are you the “champion” of? This can be a skill you have, subject area in school, a relationship, something you do at home, or anything that you think you''re really good at. Tell your mentor about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1519, 1156, 11, 100, NULL, NULL, 'Describe how you become a “champion” in this area? Name three specific actions that you took to develop your skill.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1520, 1157, 11, 100, NULL, NULL, 'How does your story demonstrate growth mindset?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (333, 1518, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (334, 1519, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (335, 1520, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (323, 1514, 284, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (324, 1515, 285, TRUE, 100, 0);

--9.3.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (200, 5, 73, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What Are You Best At?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (648, 200, 2, 1, 3, 100, 'Read your mentor’s example');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (649, 200, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (650, 200, 2, 3, 3, 300, 'Describe your success');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1158, 648, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1159, 648, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1160, 649, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1161, 650, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1162, 650, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1163, 650, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1521, 1158, 11, 100, NULL, NULL, 'Your mentor wrote to you about your definitions of “growth mindset” and “fixed mindset”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1522, 1159, 11, 100, NULL, NULL, 'Read your mentor’s example about how they utilize a growth mindset in their work or personal lives.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1523, 1160, 11, 100, NULL, NULL, 'Watch the following video of a post-game interview with a HS football player after a close win. As you watch, consider the following.<ul><li>Why is Apollos so animated about his team’s success?</li><li>Do you think he would have been this excited if his team was winning from the beginning of the game? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1524, 1160, 3, 200, NULL, 'https://vimeo.com/140669042', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1525, 1161, 11, 100, NULL, NULL, 'What are you the “champion” of? This can be a skill you have, subject area in school, a relationship, something you do at home, or anything that you think you''re really good at. Tell your mentor about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1526, 1162, 11, 100, NULL, NULL, 'Describe how you become a “champion” in this area? Name three specific actions that you took to develop your skill.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1527, 1163, 11, 100, NULL, NULL, 'How does your story demonstrate growth mindset?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (336, 1525, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (337, 1526, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (338, 1527, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (325, 1521, 284, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (326, 1522, 285, TRUE, 100, 0);

--9.3.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (201, 4, 73, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What Are You Best At?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (651, 201, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (652, 201, 2, 2, 3, 200, 'Reflect on your mentee’s success');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (653, 201, 2, 3, 3, 300, 'Reflect on your success');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1164, 651, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1165, 651, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1166, 652, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1167, 652, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1168, 652, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1169, 653, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1528, 1164, 11, 100, NULL, NULL, 'Your mentee watched the following video to discuss attitudes and actions that lead to success.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1529, 1164, 3, 200, NULL, 'https://vimeo.com/140669042', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1530, 1165, 11, 100, NULL, NULL, 'After watching the video, your mentee’s class discussed these questions:<ul><li>Why is Apollos so animated about his team’s success?</li><li>Do you think he would have been this excited if his team was winning from the beginning of the game? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1531, 1166, 11, 100, NULL, NULL, 'Your mentee thought about a skill they have, or something they consider themselves to be a “champion” of.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1532, 1167, 11, 100, NULL, NULL, 'Read your mentee’s description of their skill and the actions that helped them succeed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1533, 1168, 11, 100, NULL, NULL, 'Respond to your mentee. What resonated with you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1534, 1169, 11, 100, NULL, NULL, 'Now it’s your turn. Tell your mentee about  a skill that you have, or something you consider yourself to be a “champion” of.<ul><li>What skill did you choose?</li><li>How did you become a “champion” in this area? (be specific!)</li><li>How does your story demonstrate growth mindset?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (339, 1533, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (340, 1534, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (327, 1532, 336, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (328, 1532, 337, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (329, 1532, 338, TRUE, 300, 0);

--9.3.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (74, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 17, 3, NULL, 'Changing My Mindset', '/new_platform/static/canvas/images/9.3.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (202, 1, 74, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Changing My Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (654, 202, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (655, 202, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (656, 202, 2, 1, 3, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (657, 202, 2, 2, 3, 400, 'Visualize success');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (658, 202, 2, 3, 3, 500, 'Visualize your pathway');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1170, 654, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1171, 654, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1172, 655, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1173, 656, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1174, 656, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1175, 657, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1176, 657, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1177, 657, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1178, 658, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1179, 658, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1180, 658, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1535, 1170, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will visualize success in an area that matters to them and represent how growth mindset actions can contribute to this success.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create a visual representation of a pathway to success in an area of personal importance</li><li>Complete the Canvas closing template</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-changing-my-mindset" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1536, 1171, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1537, 1171, 6, 200, NULL, 'https://docs.google.com/presentation/d/1G4rjCb0CZowfP9IrK3WowyvQWMsFFmdMQP_F1h4XtDA/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1538, 1172, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1539, 1173, 11, 100, NULL, NULL, 'Your mentor shared their thoughts on your story and how it demonstrates  growth mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1540, 1174, 11, 100, NULL, NULL, 'Your mentor wrote you about what they are good at and how they became good. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1541, 1175, 11, 100, NULL, NULL, 'Think about something you’ve always wanted to be successful at. This can be a new skill you want to learn, a challenge you want to overcome, or something you’re already good at and want to expand your success.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1542, 1176, 11, 100, NULL, NULL, 'Create a poster in Google Drawings that visualizes the success you want to achieve, why it is important to you, and how you will know when you achieve success.<p><p>Click <a href="https://docs.google.com/drawings/d/1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA/edit?usp=sharing" target="_blank">here</a> to start your poster.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1543, 1177, 11, 100, NULL, NULL, 'If you need a reminder on how to use Google Drawings, watch this short video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1544, 1177, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1545, 1178, 11, 100, NULL, NULL, 'Tell your mentor:<ul><li>What are some challenges that you might face (or are already facing) when pursuing success?</li><li>What specific actions will you take in response to these challenges?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1546, 1179, 11, 100, NULL, NULL, 'Who are some people who can support you on your way to success?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1547, 1180, 11, 100, NULL, NULL, 'Return to the poster you started earlier. Improve your image to represent your pathway to success. Some things to add include:<ul><li>Challenges you think you might face</li><li>How you will respond to these challenges</li><li>People who will support your success</li></ul><p><p>You can click <a href="https://docs.google.com/drawings/d/1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA/edit?usp=sharing" target="_blank">here</a> to return to your poster.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (341, 1545, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (342, 1546, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (330, 1539, 339, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (331, 1540, 340, TRUE, 100, 0);

--9.3.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (203, 5, 74, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Changing My Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (659, 203, 2, 1, 3, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (660, 203, 2, 2, 3, 200, 'Visualize success');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (661, 203, 2, 3, 3, 300, 'Visualize your pathway');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1181, 659, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1182, 659, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1183, 660, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1184, 660, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1185, 660, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1186, 661, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1187, 661, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1188, 661, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1548, 1181, 11, 100, NULL, NULL, 'Your mentor shared their thoughts on your story and how it demonstrates  growth mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1549, 1182, 11, 100, NULL, NULL, 'Your mentor wrote you about what they are good at and how they became good. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1550, 1183, 11, 100, NULL, NULL, 'Think about something you’ve always wanted to be successful at. This can be a new skill you want to learn, a challenge you want to overcome, or something you’re already good at and want to expand your success.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1551, 1184, 11, 100, NULL, NULL, 'Create a poster in Google Drawings that visualizes the success you want to achieve, why it is important to you, and how you will know when you achieve success.<p><p>Click <a href="https://docs.google.com/drawings/d/1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA/edit?usp=sharing" target="_blank">here</a> to start your poster.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1552, 1185, 11, 100, NULL, NULL, 'If you need a reminder on how to use Google Drawings, watch this short video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1553, 1185, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1554, 1186, 11, 100, NULL, NULL, 'Tell your mentor:<ul><li>What are some challenges that you might face (or are already facing) when pursuing success?</li><li>What specific actions will you take in response to these challenges?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1555, 1187, 11, 100, NULL, NULL, 'Who are some people who can support you on your way to success?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1556, 1188, 11, 100, NULL, NULL, 'Return to the poster you started earlier. Improve your image to represent your pathway to success. Some things to add include:<ul><li>Challenges you think you might face</li><li>How you will respond to these challenges</li><li>People who will support your success</li></ul><p><p>You can click <a href="https://docs.google.com/drawings/d/1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA/edit?usp=sharing" target="_blank">here</a> to return to your poster.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (343, 1554, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (344, 1555, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (332, 1548, 339, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (333, 1549, 340, TRUE, 100, 0);

--9.3.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (204, 4, 74, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Changing My Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (662, 204, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1189, 662, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1190, 662, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1191, 662, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1557, 1189, 11, 100, NULL, NULL, 'Before you get started, if you’d like to learn more about growth mindset and how to help your mentee utilize one, click <a href="https://learn.imentor.org/help/article/link/how-to-develop-a-growth-mindset-voice" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1558, 1190, 11, 100, NULL, NULL, 'Your mentee created a poster in Google Drawings to visualize their pathway to the success they imagine.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1559, 1190, 6, 200, NULL, 'https://docs.google.com/drawings/d/1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1560, 1191, 11, 100, NULL, NULL, 'Your mentee shared the challenges they might face along their pathway to success, how they will respond, and some people who will support them.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (334, 1560, 343, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (335, 1560, 344, TRUE, 200, 0);

--11.4.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (19, 4, 'My College Pathway', 'college_pathway', 'Do I believe I can go to college?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (19, 3, 19, '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li><li>How has this unit influenced your thinking about college and going to college?</li></ul>', '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li><li>How has this unit influenced your thinking about college and going to college?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (75, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 19, 1, NULL, 'What is a Degree Worth?', '/new_platform/static/canvas/images/11.4.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (205, 1, 75, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Degree Worth?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (663, 205, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (664, 205, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (665, 205, 2, 1, 5, 300, 'Read the article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (666, 205, 2, 2, 5, 400, 'The value of a college degree');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (667, 205, 2, 3, 5, 500, 'Salaries by major');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (668, 205, 2, 4, 5, 600, 'It’s not just about the money');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (669, 205, 2, 5, 5, 700, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1192, 663, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1193, 663, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1194, 664, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1195, 665, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1196, 666, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1197, 667, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1198, 668, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1199, 669, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1200, 669, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1201, 669, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1561, 1192, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to help mentees explore and examine the value of a college degree, not just in general, but by weighing all the critical factors that matter to mentees.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review an article and infographic describing the value of a college degree.</li><li>Compare and contrast the value of degrees across college majors.</li><li>Examine and discuss the value of a college degree along multiple data points.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/what-is-a-degree-worth" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1562, 1193, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1563, 1193, 6, 200, NULL, 'https://docs.google.com/presentation/d/1kGDsM5x_GTcrhfTcfWMZBfJRbEGCO9FeXF7_oMzDLpQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1564, 1194, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1565, 1195, 11, 100, NULL, NULL, 'Read the article and think about the following questions:<ul><li>What is the article’s message about the value of a college degree?</li><li>What economic trends does the article mention? How do they impact the value of degrees?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1566, 1195, 8, 200, NULL, '/new_platform/static/canvas/documents/Value_College_Degree.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1567, 1196, 11, 100, NULL, NULL, 'Look at the infographic below and consider the following question:<ul><li>What are 2-3 conclusions you can generate based on the information presented?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1568, 1196, 9, 200, NULL, '/new_platform/static/canvas/images/Collegeboard_Cost_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1569, 1197, 11, 100, NULL, NULL, 'Review the infographic below and consider the following questions:<ul><li>Why would the annual salaries across majors differ so greatly?</li><li>How can you use this information when considering your own college major?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1570, 1197, 9, 200, NULL, '/new_platform/static/canvas/images/Highest_Starting_Wages.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1571, 1198, 11, 100, NULL, NULL, 'Review the infographic below and consider the following questions:<ul><li>What other factors are important when considering the value of a college degree?</li><li>How would going to college positively impact these areas?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1572, 1198, 9, 200, NULL, '/new_platform/static/canvas/images/College_Degree_Worth.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1573, 1199, 11, 100, NULL, NULL, 'What have you learned about the value of a college degree? Does going to college align with your personal goals?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1574, 1200, 11, 100, NULL, NULL, 'Have you thought about your career goals and potential college majors? If so, what are they?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1575, 1201, 11, 100, NULL, NULL, 'What questions and concerns do you still have about attending college?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (345, 1573, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (346, 1574, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (347, 1575, 100, 0, 2);

--11.4.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (206, 5, 75, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Degree Worth?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (670, 206, 2, 1, 5, 100, 'Read the article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (671, 206, 2, 2, 5, 200, 'The value of a college degree');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (672, 206, 2, 3, 5, 300, 'Salaries by major');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (673, 206, 2, 4, 5, 400, 'It’s not just about the money');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (674, 206, 2, 5, 5, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1202, 670, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1203, 671, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1204, 672, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1205, 673, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1206, 674, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1207, 674, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1208, 674, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1576, 1202, 11, 100, NULL, NULL, 'Read the article and think about the following questions:<ul><li>What is the article’s message about the value of a college degree?</li><li>What economic trends does the article mention? How do they impact the value of degrees?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1577, 1202, 8, 200, NULL, '/new_platform/static/canvas/documents/Value_College_Degree.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1578, 1203, 11, 100, NULL, NULL, 'Look at the infographic below and consider the following question:<ul><li>What are 2-3 conclusions you can generate based on the information presented?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1579, 1203, 9, 200, NULL, '/new_platform/static/canvas/images/Collegeboard_Cost_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1580, 1204, 11, 100, NULL, NULL, 'Review the infographic below and consider the following questions:<ul><li>Why would the annual salaries across majors differ so greatly?</li><li>How can you use this information when considering your own college major?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1581, 1204, 9, 200, NULL, '/new_platform/static/canvas/images/Highest_Starting_Wages.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1582, 1205, 11, 100, NULL, NULL, 'Review the infographic below and consider the following questions:<ul><li>What other factors are important when considering the value of a college degree?</li><li>How would going to college positively impact these areas?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1583, 1205, 9, 200, NULL, '/new_platform/static/canvas/images/College_Degree_Worth.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1584, 1206, 11, 100, NULL, NULL, 'What have you learned about the value of a college degree? Does going to college align with your personal goals?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1585, 1207, 11, 100, NULL, NULL, 'Have you thought about your career goals and potential college majors? If so, what are they?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1586, 1208, 11, 100, NULL, NULL, 'What questions and concerns do you still have about attending college?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (348, 1584, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (349, 1585, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (350, 1586, 100, 0, 2);

--11.4.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (207, 4, 75, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Degree Worth?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (675, 207, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (676, 207, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1209, 675, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1210, 675, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1211, 675, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1212, 675, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1213, 676, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1587, 1209, 11, 100, NULL, NULL, 'Your mentee read the following article about the value of a college degree.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1588, 1209, 8, 200, NULL, '/new_platform/static/canvas/documents/Value_College_Degree.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1589, 1210, 11, 100, NULL, NULL, 'Then, your mentee viewed and discussed the 3 infographics below on the value of a college degree, starting salaries by college major, and the true value of a college education.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1590, 1210, 9, 200, NULL, '/new_platform/static/canvas/images/Collegeboard_Cost_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1591, 1210, 9, 300, NULL, '/new_platform/static/canvas/images/Highest_Starting_Wages.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1592, 1210, 9, 400, NULL, '/new_platform/static/canvas/images/College_Degree_Worth.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1593, 1211, 11, 100, NULL, NULL, 'Based on the information covered in the article and infographics above, your mentee answered the following questions.<ul><li>What have you learned about the value of a college degree? </li><li>Does going to college align with your personal goals?</li><li>Have you thought about your career goals and potential college majors? If so, what are they?</li><li>What questions and concerns do you still have about attending college?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1594, 1212, 11, 100, NULL, NULL, '<ul><li>Respond to your mentee’s reflections with specific feedback.</li><li>If your mentee shared any questions or concerns, be sure to address them.</li><li>Share advice with your mentee on their potential majors.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1595, 1213, 11, 100, NULL, NULL, 'It is easy to focus only on the financial benefits of a college degree. Share the bigger picture with your mentee:<ul><li>Was going to college worth it for you? How so?</li><li>How has going to college positively impacted your life?</li><li>When choosing a major, what considerations were most important to you? Were there other factors you wish you had considered? What were they?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (351, 1594, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (352, 1595, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (336, 1593, 348, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (337, 1593, 349, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (338, 1593, 350, TRUE, 300, 0);

--11.4.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (76, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 19, 2, NULL, 'Getting In and Breaking Through', '/new_platform/static/canvas/images/11.4.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (208, 1, 76, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Getting In and Breaking Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (677, 208, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (678, 208, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (679, 208, 2, 1, 3, 300, 'Respond to your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (680, 208, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (681, 208, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1214, 677, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1215, 677, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1216, 677, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1217, 678, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1218, 679, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1219, 679, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1220, 679, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1221, 680, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1222, 680, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1223, 680, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1224, 681, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1225, 681, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1596, 1214, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to provide new and first-generation college students with opportunities to ask and answer common questions and challenges.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Watch and discuss a video on being a first generation college student.</li><li>Generate a list of questions and challenges common to new college students.</li><li>Use web resources to resolve the questions and challenges.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/getting-in-and-breaking-through" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1597, 1215, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1598, 1215, 6, 200, NULL, 'https://docs.google.com/presentation/d/1oCL45h-yz-yR0xp3xrK8oJy-M1XwCWHJHxWO85Fss-0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1599, 1216, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1600, 1216, 3, 200, NULL, 'https://vimeo.com/140342459', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1601, 1217, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1602, 1218, 11, 100, NULL, NULL, 'Your mentor responded to your thoughts about the value of a college degree and potential college majors.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1603, 1219, 11, 100, NULL, NULL, 'Your mentor also shared some thoughts about how a college degree impacted their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1604, 1220, 11, 100, NULL, NULL, 'Respond to your mentor.<ul><li>What stood out to you?</li><li>Did they share a benefit you hadn’t thought about before? How has it changed your perception of the value of a college degree?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1605, 1221, 3, 100, NULL, 'https://vimeo.com/140342459', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1606, 1221, 11, 200, NULL, NULL, 'Consider the following questions:<ul><li>What are your immediate takeaways from the video?</li><li>What would you ask the person in the video about being a 1st generation college student?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1607, 1222, 11, 100, NULL, NULL, 'Now read the quote.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1608, 1222, 9, 200, NULL, '/new_platform/static/canvas/images/Michelle_First_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1609, 1222, 11, 300, NULL, NULL, 'Consider the following questions about the above quote:<ul><li>Why do you think the person in the video would doubt their ability to attend college?</li><li>Why might others in a similar situation do the same?</li><li>What is their message about addressing those doubts?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1610, 1223, 11, 100, NULL, NULL, 'Generate a list of challenges or questions that a new student might have about college. Visit the following websites to answer those questions:<ul><li><a href="http://www.firstgenerationstudent.com/" target="_blank">First Generation Student</a></li><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1611, 1224, 11, 100, NULL, NULL, 'What stood out to you about the video and the quote?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1612, 1225, 11, 100, NULL, NULL, '<ul><li>What challenge are you most worried about?</li><li>What is a possible solution to that challenge?</li><li>What additional questions do you have about going to college?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (353, 1604, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (354, 1611, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (355, 1612, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (339, 1602, 351, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (340, 1603, 352, TRUE, 100, 0);

--11.4.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (209, 5, 76, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Getting In and Breaking Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (682, 209, 2, 1, 3, 100, 'Respond to your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (683, 209, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (684, 209, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1226, 682, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1227, 682, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1228, 682, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1229, 683, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1230, 683, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1231, 683, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1232, 684, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1233, 684, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1613, 1226, 11, 100, NULL, NULL, 'Your mentor responded to your thoughts about the value of a college degree and potential college majors.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1614, 1227, 11, 100, NULL, NULL, 'Your mentor also shared some thoughts about how a college degree impacted their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1615, 1228, 11, 100, NULL, NULL, 'Respond to your mentor.<ul><li>What stood out to you?</li><li>Did they share a benefit you hadn’t thought about before? How has it changed your perception of the value of a college degree?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1616, 1229, 3, 100, NULL, 'https://vimeo.com/140342459', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1617, 1229, 11, 200, NULL, NULL, 'Consider the following questions:<ul><li>What are your immediate takeaways from the video?</li><li>What would you ask the person in the video about being a 1st generation college student?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1618, 1230, 11, 100, NULL, NULL, 'Now read the quote.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1619, 1230, 9, 200, NULL, '/new_platform/static/canvas/images/Michelle_First_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1620, 1230, 11, 300, NULL, NULL, 'Consider the following questions about the above quote:<ul><li>Why do you think the person in the video would doubt their ability to attend college?</li><li>Why might others in a similar situation do the same?</li><li>What is their message about addressing those doubts?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1621, 1231, 11, 100, NULL, NULL, 'Generate a list of challenges or questions that a new student might have about college. Visit the following websites to answer those questions:<ul><li><a href="http://www.firstgenerationstudent.com/" target="_blank">First Generation Student</a></li><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1622, 1232, 11, 100, NULL, NULL, 'What stood out to you about the video and the quote?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1623, 1233, 11, 100, NULL, NULL, '<ul><li>What challenge are you most worried about?</li><li>What is a possible solution to that challenge?</li><li>What additional questions do you have about going to college?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (356, 1615, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (357, 1622, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (358, 1623, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (341, 1613, 351, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (342, 1614, 352, TRUE, 100, 0);

--11.4.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (210, 4, 76, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Getting In and Breaking Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (685, 210, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (686, 210, 2, 2, 2, 200, 'Prepare your mentee for next week');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1234, 685, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1235, 685, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1236, 685, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1237, 685, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1238, 685, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1239, 685, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1240, 686, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1624, 1234, 11, 100, NULL, NULL, 'Your mentee responded to your reflection about the value of your college degree.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1625, 1235, 11, 100, NULL, NULL, 'Your mentee watched the video below and discussed the following question:<ul><li>What challenges or questions might a first generation college student have about college?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1626, 1235, 3, 200, NULL, 'https://vimeo.com/140342459', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1627, 1236, 11, 100, NULL, NULL, 'Your mentee wrote the following reflection about the video above.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1628, 1237, 11, 100, NULL, NULL, 'Your mentee explored the following resources to answer some of their questions.<ul><li><a href="http://www.firstgenerationstudent.com/" target="_blank">First Generation Student</a></li><li><a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1629, 1238, 11, 100, NULL, NULL, 'Your mentee then wrote the following about the questions/challenges they researched, any challenges that worry them personally, and any additional questions they have about going to college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1630, 1239, 11, 100, NULL, NULL, 'Respond to your mentee. In your response, answer any direct questions your mentee asked and/or help them identify a person or resource that can.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1631, 1240, 11, 100, NULL, NULL, 'Your mentee will soon begin to explore their future aspirations and how they relate to a college identity. Please share the following about your own aspirations:<ul><li>What were your childhood aspirations?</li><li>How have they changed?</li><li>How have your aspirations impacted your journey?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (359, 1630, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (360, 1631, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (343, 1624, 356, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (344, 1627, 357, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (345, 1629, 358, TRUE, 100, 0);