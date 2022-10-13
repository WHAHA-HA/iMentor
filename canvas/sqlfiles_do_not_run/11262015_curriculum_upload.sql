--11.5.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (107, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 23, 2, NULL, 'Types of Colleges', '/new_platform/static/canvas/images/11.5.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (300, 1, 107, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (979, 300, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (980, 300, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (981, 300, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (982, 300, 2, 2, 4, 400, 'Explore the college size infographic');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (983, 300, 2, 3, 4, 500, 'Explore the campus setting infographic');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (984, 300, 2, 4, 4, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1757, 979, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1758, 979, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1759, 980, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1760, 981, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1761, 982, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1762, 983, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1763, 984, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1764, 984, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1765, 984, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2317, 1757, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore the different types of colleges and the factors that they''ll need to be aware of as they determine which college is right for them.<p><p>In this lesson, mentees will:<ul><li>Explore college types by matching college labels with their definitions</li><li>Examine college size, defining characteristics, and potential pros and cons</li><li>Examine campus setting, defining characteristics, and potential pros and cons</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/types-of-colleges" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2318, 1758, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2319, 1758, 6, 200, NULL, 'https://docs.google.com/presentation/d/1yYcxSq9MyGY3UQeWM8QAgKIvMd_-e--69Kb6Sry0hRk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2320, 1759, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2321, 1760, 11, 100, NULL, NULL, 'Your mentor shared a personal update and gave you feedback on your personal myths and realities about college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2322, 1761, 9, 100, NULL, '/new_platform/static/canvas/images/College_Size.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2323, 1761, 11, 200, NULL, NULL, '<ul><li>What are the defining characteristics of large and small colleges?</li><li>What are the pros for each?</li><li>What are the cons for each?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2324, 1762, 9, 100, NULL, '/new_platform/static/canvas/images/Campus_Settings.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2325, 1762, 11, 200, NULL, NULL, '<ul><li>What are the defining characteristics of campus setting?</li><li>What are the pros for each?</li><li>What are the cons for each?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2326, 1763, 11, 100, NULL, NULL, 'College Size: Would you prefer a large or small college? Tell your mentor why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2327, 1764, 11, 100, NULL, NULL, 'Campus Setting: Which campus setting do you prefer (rural, suburban, or urban)? Tell your mentor why you prefer that setting.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2328, 1765, 11, 100, NULL, NULL, 'What would you like to know about the college your mentor attended? Ask your mentor questions about their college.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (487, 2326, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (488, 2327, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (489, 2328, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (468, 2321, 437, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (473, 2321, 438, TRUE, 50, 0);

--11.5.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (301, 5, 107, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (985, 301, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (986, 301, 2, 2, 4, 200, 'Explore the college size infographic');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (987, 301, 2, 3, 4, 300, 'Explore the campus setting infographic');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (988, 301, 2, 4, 4, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1766, 985, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1767, 986, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1768, 987, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1769, 988, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1770, 988, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1771, 988, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2329, 1766, 11, 100, NULL, NULL, 'Your mentor shared a personal update and gave you feedback on your personal myths and realities about college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2330, 1767, 9, 100, NULL, '/new_platform/static/canvas/images/College_Size.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2331, 1767, 11, 200, NULL, NULL, '<ul><li>What are the defining characteristics of large and small colleges?</li><li>What are the pros for each?</li><li>What are the cons for each?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2332, 1768, 9, 100, NULL, '/new_platform/static/canvas/images/Campus_Settings.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2333, 1768, 11, 200, NULL, NULL, '<ul><li>What are the defining characteristics of campus setting?</li><li>What are the pros for each?</li><li>What are the cons for each?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2334, 1769, 11, 100, NULL, NULL, 'College Size: Would you prefer a large or small college? Tell your mentor why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2335, 1770, 11, 100, NULL, NULL, 'Campus Setting: Which campus setting do you prefer (rural, suburban, or urban)? Tell your mentor why you prefer that setting.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2336, 1771, 11, 100, NULL, NULL, 'What would you like to know about the college your mentor attended? Ask your mentor questions about their college.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (490, 2334, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (491, 2335, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (492, 2336, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (469, 2329, 437, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (474, 2329, 438, TRUE, 50, 0);

--11.5.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (302, 4, 107, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (989, 302, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (990, 302, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1772, 989, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1773, 989, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1774, 989, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1775, 989, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1776, 990, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1777, 990, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1778, 990, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1779, 990, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2337, 1772, 11, 100, NULL, NULL, 'In this lesson, mentees matched college types with their correct definition. You can read the full list of terms and definitions <a href="https://learn.imentor.org/help/article/link/the-types-of-colleges" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2338, 1773, 11, 100, NULL, NULL, 'Your mentee explored two college type categories in greater detail: college size and campus setting.<p><p>The class reviewed the infographics below and answered the following questions for each:<ul><li>What are the defining characteristics of each category?</li><li>What are the pros for each?</li><li>What are the cons for each?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2339, 1774, 9, 100, NULL, '/new_platform/static/canvas/images/College_Size.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2340, 1775, 9, 100, NULL, '/new_platform/static/canvas/images/Campus_Settings.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2341, 1776, 11, 100, NULL, NULL, 'Your mentee shared their preferences for college size and campus setting. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2342, 1777, 11, 100, NULL, NULL, 'Provide feedback on your mentee’s preferences. What insight can you provide based on your own college experience?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2343, 1778, 11, 100, NULL, NULL, 'Your mentee also asked you questions about your own college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2344, 1779, 11, 100, NULL, NULL, 'Answer their questions and give specific examples.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (493, 2342, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (494, 2344, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (470, 2341, 490, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (471, 2341, 491, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (472, 2343, 492, TRUE, 100, 0);