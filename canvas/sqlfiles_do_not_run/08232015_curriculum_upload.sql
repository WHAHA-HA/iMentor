--Staff Lesson 11.1.2 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (16, 1, '6/15/15 00:00:00', '6/15/15 23:59:59', 3, 1, NULL, 'Application');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (32, 1, 16, '6/15/15 00:00:00', '6/15/15 23:59:59', 'Application');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (92, 32, 2, 1, 1, 100, 'Lesson Overview');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (150, 92, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (151, 92, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (152, 92, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (226, 150, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will explore more detailed information about the program and begin their matching applications.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Discover more about the program by generating questions based on the prior week''s lesson</li><li>Learn and practice a technology distribution ritual that they will use weekly in the future</li><li>Begin their matching applications</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-application" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (227, 151, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (228, 151, 6, 200, NULL, 'https://docs.google.com/presentation/d/1BSxR3TR-zX8Pa9-RdwAWzCk_ni9_2CRMiEPJgP8fzAQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (229, 152, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (230, 152, 3, 200, NULL, 'https://vimeo.com/136651714', NULL, NULL);

--Staff Lesson 10.1.3

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (17, 1, '6/16/15 00:00:00', '6/16/15 23:59:59', 2, 4, NULL, 'About Us');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (33, 1, 17, '6/16/15 00:00:00', '6/16/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (93, 33, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (94, 33, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (95, 33, 2, 1, 2, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (96, 33, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (153, 93, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (154, 93, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (155, 93, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (156, 94, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (157, 95, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (158, 96, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (159, 96, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (160, 96, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (231, 153, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces or re-introduces the class culture and norms that staff and students have built, giving students an opportunity to continue building culture and norms to improve their performance in the program.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and describe elements of a strong classroom and school culture</li><li>Diagram the challenges they experienced in 9th grade and create solutions to address them</li><li>Select norms to be adopted by the entire class</li><li>Share and present these norms to their mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/about-us-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (232, 154, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (233, 154, 6, 200, NULL, 'https://docs.google.com/presentation/d/1zmsg1bu0tLXAKlPDYPl-IwnV8zSMiQ7TmjwkqHMrXzk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (234, 155, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (235, 155, 3, 200, NULL, 'https://vimeo.com/136625243', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (236, 156, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (237, 157, 3, 100, NULL, 'https://vimeo.com/136625243', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (238, 157, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What elements of teamwork show up in the video?</li><li>What are the qualities of a strong team?</li><li>What qualities can threaten the strength and unity of a team?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (239, 158, 11, 100, NULL, NULL, '<ul><li>Explain to your mentor what you learned about the importance of teamwork and norms.</li><li>Share the 2-3 norms you chose as a class.</li><li>Tell your mentor what impact you think these norms will have on the class this year.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (240, 159, 11, 100, NULL, NULL, 'Your mentor responded to your questions, shared qualities of great teams, as well as their hope for working with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (241, 160, 11, 100, NULL, NULL, '<ul><li>How does what they shared resonate with you?</li><li>What do you want to learn more about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (33, 239, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (34, 241, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (14, 240, 20, TRUE, 100, 0);

--Mentee Lesson 10.1.3

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (34, 5, 17, '6/16/15 00:00:00', '6/16/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (97, 34, 2, 1, 2, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (98, 34, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (161, 97, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (162, 98, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (163, 98, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (164, 98, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (242, 161, 3, 100, NULL, 'https://vimeo.com/136625243', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (243, 161, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What elements of teamwork show up in the video?</li><li>What are the qualities of a strong team?</li><li>What qualities can threaten the strength and unity of a team?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (244, 162, 11, 100, NULL, NULL, '<ul><li>Explain to your mentor what you learned about the importance of teamwork and norms.</li><li>Share the 2-3 norms you chose as a class.</li><li>Tell your mentor what impact you think these norms will have on the class this year.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (245, 163, 11, 100, NULL, NULL, 'Your mentor responded to your questions, shared qualities of great teams, as well as their hope for working with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (246, 164, 11, 100, NULL, NULL, '<ul><li>How does what they shared resonate with you?</li><li>What do you want to learn more about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (35, 244, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (36, 246, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (15, 245, 20, TRUE, 100, 0);

--Mentor Lesson 10.1.3

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (35, 4, 17, '6/16/15 00:00:00', '6/16/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (99, 35, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (100, 35, 2, 2, 2, 200, 'Building culture and sharing norms');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (165, 99, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (166, 100, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (167, 100, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (168, 100, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (169, 100, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (247, 165, 11, 100, NULL, NULL, 'The class watched the following video:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (248, 165, 3, 200, NULL, 'https://vimeo.com/136625243', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (249, 165, 11, 300, NULL, NULL, 'They also discussed the components of a strong classroom culture and identified a few norms they agreed to adopt as a class.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (250, 166, 11, 100, NULL, NULL, 'Here are the norms the class created:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (251, 167, 11, 100, NULL, NULL, 'Tell your mentee what you think about the norms they created. Share a few norms at home or at work that contribute to the culture of that space.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (252, 168, 11, 100, NULL, NULL, 'Read your mentee’s response from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (253, 169, 11, 100, NULL, NULL, 'Respond to your mentee:', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (37, 251, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (38, 253, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (16, 250, 35, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (17, 252, 36, TRUE, 100, 0);

--Staff Lesson 12.1.2

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (18, 1, '6/17/15 00:00:00', '6/17/15 23:59:59', 4, 5, NULL, 'Survey');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (36, 1, 18, '6/17/15 00:00:00', '6/17/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (101, 36, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (102, 36, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (103, 36, 2, 1, 2, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (104, 36, 2, 2, 2, 400, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (170, 101, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (171, 101, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (172, 102, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (173, 103, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (174, 103, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (175, 104, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (254, 170, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will re-familiarize themselves with the purpose and process of surveying in the program and complete their first program survey of the year.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Recall and apply the purpose of using a pre-course survey to collect data and provide feedback</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/survey-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (255, 171, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (256, 171, 6, 200, NULL, 'https://docs.google.com/presentation/d/1v0HX9XrXi_jSrkG-1HHbNcqqdpcXWdZb6fi5OZPRn5o/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (257, 172, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (258, 173, 11, 100, NULL, NULL, 'Your mentor responded to your quote and then shared a quote of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (259, 174, 11, 100, NULL, NULL, 'Your mentor also responded to your summer highlights.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (260, 175, 11, 100, NULL, NULL, 'Discuss the following with your mentor:<ul><li>How does your mentor’s quote resonate with you?</li><li>Answer any questions your mentor asked.</li><li>Ask any clarifying questions you have for your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (39, 260, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (18, 258, 31, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (19, 259, 32, TRUE, 100, 0);

--Mentee Lesson 12.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (37, 5, 18, '6/17/15 00:00:00', '6/17/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (105, 37, 2, 1, 2, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (106, 37, 2, 2, 2, 200, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (176, 105, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (177, 105, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (178, 106, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (261, 176, 11, 100, NULL, NULL, 'Your mentor responded to your quote and then shared a quote of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (262, 177, 11, 100, NULL, NULL, 'Your mentor also responded to your summer highlights.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (263, 178, 11, 100, NULL, NULL, 'Discuss the following with your mentor:<ul><li>How does your mentor’s quote resonate with you?</li><li>Answer any questions your mentor asked.</li><li>Ask any clarifying questions you have for your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (40, 263, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (20, 261, 31, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (21, 262, 32, TRUE, 100, 0);

--Mentor Lesson 12.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (38, 4, 18, '6/17/15 00:00:00', '6/17/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (107, 38, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (108, 38, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (179, 107, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (180, 108, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (264, 179, 11, 100, NULL, NULL, 'Today your mentee completed their first program survey of the year. Curious about how we use surveys to improve our program? Click <a href="https://learn.imentor.org/help/article/link/how-surveys-help-to-improve-our-program" target="_blank">here</a>.<p><p>They then had an opportunity to write you.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (265, 180, 11, 100, NULL, NULL, 'Wrap up this conversation by answering any questions your mentee may have asked and adding your final thoughts.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (41, 265, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (22, 264, 40, TRUE, 100, 0);

--Staff Lesson 11.1.3 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (19, 1, '6/18/15 00:00:00', '6/18/15 23:59:59', 3, 3, NULL, 'Survey');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (39, 1, 19, '6/18/15 00:00:00', '6/18/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (109, 39, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (110, 39, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (111, 39, 2, 1, 1, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (181, 109, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (182, 109, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (183, 110, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (184, 111, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (185, 111, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (186, 111, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (266, 181, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will re-familiarize themselves with the purpose and process of surveying in the program and complete their first program survey of the year.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Recall and apply the purpose of using a pre-course survey to collect data and provide feedback</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-survey" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (267, 182, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (268, 182, 6, 200, NULL, 'https://docs.google.com/presentation/d/1HVZYjKPb-LXI-XnxgG4klzbc_fNzkqCmK6zpsLbWNso/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (269, 183, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (270, 184, 11, 100, NULL, NULL, 'Your mentor shared their own experiences with strong culture.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (271, 185, 11, 100, NULL, NULL, 'Respond to your mentor and ask at least 2 clarifying questions about what they shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (272, 186, 11, 100, NULL, NULL, 'They also shared final reflections from the summer.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (42, 271, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (23, 270, 25, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (24, 272, 26, TRUE, 100, 0);

--Mentee Lesson 11.1.3 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (40, 5, 19, '6/18/15 00:00:00', '6/18/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (112, 40, 2, 1, 1, 100, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (187, 112, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (188, 112, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (189, 112, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (273, 187, 11, 100, NULL, NULL, 'Your mentor shared their own experiences with strong culture.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (274, 188, 11, 100, NULL, NULL, 'Respond to your mentor and ask at least 2 clarifying questions about what they shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (275, 189, 11, 100, NULL, NULL, 'They also shared final reflections from the summer.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (43, 274, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (25, 273, 25, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (26, 275, 26, TRUE, 100, 0);

--Mentor Lesson 11.1.3 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (41, 4, 19, '6/18/15 00:00:00', '6/18/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (113, 41, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (114, 41, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (190, 113, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (191, 114, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (192, 114, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (276, 190, 11, 100, NULL, NULL, 'Today your mentee completed their first program survey of the year. Curious about how we use surveys to improve our program? Click <a href="https://learn.imentor.org/help/article/link/how-surveys-help-to-improve-our-program" target="_blank">here</a>.<p><p>They then had an opportunity to write you.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (277, 191, 11, 100, NULL, NULL, 'Respond to your mentee and answer any clarifying questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (278, 192, 11, 100, NULL, NULL, 'Next week, your mentee will be setting up accounts for websites they’ll be using during the college exploration process, including <a href="https://bigfuture.collegeboard.org/" target="_blank">BigFuture</a> and <a href="https://www.khanacademy.org/" target="_blank">Khan Academy</a>.<p><p>Share other websites and resources that you think might be helpful, resources you used during your own college exploration process, and any other helpful tips.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (44, 277, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (45, 278, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (27, 276, 43, TRUE, 100, 0);