--Staff Lesson 11.1.6 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (36, 1, '7/5/15 00:00:00', '7/5/15 23:59:59', 3, 3, 6, NULL, 'Becoming a PPPAIR');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (88, 1, 36, '7/5/15 00:00:00', '7/5/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (270, 88, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (271, 88, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (272, 88, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (273, 88, 2, 2, 3, 400, 'Social Contracts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (274, 88, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (445, 270, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (446, 270, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (447, 271, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (448, 272, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (449, 272, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (450, 273, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (451, 273, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (452, 273, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (453, 274, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (612, 445, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Addressing differences in opinion can be difficult, especially when a person feels strongly about a topic or when it’s emotionally charged. This lesson provides a framework within which pairs can work towards keeping their communication frequent and productive. It can also help pairs to develop tools to address diverse cultural differences.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and assess an article</li><li>Define and articulate the key components of a social contract</li><li>Differentiate between the two types of culture: visible and deep</li><li>Apply the PPPAIR social contract framework to their mentee/mentor relationship</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-becoming-a-pppair" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (613, 446, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (614, 446, 6, 200, NULL, 'https://docs.google.com/presentation/d/1bQUEulFRgtmvMxGPPzZwZ-9UewGdhC54eeyWvPXk8z8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (615, 447, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (616, 448, 11, 100, NULL, NULL, 'Your mentor also watched and responded to the parable video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (617, 449, 11, 100, NULL, NULL, 'Respond to your mentor. What did they learn from the parable? How similar or different was it than what you learned?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (618, 450, 9, 100, NULL, '/new_platform/static/canvas/images/TheSocialContract_Canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (619, 450, 11, 200, NULL, NULL, 'Examine the image and answer the following questions:<ul><li>What do you think this image means?</li><li>What is a social contract?</li><li>What role do social contracts have between people?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (620, 451, 11, 100, NULL, NULL, 'Read the article. What steps and strategies help build an epic relationship?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (621, 451, 8, 200, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (622, 452, 11, 100, NULL, NULL, 'Review the following slides on the PPPAIR framework. How can you use this framework with your mentor?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (623, 452, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (624, 453, 11, 100, NULL, NULL, 'Apply what you discussed about social contracts and the PPPAIR framework and share the following with your mentor:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentor?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (109, 617, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (110, 624, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (105, 616, 90, TRUE, 100, 0);

--Mentee Lesson 11.1.6 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (89, 5, 36, '7/5/15 00:00:00', '7/5/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (275, 89, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (276, 89, 2, 2, 3, 200, 'Social Contracts');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (277, 89, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (454, 275, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (455, 275, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (456, 276, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (457, 276, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (458, 276, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (459, 277, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (625, 454, 11, 100, NULL, NULL, 'Your mentor also watched and responded to the parable video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (626, 455, 11, 100, NULL, NULL, 'Respond to your mentor. What did they learn from the parable? How similar or different was it than what you learned?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (627, 456, 9, 100, NULL, '/new_platform/static/canvas/images/TheSocialContract_Canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (628, 456, 11, 200, NULL, NULL, 'Examine the image and answer the following questions:<ul><li>What do you think this image means?</li><li>What is a social contract?</li><li>What role do social contracts have between people?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (629, 457, 11, 100, NULL, NULL, 'Read the article. What steps and strategies help build an epic relationship?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (630, 457, 8, 200, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (631, 458, 11, 100, NULL, NULL, 'Review the following slides on the PPPAIR framework. How can you use this framework with your mentor?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (632, 458, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (633, 459, 11, 100, NULL, NULL, 'Apply what you discussed about social contracts and the PPPAIR framework and share the following with your mentor:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentor?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (111, 626, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (112, 633, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (106, 625, 90, TRUE, 100, 0);

--Mentor Lesson 11.1.6 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (90, 4, 36, '7/5/15 00:00:00', '7/5/15 23:59:59', 'Becoming a PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (278, 90, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (279, 90, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (460, 278, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (461, 278, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (462, 279, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (463, 279, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (634, 460, 11, 100, NULL, NULL, 'Your mentee explored social contracts and reviewed an article on steps and strategies for building strong relationships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (635, 460, 8, 200, NULL, '/new_platform/static/canvas/documents/Forbes_Article.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (636, 461, 11, 100, NULL, NULL, 'They were introduced to the PPPAIR framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (637, 461, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (638, 462, 11, 100, NULL, NULL, 'Read your mentee’s response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (639, 463, 11, 100, NULL, NULL, 'Respond to your mentee. Consider the following questions:<ul><li>How can you use the PPPAIR framework to build strong and frequent communication skills with your mentor?</li><li>What commitment(s) can you make to your mentee?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (113, 639, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (107, 638, 111, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (108, 638, 112, TRUE, 200, 0);