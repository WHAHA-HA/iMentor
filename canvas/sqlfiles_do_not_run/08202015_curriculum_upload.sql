--Staff Lesson 11.1.2 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (13, 1, '6/12/15 00:00:00', '6/12/15 23:59:59', 3, 3, NULL, 'About Us');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (25, 1, 13, '6/12/15 00:00:00', '6/12/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (71, 25, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (72, 25, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (73, 25, 2, 1, 4, 300, 'Read the article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (74, 25, 2, 2, 4, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (75, 25, 2, 3, 4, 500, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (76, 25, 2, 4, 4, 600, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (115, 71, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (116, 71, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (117, 71, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (118, 72, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (119, 73, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (120, 74, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (121, 75, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (122, 76, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (123, 76, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (176, 115, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the elements of a strong class culture and asks mentees to create a class theme to be used throughout the year.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read and review an article</li><li>Identify and describe elements of a strong classroom and school culture</li><li>Select and build out a theme for the class</li><li>Introduce and describe theme to their mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-returning-pairs-about-us" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (177, 116, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editting-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (178, 116, 6, 200, NULL, 'https://docs.google.com/presentation/d/103_Sbh2n7EGouWwmN-6fpNNW9wC4S1LprjFZMYLVY2U/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (179, 117, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (180, 117, 3, 200, NULL, 'https://vimeo.com/136717296', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (181, 118, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (182, 119, 8, 100, NULL, '/new_platform/static/canvas/documents/10_Characteristics_of_Great_School_Cultures.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (183, 119, 11, 200, NULL, NULL, 'Consider the following:<ul><li>Which 2-3 of the 10 ingredients do you think are the most important for building culture?</li><li>Does your class or school currently have any of the ingredients in place?</li><li>Where else might you have experienced strong culture as defined in this article?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (184, 120, 3, 100, NULL, 'https://vimeo.com/136717296', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (185, 120, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What was the theme in the video?</li><li>What do you think it means?</li><li>Why do you think it would be important for the person in the video to hold to that theme?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (186, 121, 11, 100, NULL, NULL, '<ul><li>What theme did the class choose and why?</li><li>What song did the class chose and why?</li><li>Why is having a theme important for the class and also for the pair relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (187, 122, 11, 100, NULL, NULL, 'Your mentor responded to your summer highlights.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (188, 123, 11, 100, NULL, NULL, 'Be sure to answer any questions your mentor asked and ask any clarifying questions you have for your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (21, 186, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (22, 188, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (8, 187, 17, TRUE, 100, 0);

--Mentee Lesson 11.1.2 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (26, 5, 13, '6/12/15 00:00:00', '6/12/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (77, 26, 2, 1, 4, 300, 'Read the article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (78, 26, 2, 2, 4, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (79, 26, 2, 3, 4, 500, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (80, 26, 2, 4, 4, 600, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (124, 77, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (125, 78, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (126, 79, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (127, 80, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (128, 80, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (189, 124, 8, 100, NULL, '/new_platform/static/canvas/documents/10_Characteristics_of_Great_School_Cultures.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (190, 124, 11, 200, NULL, NULL, 'Consider the following:<ul><li>Which 2-3 of the 10 ingredients do you think are the most important for building culture?</li><li>Does your class or school currently have any of the ingredients in place?</li><li>Where else might you have experienced strong culture as defined in this article?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (191, 125, 3, 100, NULL, 'https://vimeo.com/136717296', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (192, 125, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What was the theme in the video?</li><li>What do you think it means?</li><li>Why do you think it would be important for the person in the video to hold to that theme?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (193, 126, 11, 100, NULL, NULL, '<ul><li>What theme did the class choose and why?</li><li>What song did the class chose and why?</li><li>Why is having a theme important for the class and also for the pair relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (194, 127, 11, 100, NULL, NULL, 'Your mentor responded to your summer highlights.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (195, 128, 11, 100, NULL, NULL, 'Be sure to answer any questions your mentor asked and ask any clarifying questions you have for your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (23, 193, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (24, 195, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (9, 194, 17, TRUE, 100, 0);

--Mentor Lesson 11.1.2 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (27, 4, 13, '6/12/15 00:00:00', '6/12/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (81, 27, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (82, 27, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (129, 81, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (130, 82, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (131, 82, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (132, 82, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (196, 129, 11, 100, NULL, NULL, 'Today your mentee worked with the rest of the class to build a strong class culture and choose a class theme.<p><p>They discussed the following article and video.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (197, 129, 8, 200, NULL, '/new_platform/static/canvas/documents/10_Characteristics_of_Great_School_Cultures.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (198, 129, 3, 300, NULL, 'https://vimeo.com/136717296', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (199, 129, 11, 400, NULL, NULL, 'Finally, they worked together to pick a motto, gesture, visual, and song for the class theme.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (200, 130, 11, 100, NULL, NULL, 'Read your mentee’s response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (201, 131, 11, 100, NULL, NULL, 'Respond to your mentee and share an example of where you’ve experienced strong culture. Identify specific qualities that contributed to that strong culture.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (202, 132, 11, 100, NULL, NULL, 'Here’s your chance to wrap up your summer reflection. Answer any remaining questions your mentee may have asked.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (25, 201, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (26, 202, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (10, 200, 23, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (11, 202, 24, TRUE, 100, 0);