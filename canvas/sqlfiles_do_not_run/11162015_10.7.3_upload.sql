--10.7.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (98, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 22, 3, NULL, 'Building My Resume: Skills and Experiences', '/new_platform/static/canvas/images/10.7.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (273, 1, 98, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Resume: Skills and Experiences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (882, 273, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (883, 273, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (884, 273, 2, 1, 3, 300, 'Map backwards');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (885, 273, 2, 2, 3, 400, 'Develop your resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (886, 273, 2, 3, 3, 500, 'Read your mentor’s feedback');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1579, 882, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1580, 882, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1581, 883, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1582, 884, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1583, 884, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1584, 885, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1585, 885, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1586, 886, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1587, 886, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2083, 1579, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Using a growth mindset, this lesson will ask mentees to align their career road maps to their current resumes and think through specific ways they can build it over their remaining years in high school.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Practice backward mapping action steps from a goal</li><li>Identify a list of steps that they need to take to achieve their dream careers</li><li>Identify 1-3 opportunities that they can pursue now toward their dream careers</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-my-resume---1047" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2084, 1580, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2085, 1580, 6, 200, NULL, 'https://docs.google.com/presentation/d/14u2vkyC53m_M05dWADvErpoLhyTu65jbM5ciHo1qY_E/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2086, 1581, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2087, 1582, 11, 100, NULL, NULL, 'Complete the below activity.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2088, 1582, 9, 200, NULL, '/new_platform/static/canvas/images/Where_Would_You_Rather_Be.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2089, 1583, 11, 100, NULL, NULL, 'Now, apply this same process to your dream career. What is your dream career?<p><p>Use paper to write a list of all of the steps needed to successfully pursue this career.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2090, 1584, 11, 100, NULL, NULL, 'Look back at the list of steps that you just wrote above, and your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">current resume</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2091, 1585, 11, 100, NULL, NULL, 'What are 1-3 opportunities that you can pursue now in order to take some of the steps that you listed above?<p><p>For example: join an after school club, take a class to learn a new skill, meet with someone in a field of interest, etc.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2092, 1586, 11, 100, NULL, NULL, 'Your mentor reviewed your draft resume and offered the following advice/feedback.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2093, 1587, 11, 100, NULL, NULL, 'Click back into your resume draft. Spend a few minutes making any changes based on your mentor’s advice and feedback.<p><p>Open <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">your resume</a>.</p></p>', NULL);


INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (455, 2091, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (434, 2092, 454, TRUE, 100, 0);

--10.7.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (274, 5, 98, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Resume: Skills and Experiences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (887, 274, 2, 1, 3, 100, 'Map backwards');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (888, 274, 2, 2, 3, 200, 'Develop your resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (889, 274, 2, 3, 3, 300, 'Read your mentor’s feedback');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1588, 887, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1589, 887, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1590, 888, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1591, 888, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1592, 889, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1593, 889, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2095, 1588, 11, 100, NULL, NULL, 'Complete the below activity.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2096, 1588, 9, 200, NULL, '/new_platform/static/canvas/images/Where_Would_You_Rather_Be.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2097, 1589, 11, 100, NULL, NULL, 'Now, apply this same process to your dream career. What is your dream career?<p><p>Use paper to write a list of all of the steps needed to successfully pursue this career.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2098, 1590, 11, 100, NULL, NULL, 'Look back at the list of steps that you just wrote above, and your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">current resume</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2099, 1591, 11, 100, NULL, NULL, 'What are 1-3 opportunities that you can pursue now in order to take some of the steps that you listed above?<p><p>For example: join an after school club, take a class to learn a new skill, meet with someone in a field of interest, etc.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2100, 1592, 11, 100, NULL, NULL, 'Your mentor reviewed your draft resume and offered the following advice/feedback.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2101, 1593, 11, 100, NULL, NULL, 'Click back into your resume draft. Spend a few minutes making any changes based on your mentor’s advice and feedback.<p><p>Open <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">your resume</a>.</p></p>', NULL);


INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (456, 2099, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (435, 2100, 454, TRUE, 100, 0);

--10.7.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (275, 4, 98, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Building My Resume: Skills and Experiences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (890, 275, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1594, 890, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1595, 890, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1596, 890, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2103, 1594, 11, 100, NULL, NULL, 'Your mentee spent a few minutes making some changes to their resume based on your advice/feedback.<p><p>View your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">mentee’s resume</a>.</p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2105, 1595, 11, 100, NULL, NULL, 'Then, your mentee described their dream career and made a list of all the steps that they will need to take in order to achieve this career.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2106, 1596, 11, 100, NULL, NULL, 'Finally, your mentee considered how this list of steps relates to their current resume. They identified 1-3 opportunities that they can pursue now in order to take some of the steps that they listed.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (436, 2106, 456, TRUE, 100, 0);