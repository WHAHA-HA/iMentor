--10.7.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (22, 7, 'Building My Resume', 'resume', 'What is a resume?<p>Why do I need one?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (22, 2, 22, '<ul><li>Reflect on the year so far.</li><li>How have you performed as a participant?</li><li>How have you performed as a pair?</li></ul>', '<ul><li>Reflect on the year so far.</li><li>How have you performed as a participant?</li><li>How have you performed as a pair?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (91, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 22, 1, NULL, 'What is a Resume?', '/new_platform/static/canvas/images/10.7.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (253, 1, 91, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Resume?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (827, 253, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (828, 253, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (829, 253, 2, 1, 2, 300, 'Learn about resumes');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (830, 253, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1475, 827, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1476, 827, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1477, 828, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1478, 829, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1479, 829, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1480, 830, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1481, 830, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1946, 1475, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the basics of a resume.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Understand the purpose of a resume</li><li>Understand the kind of message that a resume can convey</li><li>Learn tips for creating a strong resume</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-what-is-a-resume" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1947, 1476, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1948, 1476, 6, 200, NULL, 'https://docs.google.com/presentation/d/1-v1dsK_-HGOD4ptGf43Nopcq0ZqKRgHwsWpV8yGngX0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1949, 1477, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1950, 1478, 11, 100, NULL, NULL, 'Look at the sample resume below. Think about the following:<ul><li>What is the purpose of a resume?</li><li>How or when would someone use a resume?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1951, 1478, 8, 200, NULL, '/new_platform/static/canvas/documents/Good_Example_Resume.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1952, 1479, 11, 100, NULL, NULL, 'Look through the slides below to learn about the purpose and parts of a resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1953, 1479, 6, 200, NULL, 'https://docs.google.com/presentation/d/1wEer3fG_ShxeZfpSshLzITCIHtFPTfT_AgC51PHWFlg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1954, 1480, 11, 100, NULL, NULL, 'Explain the purpose of a resume in your own words. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1955, 1481, 11, 100, NULL, NULL, 'How do you feel about writing your resume? What challenges do you anticipate as you begin this process?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (427, 1954, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (428, 1955, 100, 0, 2);

--10.7.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (254, 5, 91, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Resume?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (831, 254, 2, 1, 2, 100, 'Learn about resumes');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (832, 254, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1482, 831, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1483, 831, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1484, 832, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1485, 832, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1956, 1482, 11, 100, NULL, NULL, 'Look at the sample resume below. Think about the following:<ul><li>What is the purpose of a resume?</li><li>How or when would someone use a resume?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1957, 1482, 8, 200, NULL, '/new_platform/static/canvas/documents/Good_Example_Resume.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1958, 1483, 11, 100, NULL, NULL, 'Look through the slides below to learn about the purpose and parts of a resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1959, 1483, 6, 200, NULL, 'https://docs.google.com/presentation/d/1wEer3fG_ShxeZfpSshLzITCIHtFPTfT_AgC51PHWFlg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1960, 1484, 11, 100, NULL, NULL, 'Explain the purpose of a resume in your own words. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1961, 1485, 11, 100, NULL, NULL, 'How do you feel about writing your resume? What challenges do you anticipate as you begin this process?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (429, 1960, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (430, 1961, 100, 0, 2);

--10.7.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (255, 4, 91, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is a Resume?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (833, 255, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (834, 255, 2, 2, 3, 200, 'Share resume tips');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (835, 255, 2, 3, 3, 300, 'Share your resume');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1486, 833, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1487, 833, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1488, 833, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1489, 834, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1490, 834, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1491, 835, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1962, 1486, 11, 100, NULL, NULL, 'Your mentee’s class discussed the purpose and components of a resume using the slides below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1963, 1486, 6, 200, NULL, 'https://docs.google.com/presentation/d/1wEer3fG_ShxeZfpSshLzITCIHtFPTfT_AgC51PHWFlg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1964, 1487, 11, 100, NULL, NULL, 'They also reviewed a sample resume.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1965, 1487, 8, 200, NULL, '/new_platform/static/canvas/documents/Good_Example_Resume.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1966, 1488, 11, 100, NULL, NULL, 'Then, your mentee explained the purpose of a resume in their own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1967, 1489, 11, 100, NULL, NULL, 'Your mentee shared how they feel about writing their own resume. They also identified some challenges they might face during the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1968, 1490, 11, 100, NULL, NULL, 'Your mentee might be anxious about not having enough to list on their resume. Respond to your mentee and help them identify their skills and experiences in all areas, not just in school and work. Examples include: babysitting younger siblings, volunteer work, and sports teams.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1969, 1491, 11, 100, NULL, NULL, 'Upload a copy of your own resume for your mentee to review in our next class. Your mentee will use your resume as an example as they begin their resume in our next class.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (431, 1968, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (432, 1969, 100, 0, 7);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (413, 1966, 429, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (414, 1967, 430, TRUE, 100, 0);