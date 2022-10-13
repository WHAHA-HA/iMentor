--9.4.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (90, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 21, 2, NULL, 'Resilience and Grit in High School: Academics', '/new_platform/static/canvas/images/9.4.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (250, 1, 90, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Academics');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (818, 250, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (819, 250, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (820, 250, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (821, 250, 2, 2, 2, 400, 'Reflect on a challenge');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1457, 818, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1458, 818, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1459, 819, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1460, 820, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1461, 820, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1462, 820, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1463, 821, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1464, 821, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1927, 1457, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, students will explore academic challenges in high school and explore ways to practice resilience and grit to overcome them.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify an academic challenge that they are currently facing</li><li>Brainstorm attitudes and actions that would help them demonstrate resilience through this challenge</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-resilience-and-grit-in-high-school-academics" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1928, 1458, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1929, 1458, 6, 200, NULL, 'https://docs.google.com/presentation/d/1FvoahP6Ix-OhOjZZOnMX7hYtiJM6GpN42s-4sO7aTcw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1930, 1459, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1931, 1460, 11, 100, NULL, NULL, 'Read your mentor’s response to the question “Can failure help you succeed?”', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1932, 1461, 11, 100, NULL, NULL, 'Your mentor shared an example of how they practice resilience and grit in their own lives.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1933, 1462, 11, 100, NULL, NULL, 'Share your thoughts on your mentor''s example. What attitude or action stood out to you? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1934, 1463, 11, 100, NULL, NULL, 'Describe an academic challenge you are currently experiencing. What can you learn about yourself from this challenge? Be honest with yourself about where you can do better!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1935, 1464, 11, 100, NULL, NULL, 'What are your strengths? How can you use these strengths to overcome this challenge?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (419, 1933, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (420, 1934, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (421, 1935, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (406, 1931, 417, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (407, 1932, 418, TRUE, 100, 0);

--9.4.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (251, 5, 90, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Academics');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (822, 251, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (823, 251, 2, 2, 2, 200, 'Reflect on a challenge');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1465, 822, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1466, 822, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1467, 822, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1468, 823, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1469, 823, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1936, 1465, 11, 100, NULL, NULL, 'Read your mentor’s response to the question “Can failure help you succeed?”', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1937, 1466, 11, 100, NULL, NULL, 'Your mentor shared an example of how they practice resilience and grit in their own lives.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1938, 1467, 11, 100, NULL, NULL, 'Share your thoughts on your mentor''s example. What attitude or action stood out to you? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1939, 1468, 11, 100, NULL, NULL, 'Describe an academic challenge you are currently experiencing. What can you learn about yourself from this challenge? Be honest with yourself about where you can do better!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1940, 1469, 11, 100, NULL, NULL, 'What are your strengths? How can you use these strengths to overcome this challenge?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (422, 1938, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (423, 1939, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (424, 1940, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (408, 1936, 417, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (409, 1937, 418, TRUE, 100, 0);

--9.4.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (252, 4, 90, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Academics');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (824, 252, 2, 1, 3, 100, 'Read your mentee’s reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (825, 252, 2, 2, 3, 200, 'Read your mentee’s challenge');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (826, 252, 2, 3, 3, 300, 'Give your mentee advice');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1470, 824, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1471, 825, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1472, 825, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1473, 826, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1474, 826, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1941, 1470, 11, 100, NULL, NULL, 'Your mentee shared their thoughts on how you practice resilience and grit in your life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1942, 1471, 11, 100, NULL, NULL, 'Your mentee shared an academic challenge they are currently facing.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1943, 1472, 11, 100, NULL, NULL, 'Then, your mentee thought about their strengths and how they could leverage these to overcome this challenge.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1944, 1473, 11, 100, NULL, NULL, 'Start by offering reflections on the challenge that your mentee shared with you. How can your mentee demonstrate resilience in this situation? ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1945, 1474, 11, 100, NULL, NULL, 'Reinforce your mentee’s self-identified strengths and highlight any others. How can your mentee use these strengths to overcome any challenge?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (425, 1944, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (426, 1945, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (410, 1941, 422, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (411, 1942, 423, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (412, 1943, 424, TRUE, 100, 0);

--11.5.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (23, 5, 'Understanding the College Landscape', 'college_landscape', 'What are the different types of colleges?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (23, 3, 23, '<ul><li>What did you learn about the college landscape?</li><li>What did you learn about your mentor/mentee?</li></ul>', '<ul><li>What did you learn about the college landscape?</li><li>What did you learn about your mentor/mentee?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (92, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 23, 1, NULL, 'Exploring Myth vs Reality', '/new_platform/static/canvas/images/11.5.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (256, 1, 92, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Myth vs Reality');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (836, 256, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (837, 256, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (838, 256, 2, 1, 2, 300, 'Myth vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (839, 256, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1492, 836, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1493, 836, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1494, 837, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1495, 838, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1496, 839, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1497, 839, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1970, 1492, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will unpack the myths and realities associated with applying to and attending college.<p><p>In this lesson, mentees will:<ul><li>Respond to statements about college by identifying them as myths or realities</li><li>Engage in a group discussion to analyze and compare their responses</li><li>Respond to two personal statements and explain their reasons</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/exploring-myth-vs-reality" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1971, 1493, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1972, 1493, 6, 200, NULL, 'https://docs.google.com/presentation/d/1QDnQEMbdnFfovTb6jzac3gltuQNTmqvbRuZde-5Kmf8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1973, 1494, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1974, 1495, 11, 100, NULL, NULL, 'Review the following Myths vs Reality page. Which statements do you think represent myths? Which represent reality? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1975, 1495, 9, 200, NULL, '/new_platform/static/canvas/images/Myth_Reality_Quiz.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1976, 1496, 9, 100, NULL, '/new_platform/static/canvas/images/Personal_Myth_Realities.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1977, 1496, 11, 200, NULL, NULL, 'Read the two statements above. For you personally, are these statements a myth or reality? Why? Share your thoughts with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1978, 1497, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (433, 1977, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (434, 1978, 100, 0, 2);

--11.5.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (257, 5, 92, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Myth vs Reality');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (840, 257, 2, 1, 2, 100, 'Myth vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (841, 257, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1498, 840, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1499, 841, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1500, 841, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1979, 1498, 11, 100, NULL, NULL, 'Review the following Myths vs Reality page. Which statements do you think represent myths? Which represent reality? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1980, 1498, 9, 200, NULL, '/new_platform/static/canvas/images/Myth_Reality_Quiz.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1981, 1499, 9, 100, NULL, '/new_platform/static/canvas/images/Personal_Myth_Realities.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1982, 1499, 11, 200, NULL, NULL, 'Read the two statements above. For you personally, are these statements a myth or reality? Why? Share your thoughts with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1983, 1500, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (435, 1982, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (436, 1983, 100, 0, 2);

--11.5.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (258, 4, 92, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Myth vs Reality');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (842, 258, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (843, 258, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1501, 842, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1502, 843, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1503, 843, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1504, 843, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1505, 843, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1984, 1501, 11, 100, NULL, NULL, 'Your mentee took a college myth vs reality quiz in class. They compared their answers and discussed any disagreements in class. Review the quiz and answer key below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1985, 1501, 8, 200, NULL, '/new_platform/static/canvas/documents/Myth_Reality_Quiz_Answers.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1986, 1502, 9, 100, NULL, '/new_platform/static/canvas/images/Personal_Myth_Realities.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1987, 1502, 11, 200, NULL, NULL, 'Your mentee read the statements above and shared if they believed these statements to be a personal myth or reality. They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1988, 1503, 11, 100, NULL, NULL, 'Respond to your mentee.<ul><li>If they selected “reality”, what can you do or say to continue to support and encourage them?</li><li>If they selected “myth”, what can you do or say to encourage them to think differently?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1989, 1504, 11, 100, NULL, NULL, 'Your mentee shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1990, 1505, 11, 100, NULL, NULL, 'Respond and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (437, 1988, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (438, 1990, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (415, 1987, 435, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (416, 1989, 436, TRUE, 100, 0);

--10.3.7 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (93, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 7, NULL, 'Reflect and Evaluate: What Did You Learn?', '/new_platform/static/canvas/images/10.3.7.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (259, 1, 93, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflect and Evaluate: What Did You Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (844, 259, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (845, 259, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (846, 259, 2, 1, 3, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (847, 259, 2, 2, 3, 400, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (848, 259, 2, 3, 3, 500, 'Represent your process');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1506, 844, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1507, 844, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1508, 845, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1509, 846, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1510, 846, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1511, 847, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1512, 847, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1513, 847, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1514, 848, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1515, 848, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1516, 848, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1991, 1506, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will reflect on the critical thinking process that they followed over the past several weeks. Mentees will create a product that represents this process and what they have learned.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review the 6 steps in the critical thinking process</li><li>Reflect on the critical thinking process and what they have learned</li><li>Create a physical product that represents the critical thinking process and their learnings</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/critical-thinking-reflect-and-evaluate" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1992, 1507, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1993, 1507, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ZdQZvZI4sx5w72eYlK385gjCERyN7DTEel-6ZUWHA8Y/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1994, 1508, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1995, 1509, 11, 100, NULL, NULL, 'Your mentor provided feedback on your proposed solution.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1996, 1510, 11, 100, NULL, NULL, 'Read your mentor’s reflections on how they decide between multiple options in their work or personal life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1997, 1511, 11, 100, NULL, NULL, 'Which parts of the critical thinking process did you like the best? Why did you like them?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1998, 1512, 11, 100, NULL, NULL, 'Which parts of the critical thinking process were most challenging? What did you do to overcome the challenges?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1999, 1513, 11, 100, NULL, NULL, 'How would you describe yourself as a critical thinker? (For example, is critical thinking something you do often? Something you enjoy? Something you want to do more often?)', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2000, 1514, 11, 100, NULL, NULL, 'Check out this example of a poster that represents the problem-solving process, so you can create your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2001, 1514, 9, 200, NULL, '/new_platform/static/canvas/images/Example_Problem_Analysis.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2002, 1515, 11, 100, NULL, NULL, 'Create a product to showcase to your peers. It should represent the problem you thought about, your solution, and the critical thinking process that you used.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2003, 1516, 11, 100, NULL, NULL, 'As you work, you can always look back at these slides for a recap of the steps in the critical thinking process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2004, 1516, 6, 200, NULL, 'https://docs.google.com/presentation/d/17mctQWkbAG8mmuPCFlU8sA5GEpuARUEhn9z0boJcdfs/embed', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (439, 1997, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (440, 1998, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (441, 1999, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (417, 1995, 390, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (418, 1996, 391, TRUE, 100, 0);

--10.3.7 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (260, 5, 93, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflect and Evaluate: What Did You Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (849, 260, 2, 1, 3, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (850, 260, 2, 2, 3, 200, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (851, 260, 2, 3, 3, 300, 'Represent your process');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1517, 849, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1518, 849, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1519, 850, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1520, 850, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1521, 850, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1522, 851, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1523, 851, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1524, 851, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2005, 1517, 11, 100, NULL, NULL, 'Your mentor provided feedback on your proposed solution.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2006, 1518, 11, 100, NULL, NULL, 'Read your mentor’s reflections on how they decide between multiple options in their work or personal life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2007, 1519, 11, 100, NULL, NULL, 'Which parts of the critical thinking process did you like the best? Why did you like them?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2008, 1520, 11, 100, NULL, NULL, 'Which parts of the critical thinking process were most challenging? What did you do to overcome the challenges?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2009, 1521, 11, 100, NULL, NULL, 'How would you describe yourself as a critical thinker? (For example, is critical thinking something you do often? Something you enjoy? Something you want to do more often?)', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2010, 1522, 11, 100, NULL, NULL, 'Check out this example of a poster that represents the problem-solving process, so you can create your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2011, 1522, 9, 200, NULL, '/new_platform/static/canvas/images/Example_Problem_Analysis.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2012, 1523, 11, 100, NULL, NULL, 'Create a product to showcase to your peers. It should represent the problem you thought about, your solution, and the critical thinking process that you used.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2013, 1524, 11, 100, NULL, NULL, 'As you work, you can always look back at these slides for a recap of the steps in the critical thinking process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2014, 1524, 6, 200, NULL, 'https://docs.google.com/presentation/d/17mctQWkbAG8mmuPCFlU8sA5GEpuARUEhn9z0boJcdfs/embed', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (442, 2007, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (443, 2008, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (444, 2009, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (419, 2005, 390, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (420, 2006, 391, TRUE, 100, 0);

--10.3.7 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (261, 4, 93, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflect and Evaluate: What Did You Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (852, 261, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1525, 852, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1526, 852, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1527, 852, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2015, 1525, 11, 100, NULL, NULL, 'Your mentee reviewed the steps in the critical thinking process.<p><p>Click through the slides below to see the summaries that your mentee discussed in class.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2016, 1525, 6, 200, NULL, 'https://docs.google.com/presentation/d/17mctQWkbAG8mmuPCFlU8sA5GEpuARUEhn9z0boJcdfs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2017, 1526, 11, 100, NULL, NULL, 'Your mentee wrote to you about their favorite and most challenging parts of the critical thinking process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2018, 1527, 11, 100, NULL, NULL, 'Finally, your mentee reflected on the question, “How would you describe yourself as a critical thinker?”', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (421, 2017, 442, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (422, 2017, 443, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (423, 2018, 444, TRUE, 100, 0);

--10.4.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (94, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 20, 4, NULL, 'How I LEAD', '/new_platform/static/canvas/images/10.4.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (262, 1, 94, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How I LEAD');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (853, 262, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (854, 262, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (855, 262, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (856, 262, 2, 2, 2, 400, 'LEAD Frameworks');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1528, 853, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1529, 853, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1530, 854, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1531, 855, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1532, 856, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1533, 856, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1534, 856, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2019, 1528, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to the "L.E.A.D." framework, an activity in which they create acronyms containing verbs that capture what they think good leadership looks like.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read quotes pertaining to leadership and select the quote that best reflects their own definition of leadership</li><li>Create personal LEAD frameworks</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/how-i-lead" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2020, 1529, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2021, 1529, 6, 200, NULL, 'https://docs.google.com/presentation/d/1oS5wsAWYk-9TcDGzYVYzQvxnOYo9w1Sj5zopYbfBxu4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2022, 1530, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2023, 1531, 11, 100, NULL, NULL, 'Your mentor wrote to you about how leadership qualities show up in their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2024, 1532, 11, 100, NULL, NULL, 'A “LEAD” framework is a set of verbs starting with those letters (L-E-A-D). Each verb should represent a quality or action that you, personally associate with leadership. (Example: Listen, Empower, Assist, Decide)<p><p>Your mentor created their own LEAD framework.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2025, 1532, 6, 200, NULL, 'https://docs.google.com/document/d/1oWox_sCJBhq71xm3MB9ECftVhxw6bOGZAqk8TWzQf-k/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2026, 1533, 11, 100, NULL, NULL, 'Create your own LEAD framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2027, 1533, 6, 200, NULL, 'https://docs.google.com/document/d/14RioFiJfcL8HNu_DgubhfJyR_fyjCXLI3jKpMkVQw-c/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2028, 1534, 11, 100, NULL, NULL, 'What did you learn about your mentor from their LEAD framework? Between yours and your mentor’s, which framework would be more effective in each of the following scenarios and why?<ul><li>Zombie apocalypse</li><li>Power outage</li><li>Deserted island</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (445, 2028, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (424, 2023, 412, TRUE, 100, 0);

--10.4.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (263, 5, 94, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How I LEAD');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (857, 263, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (858, 263, 2, 2, 2, 200, 'LEAD Frameworks');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1535, 857, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1536, 858, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1537, 858, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1538, 858, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2029, 1535, 11, 100, NULL, NULL, 'Your mentor wrote to you about how leadership qualities show up in their life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2030, 1536, 11, 100, NULL, NULL, 'A “LEAD” framework is a set of verbs starting with those letters (L-E-A-D). Each verb should represent a quality or action that you, personally associate with leadership. (Example: Listen, Empower, Assist, Decide)<p><p>Your mentor created their own LEAD framework.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2031, 1536, 6, 200, NULL, 'https://docs.google.com/document/d/1oWox_sCJBhq71xm3MB9ECftVhxw6bOGZAqk8TWzQf-k/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2032, 1537, 11, 100, NULL, NULL, 'Create your own LEAD framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2033, 1537, 6, 200, NULL, 'https://docs.google.com/document/d/14RioFiJfcL8HNu_DgubhfJyR_fyjCXLI3jKpMkVQw-c/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2034, 1538, 11, 100, NULL, NULL, 'What did you learn about your mentor from their LEAD framework? Between yours and your mentor’s, which framework would be more effective in each of the following scenarios and why?<ul><li>Zombie apocalypse</li><li>Power outage</li><li>Deserted island</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (446, 2034, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (425, 2029, 412, TRUE, 100, 0);

--10.4.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (264, 4, 94, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How I LEAD');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (859, 264, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1539, 859, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1540, 859, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2035, 1539, 11, 100, NULL, NULL, 'Your mentee used your LEAD framework as an example in creating their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2036, 1539, 6, 200, NULL, 'https://docs.google.com/document/d/14RioFiJfcL8HNu_DgubhfJyR_fyjCXLI3jKpMkVQw-c/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2037, 1540, 11, 100, NULL, NULL, 'Then, your mentee responded to the following prompt:<p><p>What did you learn about your mentor from their LEAD framework? Between yours and your mentor’s, which framework would be more effective in each of the following scenarios and why?</p></p><ul><li>Zombie apocalypse</li><li>Power outage</li><li>Deserted island</li></ul>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (426, 2037, 446, TRUE, 100, 0);

--12.5.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (24, 5, 'How Will I Pay for College?', 'i_pay_college', 'What is the FAFSA?<p>Do I have what I need to submit my application?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (24, 4, 24, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What are questions you still need answers to?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What are questions you still need answers to?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (95, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 24, 1, NULL, 'Revisiting the Financial Aid Process', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (265, 1, 95, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Revisiting the Financial Aid Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (860, 265, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (861, 265, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (862, 265, 2, 1, 3, 300, 'Review the financial aid process');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (863, 265, 2, 2, 3, 400, 'Update your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (864, 265, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1541, 860, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1542, 860, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1543, 860, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1544, 861, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1545, 862, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1546, 862, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1547, 862, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1548, 863, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1549, 864, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2038, 1541, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will provide mentees with a refresher on the overall financial aid process, different types of financial aid, and factors to consider when deciding how to pay for college.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Explore and review the different types of financial aid</li><li>Review the overall financial aid process</li><li>Identify and document all deadlines and forms for their specific lists of colleges</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/how-will-i-pay-for-college-revisiting-financial-aid-process" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2039, 1542, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2040, 1542, 6, 200, NULL, 'https://docs.google.com/presentation/d/1r4fEpedRh09sPxl0W8LlchpBoIRJgg3zFBqJ7sdVuYU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2041, 1543, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2042, 1543, 3, 200, NULL, 'https://vimeo.com/142933184', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2043, 1544, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2044, 1545, 11, 100, NULL, NULL, 'College Abacus is a tool that helps you estimate the real cost of college. Use it to calculate the cost of one of the colleges on your list.<p><p>Visit <a href="https://collegeabacus.org/" target="_blank">College Abacus</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2045, 1546, 11, 100, NULL, NULL, 'Watch the video below. As you watch, consider any questions you have about the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2046, 1546, 3, 200, NULL, 'https://vimeo.com/142933184', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2047, 1547, 11, 100, NULL, NULL, 'Use the tool below to answer the following questions:<ul><li>What types of aid can I get?</li><li>Do I qualify for aid?</li><li>How do I apply for aid?</li><li>How do I manage my loans?</li></ul><p><p>Visit the <a href="https://studentaid.ed.gov/sa/" target="_blank">Federal Student Aid</a> website.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2048, 1548, 11, 100, NULL, NULL, 'Visit your college list to do the following:<ul><li>Write in financial aid application deadlines for each college you’re applying to</li><li>Specify all forms you’ll need to complete as part of the process</li></ul><p><p>Note: Your college list is always accessible through the menu at the top left.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2049, 1549, 11, 100, NULL, NULL, 'Share with your mentor any concerns you have about paying for college. What challenges do you think you''ll have in completing the financial aid process?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (447, 2049, 100, 0, 2);

--12.5.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (266, 5, 95, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Revisiting the Financial Aid Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (865, 266, 2, 1, 3, 100, 'Review the financial aid process');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (866, 266, 2, 2, 3, 200, 'Update your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (867, 266, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1550, 865, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1551, 865, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1552, 865, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1553, 866, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1554, 867, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2050, 1550, 11, 100, NULL, NULL, 'College Abacus is a tool that helps you estimate the real cost of college. Use it to calculate the cost of one of the colleges on your list.<p><p>Visit <a href="https://collegeabacus.org/" target="_blank">College Abacus</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2051, 1551, 11, 100, NULL, NULL, 'Watch the video below. As you watch, consider any questions you have about the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2052, 1551, 3, 200, NULL, 'https://vimeo.com/142933184', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2053, 1552, 11, 100, NULL, NULL, 'Use the tool below to answer the following questions:<ul><li>What types of aid can I get?</li><li>Do I qualify for aid?</li><li>How do I apply for aid?</li><li>How do I manage my loans?</li></ul><p><p>Visit the <a href="https://studentaid.ed.gov/sa/" target="_blank">Federal Student Aid</a> website.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2054, 1553, 11, 100, NULL, NULL, 'Visit your college list to do the following:<ul><li>Write in financial aid application deadlines for each college you’re applying to</li><li>Specify all forms you’ll need to complete as part of the process</li></ul><p><p>Note: Your college list is always accessible through the menu at the top left.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2055, 1554, 11, 100, NULL, NULL, 'Share with your mentor any concerns you have about paying for college. What challenges do you think you''ll have in completing the financial aid process?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (448, 2055, 100, 0, 2);

--12.5.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (267, 4, 95, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Revisiting the Financial Aid Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (868, 267, 2, 1, 3, 100, 'Review the financial aid process');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (869, 267, 2, 2, 3, 200, 'Review your mentee’s work');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (870, 267, 2, 3, 3, 300, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1555, 868, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1556, 868, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1557, 868, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1558, 869, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1559, 869, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1560, 870, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1561, 870, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1562, 870, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2056, 1555, 11, 100, NULL, NULL, '<a href="https://collegeabacus.org/" target="_blank">College Abacus</a> is a tool that helps you estimate the real cost of college. Your mentee used it during class to calculate the cost of one of the colleges on their list.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2057, 1556, 11, 100, NULL, NULL, 'Then, your mentee watched this video about the financial aid process. Check it out for a quick recap of what you need to know.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2058, 1556, 3, 200, NULL, 'https://vimeo.com/142933184', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2059, 1557, 11, 100, NULL, NULL, 'Finally, your mentee spent time on <a href="https://studentaid.ed.gov/sa/" target="_blank">https://studentaid.ed.gov/sa/</a> researching answers to the following questions:<ul><li>What types of aid can I get?</li><li>Do I qualify for aid?</li><li>How do I apply for aid?</li><li>How do I manage my loans?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2060, 1558, 11, 100, NULL, NULL, 'Your mentee visited their college list to do the following.<ul><li>Write in financial aid application deadlines for each college they are applying to</li><li>Specify all forms they’ll need to complete as part of the process</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2061, 1559, 11, 100, NULL, NULL, 'Review your mentee’s additions in the college list tool.<p><p>Note: Their college list is always accessible through the menu at the top left.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2062, 1560, 11, 100, NULL, NULL, 'Your mentee wrote the following reflection about any concerns or challenges they think they’ll have with the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2063, 1561, 11, 100, NULL, NULL, 'Respond to your mentee. What are some ways they can address their concerns?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2064, 1562, 11, 100, NULL, NULL, 'Share your experience with your mentee.<ul><li>How did you pay for college?</li><li>What are some strategies you can share that might help them brainstorm options for paying their tuition?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (449, 2063, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (450, 2064, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (427, 2062, 448, TRUE, 100, 0);