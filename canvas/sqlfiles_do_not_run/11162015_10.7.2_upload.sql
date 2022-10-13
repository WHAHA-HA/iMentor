--10.7.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (97, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 22, 2, NULL, 'Starting My Resume', '/new_platform/static/canvas/images/10.7.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (270, 1, 97, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Resume');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (873, 270, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (874, 270, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (875, 270, 2, 1, 3, 300, 'Analyze your mentor’s resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (876, 270, 2, 2, 3, 400, 'Start your resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (877, 270, 2, 3, 3, 500, 'Get feedback');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1565, 873, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1566, 873, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1567, 874, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1568, 875, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1569, 875, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1570, 876, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1571, 877, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2067, 1565, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />By utilizing an asset-based approach, this lesson will ask mentees to consider what they''ve done so far that might make it onto their resume, i.e. good grades, extracurricular activities, community involvement, etc.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create a first draft of their resume</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-starting-my-resume" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2068, 1566, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2069, 1566, 6, 200, NULL, 'https://docs.google.com/presentation/d/1DDMEkoI-1x1kcRbxqbb3uk9mtLx-F1LQDHGDQxeiloE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2070, 1567, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2071, 1568, 11, 100, NULL, NULL, 'Your mentor helped you identify skills and experiences you might include in your resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2072, 1569, 11, 100, NULL, NULL, 'Review your mentor’s resume. Think about what your mentor included and what you would use for your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2073, 1570, 11, 100, NULL, NULL, 'Click into the template below to start your resume.<p><p>Open your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">resume template</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2074, 1571, 11, 100, NULL, NULL, 'What advice or feedback would you like from your mentor on your resume draft?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (452, 2074, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (429, 2071, 431, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (430, 2072, 432, TRUE, 100, 0);

--10.7.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (271, 5, 97, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Resume');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (878, 271, 2, 1, 3, 100, 'Analyze your mentor’s resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (879, 271, 2, 2, 3, 200, 'Start your resume');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (880, 271, 2, 3, 3, 300, 'Get feedback');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1572, 878, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1573, 878, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1574, 879, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1575, 880, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2075, 1572, 11, 100, NULL, NULL, 'Your mentor helped you identify skills and experiences you might include in your resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2076, 1573, 11, 100, NULL, NULL, 'Review your mentor’s resume. Think about what your mentor included and what you would use for your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2077, 1574, 11, 100, NULL, NULL, 'Click into the template below to start your resume.<p><p>Open your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">resume template</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2078, 1575, 11, 100, NULL, NULL, 'What advice or feedback would you like from your mentor on your resume draft?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (453, 2078, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (431, 2075, 431, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (432, 2076, 432, TRUE, 100, 0);

--10.7.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (272, 4, 97, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Resume');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (881, 272, 2, 1, 1, 100, 'Review your mentee’s draft');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1576, 881, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1577, 881, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1578, 881, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2079, 1576, 11, 100, NULL, NULL, 'Your mentee reviewed your resume and used it to begin a first draft of their own. Review their draft below.<p><p>View your <a href="https://docs.google.com/document/d/19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI/edit?usp=sharing" target="_blank">mentee’s resume</a>.</p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2081, 1577, 11, 100, NULL, NULL, 'Your mentee asked for the following advice/feedback from you about their resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2082, 1578, 11, 100, NULL, NULL, 'Offer some general comments and reflections about your mentee’s resume draft. Be sure to address any of the specific advice/feedback they requested.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (454, 2082, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (433, 2081, 453, TRUE, 100, 0);