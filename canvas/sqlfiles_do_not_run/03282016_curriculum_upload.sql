--12.10.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (40, 10, 'Preparing to Transition', 'preparing_to_transition', 'What steps do I need to take to enroll into college?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (40, 4, 40, '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the program till now?</li></ul>', '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the program till now?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (160, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 40, 1, NULL, 'Introduction to the College Program', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (456, 1, 160, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Introduction to the College Program');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1431, 456, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1432, 456, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1433, 456, 2, 1, 2, 300, 'Learn about the College Program');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1434, 456, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2456, 1431, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2457, 1431, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2458, 1431, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2459, 1432, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2460, 1433, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2461, 1433, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2462, 1434, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3189, 2456, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will reflect on the value of having a mentor during high school, project the value of a mentor during college, and learn about the iMentor College Program.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on the role their mentor played during high school.</li><li>Project and discuss the role their mentor can play after high school.</li><li>Learn about the College Program.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/intro-to-college-program-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3190, 2457, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3191, 2457, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ws2YBqJd1hQXmdszjW6lyiV1OpeQGxsh8HG6O3VCl5I/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3192, 2458, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3193, 2458, 3, 200, NULL, 'https://vimeo.com/160167763', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3194, 2459, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3195, 2460, 3, 100, NULL, 'https://vimeo.com/160167763', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3196, 2461, 8, 100, NULL, '/new_platform/static/canvas/documents/iMentor_College_Program.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3197, 2462, 11, 100, NULL, NULL, '<ul><li>How do you expect the College Program to be different from the High School Program?</li><li>What role do you hope your mentor will have in your college experiences?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (693, 3197, 100, 0, 2);

--12.10.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (457, 5, 160, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Introduction to the College Program');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1435, 457, 2, 1, 2, 100, 'Learn about the College Program');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1436, 457, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2463, 1435, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2464, 1435, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2465, 1436, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3198, 2463, 3, 100, NULL, 'https://vimeo.com/160167763', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3199, 2464, 8, 100, NULL, '/new_platform/static/canvas/documents/iMentor_College_Program.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3200, 2465, 11, 100, NULL, NULL, '<ul><li>How do you expect the College Program to be different from the High School Program?</li><li>What role do you hope your mentor will have in your college experiences?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (694, 3200, 100, 0, 2);

--12.10.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (458, 4, 160, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Introduction to the College Program');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1437, 458, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1438, 458, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2466, 1437, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2467, 1438, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3201, 2466, 11, 100, NULL, NULL, 'Your mentee had an opportunity to learn about the College Program and discuss the ways you might support them moving forward.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3202, 2466, 3, 200, NULL, 'https://vimeo.com/160167763', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3203, 2466, 8, 300, NULL, '/new_platform/static/canvas/documents/iMentor_College_Program.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3204, 2467, 11, 100, NULL, NULL, 'Respond to your mentee. Be sure to articulate the role you hope to play in your mentee''s college experience.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (695, 3204, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (651, 3203, 694, TRUE, 100, 0);