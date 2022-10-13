--11.5.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (110, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 23, 4, NULL, 'Types of Degrees', '/new_platform/static/canvas/images/11.5.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (309, 1, 110, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Degrees');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1007, 309, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1008, 309, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1009, 309, 2, 1, 2, 300, 'Read the following article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1010, 309, 2, 2, 2, 400, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1805, 1007, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1806, 1007, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1807, 1008, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1808, 1009, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1809, 1010, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1810, 1010, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2377, 1805, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to different types of college degrees.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Learn about and understand the different degree types, i.e. undergraduate, graduate, and professional</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/college-degrees" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2378, 1806, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2379, 1806, 6, 200, NULL, 'https://docs.google.com/presentation/d/1e-ut7jrO-YdzuaqsMcfjPZRGfKp1sKaEtr6hTFkJmsw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2380, 1807, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2381, 1808, 11, 100, NULL, NULL, 'Take note of the difference between a postsecondary certificate, Associate, Bachelor, Graduate and Professional degree.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2382, 1808, 8, 200, NULL, '/new_platform/static/canvas/documents/Types_of_Degrees.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2383, 1809, 11, 100, NULL, NULL, 'Your mentor responded to your initial ideas about college preferences and offered details about their own college experience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2384, 1810, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>When thinking about your educational and professional future, which degree(s) do you think will be most important for you to pursue and obtain? Why?</li><li>Share a personal update with your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (505, 2384, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (487, 2383, 499, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (488, 2383, 500, TRUE, 200, 0);

--11.5.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (310, 5, 110, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Degrees');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1011, 310, 2, 1, 2, 100, 'Read the following article');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1012, 310, 2, 2, 2, 200, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1811, 1011, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1812, 1012, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1813, 1012, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2385, 1811, 11, 100, NULL, NULL, 'Take note of the difference between a postsecondary certificate, Associate, Bachelor, Graduate and Professional degree.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2386, 1811, 8, 200, NULL, '/new_platform/static/canvas/documents/Types_of_Degrees.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2387, 1812, 11, 100, NULL, NULL, 'Your mentor responded to your initial ideas about college preferences and offered details about their own college experience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2388, 1813, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>When thinking about your educational and professional future, which degree(s) do you think will be most important for you to pursue and obtain? Why?</li><li>Share a personal update with your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (506, 2388, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (489, 2387, 499, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (490, 2387, 500, TRUE, 200, 0);

--11.5.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (311, 4, 110, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Degrees');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1013, 311, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1814, 1013, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1815, 1013, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2389, 1814, 11, 100, NULL, NULL, 'Mentee’s learned the difference between a postsecondary certificate, associate, bachelor’s, graduate and professional degree.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2390, 1814, 8, 200, NULL, '/new_platform/static/canvas/documents/Types_of_Degrees.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2391, 1815, 11, 100, NULL, NULL, 'Your mentee also responded to the college experiences you shared and reflected on degrees they might pursue.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (491, 2391, 506, TRUE, 100, 0);