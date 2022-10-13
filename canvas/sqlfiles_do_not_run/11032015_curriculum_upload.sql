--10.4.1 Lesson Image Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/10.4.1.jpg'
WHERE id = 82;

--10.4.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (85, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 20, 2, NULL, 'Defining Leadership', '/new_platform/static/canvas/images/10.4.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (235, 1, 85, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Defining Leadership');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (767, 235, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (768, 235, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (769, 235, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (770, 235, 2, 2, 4, 400, 'What does leadership look like?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (771, 235, 2, 3, 4, 500, 'Defining Leadership');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (772, 235, 2, 4, 4, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1374, 767, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1375, 767, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1376, 768, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1377, 769, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1378, 769, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1379, 770, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1380, 771, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1381, 772, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1811, 1374, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore different definitions of leadership, identify important qualities in an effective leader, and create their own definitions of leadership based on what matters most to them. Note: The goal of this lesson is not to drill down into a specific definition of leadership, but to provide mentees with an opportunity to explore several and identify the qualities that matter most to them.<p><p>In this lesson, mentees will:<ul><li>Explore common definitions of leadership</li><li>Identify important qualities of leadership</li><li>Develop personal definitions of leadership</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/defining-leadership" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1812, 1375, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1813, 1375, 6, 200, NULL, 'https://docs.google.com/presentation/d/1CKpeTzV7v6lQEKqabPoJZHbxiyWpKTXzTScVoh_eeY8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1814, 1376, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1815, 1377, 11, 100, NULL, NULL, 'Your mentor wrote to you about how you can use reflection this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1816, 1378, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of what’s new with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1817, 1379, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Images.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1818, 1379, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Which of the above images best represents your definition of leadership? Why?</li><li>What are the three most important characteristics of great leaders?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1819, 1380, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1820, 1380, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Are these definitions of leadership adequate? Why or why not?</li><li>Are they too simple? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1821, 1381, 11, 100, NULL, NULL, '<ul><li>How do you define leadership?</li><li>There are many ways to describe what makes a good leader. Why did you choose to define leadership in this particular way?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (392, 1816, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (393, 1821, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (382, 1815, 380, TRUE, 100, 0);

--10.4.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (236, 5, 85, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Defining Leadership');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (773, 236, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (774, 236, 2, 2, 4, 200, 'What does leadership look like?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (775, 236, 2, 3, 4, 300, 'Defining Leadership');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (776, 236, 2, 4, 4, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1382, 773, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1383, 773, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1384, 774, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1385, 775, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1386, 776, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1822, 1382, 11, 100, NULL, NULL, 'Your mentor wrote to you about how you can use reflection this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1823, 1383, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of what’s new with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1824, 1384, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Images.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1825, 1384, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Which of the above images best represents your definition of leadership? Why?</li><li>What are the three most important characteristics of great leaders?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1826, 1385, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1827, 1385, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Are these definitions of leadership adequate? Why or why not?</li><li>Are they too simple? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1828, 1386, 11, 100, NULL, NULL, '<ul><li>How do you define leadership?</li><li>There are many ways to describe what makes a good leader. Why did you choose to define leadership in this particular way?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (394, 1823, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (395, 1828, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (383, 1822, 380, TRUE, 100, 0);

--10.4.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (237, 4, 85, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Defining Leadership');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (777, 237, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (778, 237, 2, 2, 3, 200, 'Defining Leadership');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (779, 237, 2, 3, 3, 300, 'Share an update');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1387, 777, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1388, 777, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1389, 778, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1390, 778, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1391, 779, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1829, 1387, 11, 100, NULL, NULL, 'Your mentee discussed the different types of leadership by reflecting on the following images.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1830, 1387, 9, 200, NULL, '/new_platform/static/canvas/images/Leadership_Images.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1831, 1388, 11, 100, NULL, NULL, 'They then discussed the following definitions of leadership so they could create their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1832, 1388, 9, 200, NULL, '/new_platform/static/canvas/images/Leadership_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1833, 1389, 11, 100, NULL, NULL, 'Your mentee created their own definition of leadership. Read their definition below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1834, 1390, 11, 100, NULL, NULL, 'It is important that your mentee understands that effective leadership can and should look differently in different settings.<p><p>Share the following with your mentee:<ul><li>Do you agree with their definition? Why or why not? What would you add?</li><li>Share examples of strong leadership you’ve experienced.</li><li>Who are leaders you admire? Why?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1835, 1391, 11, 100, NULL, NULL, 'Your mentee shared a personal update. Read their update and share your own update below.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (396, 1834, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (397, 1835, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (384, 1833, 395, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (385, 1835, 394, TRUE, 100, 0);

--11.4.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (86, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 19, 3, NULL, 'My College Aspiration', '/new_platform/static/canvas/images/11.4.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (238, 1, 86, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Aspiration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (780, 238, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (781, 238, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (782, 238, 2, 1, 2, 300, 'Respond to your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (783, 238, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1392, 780, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1393, 780, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1394, 781, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1395, 782, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1396, 782, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1397, 783, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1398, 783, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1836, 1392, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages mentees to interact with their mentor''s experience and aspirations before identifying and processing their own.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read and learn about their mentor''s past and current aspirations.</li><li>Explore and document their own aspirations.</li><li>Map out specific steps they can take to act on their aspirations.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-aspiration" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1837, 1393, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1838, 1393, 6, 200, NULL, 'https://docs.google.com/presentation/d/1HAdbdu1ZDrHDX3MJJClJyNIJkTnFmCKTwL3Zt_xtD0I/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1839, 1394, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1840, 1395, 11, 100, NULL, NULL, 'Your mentor responded to your reflections about going to college and then wrote about how their aspirations have influenced their journey.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1841, 1396, 11, 100, NULL, NULL, 'Tell your mentor what stood out to you about your their aspirations. What inspired you about their journey?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1842, 1397, 11, 100, NULL, NULL, 'What are your college aspirations? What are your career aspirations? Why are these things important to you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1843, 1398, 11, 100, NULL, NULL, 'What are 3-5 action steps for how you can start working toward your aspirations this year? Tell your mentor how they can support you along the way.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (398, 1841, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (399, 1842, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (400, 1843, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (386, 1840, 359, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (387, 1840, 360, TRUE, 200, 0);

--11.4.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (239, 5, 86, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Aspiration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (784, 239, 2, 1, 2, 100, 'Respond to your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (785, 239, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1399, 784, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1400, 784, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1401, 785, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1402, 785, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1844, 1399, 11, 100, NULL, NULL, 'Your mentor responded to your reflections about going to college and then wrote about how their aspirations have influenced their journey.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1845, 1400, 11, 100, NULL, NULL, 'Tell your mentor what stood out to you about your their aspirations. What inspired you about their journey?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1846, 1401, 11, 100, NULL, NULL, 'What are your college aspirations? What are your career aspirations? Why are these things important to you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1847, 1402, 11, 100, NULL, NULL, 'What are 3-5 action steps for how you can start working toward your aspirations this year? Tell your mentor how they can support you along the way.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (401, 1845, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (402, 1846, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (403, 1847, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (388, 1844, 359, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (389, 1844, 360, TRUE, 200, 0);

--11.4.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (240, 4, 86, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Aspiration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (786, 240, 2, 1, 2, 100, 'Read your mentee’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (787, 240, 2, 2, 2, 200, 'Reflect on your mentee’s aspirations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1403, 786, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1404, 786, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1405, 787, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1406, 787, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1848, 1403, 11, 100, NULL, NULL, 'Your mentee read your reflection about your aspirations and journey and wrote the following response:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1849, 1404, 11, 100, NULL, NULL, 'Respond to your mentee. If your mentee asked you any direct questions, be sure to answer them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1850, 1405, 11, 100, NULL, NULL, 'Your mentee used the example you provided about your aspirations to reflect on their own. They then identified how to start working toward those aspirations this year.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1851, 1406, 11, 100, NULL, NULL, 'Your mentee might not be thinking about all of the options available to them. You are uniquely positioned to help your mentee match their interests to a college and career pathway that’s right for them.<p><p>Respond to your mentee. In your response:<ul><li>Provide feedback and encouragement on your mentee''s college and career aspirations.</li><li>Provide suggestions for how they can act on those aspirations.</li><li>Answer any questions.</li></ul></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (404, 1849, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (405, 1851, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (390, 1848, 401, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (391, 1850, 402, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (392, 1850, 403, TRUE, 200, 0);

--11.4.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (87, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 19, 4, NULL, 'My College Identity', '/new_platform/static/canvas/images/11.4.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (241, 1, 87, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Identity');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (788, 241, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (789, 241, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (790, 241, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (791, 241, 2, 2, 3, 400, 'What is stereotype threat?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (792, 241, 2, 3, 3, 500, 'Read and write a poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1407, 788, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1408, 788, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1409, 788, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1410, 789, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1411, 790, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1412, 791, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1413, 792, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1414, 792, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1852, 1407, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson focuses on navigating stereotypes threats and building a sense of self and belonging in a new environment.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define and discuss stereotypes and "stereotype threat".</li><li>Examine and understand role of stereotype threat in college and its impact on students.</li><li>Identify and evaluate strategies for minimizing impact of stereotype threat.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-identity" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1853, 1408, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1854, 1408, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Gjv8uzOc16UShLmfZHFD_7JKPDqKgLuqRgwgJzKL5RE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1855, 1409, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1856, 1409, 3, 200, NULL, 'https://vimeo.com/140356538', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1857, 1409, 3, 300, NULL, 'https://vimeo.com/140356539', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1858, 1409, 3, 400, NULL, 'https://vimeo.com/140356537', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1859, 1410, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1860, 1411, 11, 100, NULL, NULL, 'You’ve been discussing aspirations with your mentor. Your mentor read your reflections and wrote the following response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1861, 1412, 11, 100, NULL, NULL, 'Watch the video below. As you watch, think about the following:<ul><li>What is stereotype threat?</li><li>What role do you think stereotype threat plays in the lives of college students?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1862, 1412, 3, 200, NULL, 'https://vimeo.com/140356538', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1863, 1413, 11, 100, NULL, NULL, 'Read the “Just Because” poem below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1864, 1413, 9, 200, NULL, '/new_platform/static/canvas/images/Just_Because_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1865, 1414, 11, 100, NULL, NULL, 'Share your own “Just Because” poem with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (406, 1865, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (393, 1860, 404, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (394, 1860, 405, TRUE, 200, 0);

--11.4.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (242, 5, 87, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Identity');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (793, 242, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (794, 242, 2, 2, 3, 200, 'What is stereotype threat?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (795, 242, 2, 3, 3, 300, 'Read and write a poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1415, 793, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1416, 794, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1417, 795, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1418, 795, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1866, 1415, 11, 100, NULL, NULL, 'You’ve been discussing aspirations with your mentor. Your mentor read your reflections and wrote the following response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1867, 1416, 11, 100, NULL, NULL, 'Watch the video below. As you watch, think about the following:<ul><li>What is stereotype threat?</li><li>What role do you think stereotype threat plays in the lives of college students?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1868, 1416, 3, 200, NULL, 'https://vimeo.com/140356538', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1869, 1417, 11, 100, NULL, NULL, 'Read the “Just Because” poem below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1870, 1417, 9, 200, NULL, '/new_platform/static/canvas/images/Just_Because_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1871, 1418, 11, 100, NULL, NULL, 'Share your own “Just Because” poem with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (407, 1871, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (395, 1866, 404, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (396, 1866, 405, TRUE, 200, 0);

--11.4.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (243, 4, 87, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Identity');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (796, 243, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1419, 796, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1420, 796, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1421, 796, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1872, 1419, 11, 100, NULL, NULL, 'Your mentee watched the video below about stereotype threat.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1873, 1419, 3, 200, NULL, 'https://vimeo.com/140356538', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1874, 1420, 11, 100, NULL, NULL, 'They then read the below example of a “Just Because” poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1875, 1420, 9, 200, NULL, '/new_platform/static/canvas/images/Just_Because_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1876, 1421, 11, 100, NULL, NULL, 'Your mentee used what they learned from the video and poem to write their own “Just Because” poem. Read that poem below.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (397, 1876, 407, TRUE, 100, 0);

--10.4.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (88, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 20, 3, NULL, 'Leaders We Admire', '/new_platform/static/canvas/images/10.4.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (244, 1, 88, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Leaders We Admire');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (797, 244, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (798, 244, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (799, 244, 2, 1, 3, 300, 'Read and respond');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (800, 244, 2, 2, 3, 400, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (801, 244, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1422, 797, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1423, 797, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1424, 798, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1425, 799, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1426, 800, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1427, 800, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1428, 801, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1877, 1422, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will engage mentees to apply what they''ve learned in the preceding weeks about leadership to select and explore different leaders they admire.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and assess a definition of leadership.</li><li>Identify a leader they admire.</li><li>List the qualities and reasons why.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/leaders-we-admire" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1878, 1423, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1879, 1423, 6, 200, NULL, 'https://docs.google.com/presentation/d/1a4nvZGd08GHdalggws_kYWuv1nBQwwizL4GvTLhI_pM/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1880, 1424, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1881, 1425, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1882, 1425, 11, 200, NULL, NULL, 'How would you say this in your own words? Do you agree with the quote? Why or why not?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1883, 1426, 11, 100, NULL, NULL, 'Your mentor shared a personal update with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1884, 1427, 11, 100, NULL, NULL, 'Your mentor also built on your definition of leadership and shared leaders they admire.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1885, 1428, 11, 100, NULL, NULL, '<ul><li>Who is a leader you admire?</li><li>What qualities and actions do you admire in this leader?</li><li>What sets this leader apart from other leaders?</li><li>What of their qualities do you hope to emulate in your own life?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (408, 1882, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (409, 1885, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (398, 1883, 397, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (399, 1884, 396, TRUE, 100, 0);

--10.4.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (245, 5, 88, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Leaders We Admire');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (802, 245, 2, 1, 3, 100, 'Read and respond');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (803, 245, 2, 2, 3, 200, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (804, 245, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1429, 802, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1430, 803, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1431, 803, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1432, 804, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1886, 1429, 9, 100, NULL, '/new_platform/static/canvas/images/Leadership_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1887, 1429, 11, 200, NULL, NULL, 'How would you say this in your own words? Do you agree with the quote? Why or why not?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1888, 1430, 11, 100, NULL, NULL, 'Your mentor shared a personal update with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1889, 1431, 11, 100, NULL, NULL, 'Your mentor also built on your definition of leadership and shared leaders they admire.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1890, 1432, 11, 100, NULL, NULL, '<ul><li>Who is a leader you admire?</li><li>What qualities and actions do you admire in this leader?</li><li>What sets this leader apart from other leaders?</li><li>What of their qualities do you hope to emulate in your own life?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (410, 1887, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (411, 1890, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (400, 1888, 397, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (401, 1889, 396, TRUE, 100, 0);

--10.4.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (246, 4, 88, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Leaders We Admire');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (805, 246, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (806, 246, 2, 2, 2, 200, 'Create your LEAD framework');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1433, 805, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1434, 805, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1435, 805, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1436, 806, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1891, 1433, 11, 100, NULL, NULL, 'They discussed the following quote.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1892, 1433, 9, 200, NULL, '/new_platform/static/canvas/images/Leadership_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1893, 1434, 11, 100, NULL, NULL, 'They then used your response from last week to jump start a discussion on leaders they admire in their own life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1894, 1435, 11, 100, NULL, NULL, 'Respond to your mentee’s example of a leader they admire. If you’re not familiar with this person, do a quick search and tell your mentee one quality or action that you also admire about that leader.<p><p>How does that quality show up in your own life? Be specific! Share an area in which you can embrace that quality in your personal or professional life. This is a great opportunity to model for your mentee the idea that there is always room to grow and improve.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1895, 1436, 11, 100, NULL, NULL, 'A “LEAD” framework is a set of verbs starting with those letters (L-E-A-D). Each verb should represent a quality or action that you, personally, associate with leadership. (Example: Listen, Empower, Assist, Decide)<p><p>Share your LEAD framework with your mentee to help them think through their own in the next lesson. Be sure to explain why you chose those verbs, in particular.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1896, 1436, 6, 200, NULL, 'https://docs.google.com/document/d/1oWox_sCJBhq71xm3MB9ECftVhxw6bOGZAqk8TWzQf-k/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (412, 1894, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (402, 1892, 410, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (403, 1893, 411, TRUE, 100, 0);