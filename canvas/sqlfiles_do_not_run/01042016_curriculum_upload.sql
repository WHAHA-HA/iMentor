--11.8.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (121, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 28, 2, NULL, 'My College Fit: Personal Preferences', '/new_platform/static/canvas/images/11.8.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (342, 1, 121, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Personal Preferences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1112, 342, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1113, 342, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1114, 342, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1115, 342, 2, 2, 2, 400, 'Finding My Fit');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1973, 1112, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1974, 1112, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1975, 1113, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1976, 1114, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1977, 1114, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1978, 1114, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1979, 1115, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2588, 1973, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />What is the best college for me? There are so many colleges to choose from and a variety of factors to consider. In order to answer this question, mentees will identify and evaluate their needs, wants, and goals so that they are better prepared to choose the college that is the best fit for them.<p><p>In this lesson, mentees will:<ul><li>Define college fit preference categories.</li><li>Discuss and explore how their preferences in each category can influence their college list.</li><li>Identify at least one preference and explain why.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-fit-personal-preferences" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2589, 1974, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2590, 1974, 6, 200, NULL, 'https://docs.google.com/presentation/d/1cmABQy50C69dPKeEQxM9_OfSi4sJ4UhuElQ5xeiDHGI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2591, 1975, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2592, 1976, 11, 100, NULL, NULL, 'Your mentor responded to your high and low by sharing one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2593, 1977, 11, 100, NULL, NULL, 'They also responded to your ideas about what’s most important when selecting a college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2594, 1978, 11, 100, NULL, NULL, 'Respond to your mentor. Answer their questions and share any additional thoughts you have about college fit.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2595, 1979, 9, 100, NULL, '/new_platform/static/canvas/images/College_Preference.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2596, 1979, 11, 200, NULL, NULL, 'Select 1-2 categories where you already have a preference. Share the following with your mentor:<ul><li>What are your preferences in the categories you chose? Explain why.</li><li>How strong are your preferences? For example, are they “need to have” or “want to have”?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (555, 2594, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (556, 2596, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (526, 2592, 519, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (527, 2593, 520, TRUE, 100, 0);

--11.8.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (343, 5, 121, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Personal Preferences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1116, 343, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1117, 343, 2, 2, 2, 200, 'Finding My Fit');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1980, 1116, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1981, 1116, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1982, 1116, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1983, 1117, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2597, 1980, 11, 100, NULL, NULL, 'Your mentor responded to your high and low by sharing one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2598, 1981, 11, 100, NULL, NULL, 'They also responded to your ideas about what’s most important when selecting a college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2599, 1982, 11, 100, NULL, NULL, 'Respond to your mentor. Answer their questions and share any additional thoughts you have about college fit.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2600, 1983, 9, 100, NULL, '/new_platform/static/canvas/images/College_Preference.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2601, 1983, 11, 200, NULL, NULL, 'Select 1-2 categories where you already have a preference. Share the following with your mentor:<ul><li>What are your preferences in the categories you chose? Explain why.</li><li>How strong are your preferences? For example, are they “need to have” or “want to have”?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (557, 2599, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (558, 2601, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (528, 2597, 519, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (529, 2598, 520, TRUE, 100, 0);

--11.8.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (344, 4, 121, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Personal Preferences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1118, 344, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1119, 344, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1984, 1118, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1985, 1118, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1986, 1119, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2602, 1984, 11, 100, NULL, NULL, 'Last week, your mentee discussed  the academic side of college fit. This week, they explored other fit criteria, including: size, location, major, etc.<p><p>Your mentee shared some of their early college fit preferences with you. They also responded to your high and low.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2603, 1985, 11, 100, NULL, NULL, 'Respond to your mentee. It is important that your mentee take the fit process seriously and think through the many qualities they’d need or want their college to have.<p><p>It is also important that you know enough about what your mentee needs and wants in their potential college to help them build a balanced college list.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2604, 1986, 11, 100, NULL, NULL, 'Next week, your mentee will be completing their own College Fit Checklist, a tool that will help them assess and document their preferences for various college fit categories.<p><p>To help them get started, complete your own checklist as an example using what you remember about your own preferences and the college you eventually attended.</p></p><ol><li>Rate each category on a scale from 1 to 5 (1 = no preference, 5 = strong preference).</li><li>Explain why you chose that rating and how closely the college you attended aligned with your preference.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2605, 1986, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/12DSH12ssE57i94c8kvrU3iPqx6nrkYEBwazaVJV2amU/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (559, 2603, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (530, 2602, 557, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (531, 2602, 558, TRUE, 200, 0);