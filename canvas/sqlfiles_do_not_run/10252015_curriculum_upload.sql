--12.4.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (68, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 15, 2, NULL, 'Continuing My Applications', '/new_platform/static/canvas/images/12.4.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (184, 1, 68, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Continuing My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (588, 184, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (589, 184, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (590, 184, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (591, 184, 2, 2, 3, 400, 'Start and improve your essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (592, 184, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1044, 588, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1045, 588, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1046, 589, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1047, 590, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1048, 591, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1049, 592, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1381, 1044, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages mentees through independent work on their applications as well as using peer processing and editing for their essays.<p><p>At the end of this lesson, mentees will:<ul><li>Continue to work on their college applications</li><li>Work in groups to refine and edit their college essays</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/continuing-my-applications" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1382, 1045, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1383, 1045, 6, 200, NULL, 'https://docs.google.com/presentation/d/1COEuI6yxKGfg9Nyz2AyT0xDuZHJxgtI-VndYeKWTuTc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1384, 1046, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1385, 1047, 11, 100, NULL, NULL, 'Your mentor answered your questions and shared their own experiences with applying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1386, 1048, 11, 100, NULL, NULL, 'Use the link below to start, revise, and finish your college essay.<p><p>Reminder: this link will allow your mentor to help you review and edit your essay.</p></p>Start your essay by clicking <a href="https://docs.google.com/document/d/1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg/edit?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1388, 1049, 11, 100, NULL, NULL, 'What’s next?<ul><li>Explain your next steps in the college application process.</li><li>Ask your mentor for help with your applications and essay. Be specific with what you need.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (304, 1388, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (290, 1385, 247, TRUE, 100, 0);

--12.4.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (185, 5, 68, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Continuing My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (593, 185, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (594, 185, 2, 2, 3, 200, 'Start and improve your essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (595, 185, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1050, 593, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1051, 594, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1052, 595, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1389, 1050, 11, 100, NULL, NULL, 'Your mentor answered your questions and shared their own experiences with applying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1390, 1051, 11, 100, NULL, NULL, 'Use the link below to start, revise, and finish your college essay.<p><p>Reminder: this link will allow your mentor to help you review and edit your essay.</p></p>Start your essay by clicking <a href="https://docs.google.com/document/d/1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg/edit?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1392, 1052, 11, 100, NULL, NULL, 'What’s next?<ul><li>Explain your next steps in the college application process.</li><li>Ask your mentor for help with your applications and essay. Be specific with what you need.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (305, 1392, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (291, 1389, 247, TRUE, 100, 0);

--12.4.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (186, 4, 68, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Continuing My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (596, 186, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (597, 186, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1053, 596, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1054, 596, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1055, 597, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1393, 1053, 11, 100, NULL, NULL, 'Your mentee continued to work on their college applications. They also worked on their college essays.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1394, 1054, 11, 100, NULL, NULL, 'Review your mentee’s draft essay and provide feedback using the shared document below. Please keep the following in mind as you read your mentee’s draft:<ul><li>Is the essay specific and clear?</li><li>Does the essay address the prompt directly?</li><li>Is it authentic? Does it accurately reflect your mentee’s voice and perspective?</li></ul><p><p>Read your mentee’s essay by clicking <a href="https://docs.google.com/document/d/1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg/edit?usp=sharing" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1396, 1055, 11, 100, NULL, NULL, 'Respond to your mentee, answer their questions, and share a personal update.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (306, 1396, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (292, 1396, 305, TRUE, 100, 0);

--10.3.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (71, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 3, NULL, 'Comprehend the Problem', '/new_platform/static/canvas/images/10.3.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (193, 1, 71, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comprehend the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (620, 193, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (621, 193, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (622, 193, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (623, 193, 2, 2, 4, 400, 'Define a reliable source');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (624, 193, 2, 3, 4, 500, 'Research your problem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (625, 193, 2, 4, 4, 600, 'Reflect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1100, 620, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1101, 620, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1102, 621, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1103, 622, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1104, 623, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1105, 624, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1106, 624, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1107, 625, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1108, 625, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1109, 625, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1110, 625, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1454, 1100, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will collect information regarding their chosen topic, identify which sources of information are most reliable, and organize that information in a clear and logical way.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Assess a source of information they currently use</li><li>Identify the components that make a resource reliable</li><li>Find reliable resources for their problem statement</li><li>Edit and strengthen their problem statement</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/comprehend-the-problem" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1455, 1101, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1456, 1101, 6, 200, NULL, 'https://docs.google.com/presentation/d/14LWccrtwhG4JkkAFBeulFgE1U2jmJaDT8nF4INsuubw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1457, 1102, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1458, 1103, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the problem statement that you drafted in our last lesson.<p><p>You will have a chance to incorporate your mentor’s feedback into a second draft of your problem statement later in this lesson.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1459, 1104, 9, 100, NULL, '/new_platform/static/canvas/images/reliable-source.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1460, 1104, 11, 200, NULL, NULL, 'Think of one source that you currently and consistently use to get information.<p><p>Consider the following questions about this source.<ul><li>What kind of information do you get from this source?</li><li>Why do you choose to get information from this source over others?</li><li>How do you know the information is reliable (high-quality, trustworthy)?</li></ul></p></p>Based on your analysis, identify 3-5 components of a reliable source of information.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1461, 1105, 11, 100, NULL, NULL, 'Use Google to identify 2-3 reliable sources of information that you can use to research the problem that you chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1462, 1106, 11, 100, NULL, NULL, 'Use these sources to learn more about the problem that you chose. Remember to focus on the 3 components of your problem statement:<ul><li>What is the problem?</li><li>Who does it affect?</li><li>What happens if this problem is not solved?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1463, 1107, 11, 100, NULL, NULL, 'Tell your mentor which information sources you chose. How do you know each source is reliable?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1464, 1108, 11, 100, NULL, NULL, 'As a reminder, here is the problem statement you selected.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1465, 1109, 11, 100, NULL, NULL, 'What are three facts that you found through your research that make your problem statement stronger?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1466, 1110, 11, 100, NULL, NULL, 'Using these three facts and your mentor’s feedback, write a second draft of your problem statement to make it stronger.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (318, 1463, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (319, 1465, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (320, 1466, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (307, 1458, 252, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (308, 1464, 250, TRUE, 100, 0);

--10.3.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (194, 5, 71, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comprehend the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (626, 194, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (627, 194, 2, 2, 4, 200, 'Define a reliable source');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (628, 194, 2, 3, 4, 300, 'Research your problem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (629, 194, 2, 4, 4, 400, 'Reflect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1111, 626, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1112, 627, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1113, 628, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1114, 628, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1115, 629, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1116, 629, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1117, 629, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1118, 629, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1467, 1111, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the problem statement that you drafted in our last lesson.<p><p>You will have a chance to incorporate your mentor’s feedback into a second draft of your problem statement later in this lesson.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1468, 1112, 9, 100, NULL, '/new_platform/static/canvas/images/reliable-source.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1469, 1112, 11, 200, NULL, NULL, 'Think of one source that you currently and consistently use to get information.<p><p>Consider the following questions about this source.<ul><li>What kind of information do you get from this source?</li><li>Why do you choose to get information from this source over others?</li><li>How do you know the information is reliable (high-quality, trustworthy)?</li></ul></p></p>Based on your analysis, identify 3-5 components of a reliable source of information.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1470, 1113, 11, 100, NULL, NULL, 'Use Google to identify 2-3 reliable sources of information that you can use to research the problem that you chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1471, 1114, 11, 100, NULL, NULL, 'Use these sources to learn more about the problem that you chose. Remember to focus on the 3 components of your problem statement:<ul><li>What is the problem?</li><li>Who does it affect?</li><li>What happens if this problem is not solved?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1472, 1115, 11, 100, NULL, NULL, 'Tell your mentor which information sources you chose. How do you know each source is reliable?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1473, 1116, 11, 100, NULL, NULL, 'As a reminder, here is the problem statement you selected.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1474, 1117, 11, 100, NULL, NULL, 'What are three facts that you found through your research that make your problem statement stronger?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1475, 1118, 11, 100, NULL, NULL, 'Using these three facts and your mentor’s feedback, write a second draft of your problem statement to make it stronger.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (321, 1472, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (322, 1474, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (323, 1475, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (309, 1467, 252, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (310, 1473, 250, TRUE, 100, 0);

--10.3.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (195, 4, 71, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comprehend the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (630, 195, 2, 1, 2, 100, 'Identify reliable information');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (631, 195, 2, 2, 2, 200, 'Revise your problem statement');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1119, 630, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1120, 630, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1121, 630, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1122, 631, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1123, 631, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1124, 631, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1476, 1119, 9, 100, NULL, '/new_platform/static/canvas/images/reliable-source.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1477, 1119, 11, 200, NULL, NULL, 'Your mentee thought about what makes information sources reliable by considering the following questions about that source.<ul><li>What kind of information do you get from this source?</li><li>Why do you choose to get information from this source over others?</li><li>How do you know the information is reliable (high-quality, trustworthy)?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1478, 1120, 11, 100, NULL, NULL, 'Your mentee then used these guidelines to identify 2-3 reliable sources of information that they can use to research the problem that they chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1479, 1121, 11, 100, NULL, NULL, 'Provide some feedback on the information sources that your mentee chose.<p><p>If relevant, suggest additional information sources that your mentee could use to learn more about the problem that they chose. Be sure to explain how you know each source is reliable so that your mentee continues to learn how to identify reliable information.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1480, 1122, 11, 100, NULL, NULL, 'Your mentee then used the information sources they identified to find three facts about the problem that they chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1481, 1123, 11, 100, NULL, NULL, 'Your mentee used these three facts and the feedback that you provided on their first draft to revise their problem statement and make it stronger.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1482, 1124, 11, 100, NULL, NULL, 'Continue to provide feedback on your mentee’s problem statement.<p><p>If relevant, offer an argument against the stance your mentee has taken on the problem. This will help your mentee prepare for our next lesson, when they will be exploring different perspectives on the problem that they chose.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (324, 1479, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (325, 1482, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (311, 1478, 321, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (312, 1480, 322, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (313, 1481, 323, TRUE, 100, 0);

--10.3.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (72, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 4, NULL, 'Analyze the Problem', '/new_platform/static/canvas/images/10.3.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (196, 1, 72, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Analyze the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (632, 196, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (633, 196, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (634, 196, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (635, 196, 2, 2, 3, 400, 'Learn to debate both sides');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (636, 196, 2, 3, 3, 500, 'Consider your problem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1125, 632, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1126, 632, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1127, 633, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1128, 634, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1129, 634, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1130, 634, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1131, 635, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1132, 635, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1133, 636, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1134, 636, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1483, 1125, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will analyze the information they''ve collected on their problems and explore different perspectives on how these problems should be resolved.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Practice arguing both sides of an issue</li><li>Assess their problem statement from multiple perspectives</li><li>Use multiple perspectives to strengthen their own argument</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/analyze-the-problem" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1484, 1126, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1485, 1126, 6, 200, NULL, 'https://docs.google.com/presentation/d/1c-Pny_QSCZCplGzqG4e1TzNwuonpGlb2MOBdm_JQBPw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1486, 1127, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1487, 1128, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the information sources that you used to research your problem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1488, 1129, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the second draft of your problem statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1489, 1130, 11, 100, NULL, NULL, 'Provide some reactions to your mentor’s feedback. Write a final draft of your problem statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1490, 1131, 11, 100, NULL, NULL, 'Consider both sides to each of the following arguments:<ul><li>Rap music should be censored on the radio.</li><li>A college education should be completely free for everyone.</li><li>Graffiti should not be illegal; it is art.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1491, 1132, 11, 100, NULL, NULL, 'Reflect on the following questions about these arguments.<ul><li>Which side is easier to argue? Why?</li><li>Why is the opposite argument weak?</li><li>How can you use the opposite argument to strengthen your own?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1492, 1133, 11, 100, NULL, NULL, 'Develop a logical argument for how you believe your problem should be solved.<p><p>Consider the following as you develop your argument.<ul><li>List as much information as you can that supports your argument for solving the problem in this way.</li><li>List a few points that someone might make to argue against solving your problem.</li><li>How would you respond to those points, using evidence from your reliable sources?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1493, 1134, 11, 100, NULL, NULL, 'How can your mentor help you strengthen your argument?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (326, 1489, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (327, 1492, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (328, 1493, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (314, 1487, 324, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (315, 1488, 250, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (316, 1488, 325, TRUE, 200, 0);

--10.3.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (197, 5, 72, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Analyze the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (637, 197, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (638, 197, 2, 2, 3, 200, 'Learn to debate both sides');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (639, 197, 2, 3, 3, 300, 'Consider your problem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1135, 637, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1136, 637, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1137, 637, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1138, 638, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1139, 638, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1140, 639, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1141, 639, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1494, 1135, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the information sources that you used to research your problem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1495, 1136, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the second draft of your problem statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1496, 1137, 11, 100, NULL, NULL, 'Provide some reactions to your mentor’s feedback. Write a final draft of your problem statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1497, 1138, 11, 100, NULL, NULL, 'Consider both sides to each of the following arguments:<ul><li>Rap music should be censored on the radio.</li><li>A college education should be completely free for everyone.</li><li>Graffiti should not be illegal; it is art.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1498, 1139, 11, 100, NULL, NULL, 'Reflect on the following questions about these arguments.<ul><li>Which side is easier to argue? Why?</li><li>Why is the opposite argument weak?</li><li>How can you use the opposite argument to strengthen your own?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1499, 1140, 11, 100, NULL, NULL, 'Develop a logical argument for how you believe your problem should be solved.<p><p>Consider the following as you develop your argument.<ul><li>List as much information as you can that supports your argument for solving the problem in this way.</li><li>List a few points that someone might make to argue against solving your problem.</li><li>How would you respond to those points, using evidence from your reliable sources?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1500, 1141, 11, 100, NULL, NULL, 'How can your mentor help you strengthen your argument?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (329, 1496, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (330, 1499, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (331, 1500, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (317, 1494, 324, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (318, 1495, 250, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (319, 1495, 325, TRUE, 200, 0);

--10.3.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (198, 4, 72, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Analyze the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (640, 198, 2, 1, 3, 100, 'Finalize problem statement');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (641, 198, 2, 2, 3, 200, 'Learn to debate both sides');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (642, 198, 2, 3, 3, 300, 'Consider your problem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1142, 640, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1143, 641, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1144, 641, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1145, 642, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1146, 642, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1501, 1142, 11, 100, NULL, NULL, 'Your mentee read the feedback that you provided and had an optional space to offer reactions and/or a final draft of their problem statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1502, 1143, 11, 100, NULL, NULL, 'Your mentee considered both sides to each of the following arguments:<ul><li>Rap music should be censored on the radio.</li><li>A college education should be completely free for everyone.</li><li>Graffiti should not be illegal; it’s art.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1503, 1144, 11, 100, NULL, NULL, 'Your mentee used these considerations to reflect on the importance of viewing an argument from multiple perspectives:<ul><li>Which side is easier to argue? Why?</li><li>Why is the opposite argument weak? What evidence supports this?</li><li>How can you use the opposite argument to strengthen your own?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1504, 1145, 11, 100, NULL, NULL, 'Your mentee developed an argument in support of a proposed solution to their problem. They also listed ways you could help them to strengthen that argument.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1505, 1146, 11, 100, NULL, NULL, 'Provide some feedback to help your mentee strengthen their argument. Be sure to address the specific ways in which they asked for your support.<p><p>If relevant, offer alternate solutions for how the problem could be solved. This will help your mentee prepare for our next lesson, when they will be identifying 2-3 viable solutions to the problem.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (332, 1505, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (320, 1501, 329, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (321, 1504, 330, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (322, 1504, 331, TRUE, 200, 0);

--11.9.1 Image Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/11.9.1.jpg'
WHERE id = 66;

--9.3.1 Mentor Lesson Update

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1147, 565, 50);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1506, 1147, 11, 100, NULL, NULL, 'Your mentee learned about growth mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1507, 1147, 3, 200, NULL, 'https://vimeo.com/143621866', NULL, NULL);