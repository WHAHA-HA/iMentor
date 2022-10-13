--9.4.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (99, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 21, 3, NULL, 'Resilience and Grit in High School: Social', '/new_platform/static/canvas/images/9.4.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (276, 1, 99, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Social');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (891, 276, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (892, 276, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (893, 276, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (894, 276, 2, 2, 4, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (895, 276, 2, 3, 4, 500, 'Create a PSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (896, 276, 2, 4, 4, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1597, 891, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1598, 891, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1599, 891, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1600, 892, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1601, 893, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1602, 894, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1603, 895, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1604, 895, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1605, 895, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1606, 896, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1607, 896, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2107, 1597, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore the varying pressures that are a part of high school: friends, family, school, and community. Mentees will discuss the role resilience and grit play in navigating these pressures successfully.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on the areas of high school social life that are prominent at their school</li><li>Create a PSA for one area of high school social life</li><li>Reflect on the role of resilience in one area of high school life</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-resilience-and-grit-in-high-school-social" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2108, 1598, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2109, 1598, 6, 200, NULL, 'https://docs.google.com/presentation/d/15AK4u6Kx428uBLQ-6xxAnxqXWENwmYTp4wmK4AhUNR0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2110, 1599, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2111, 1599, 3, 200, NULL, 'https://vimeo.com/141564659', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2112, 1600, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2113, 1601, 11, 100, NULL, NULL, 'Your mentor offered advice on the academic challenge that you shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2114, 1602, 11, 100, NULL, NULL, 'As you watch the video, think about the following:<ul><li>How is this video similar to the social life in your school?</li><li>How is it different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2115, 1602, 3, 200, NULL, 'https://vimeo.com/141564659', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2116, 1603, 11, 100, NULL, NULL, 'Click through the slides below to learn what a “PSA” is and see examples, so you can make your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2117, 1603, 6, 200, NULL, 'https://docs.google.com/presentation/d/1cw0SjE-kgeL9uD36eAwurAQXGbGkADPJy53WVj9JLhg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2118, 1604, 11, 100, NULL, NULL, 'Make your own Public Service Announcement<ul><li>​Choose an aspect of social life at your school that needs a PSA.</li><li>What do you want students to know about this topic?</li><li>How can you encourage them to demonstrate resilience?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2119, 1605, 11, 100, NULL, NULL, 'Click <a href="https://docs.google.com/drawings/d/1U6aDkdDp125YznKo0qNorQKDg10Hkg9W5iwJFVVYp6Y/edit?usp=sharing" target="_blank">here</a> to start your PSA in Google Drawing.<p><p>For instructions on using Google Drawing, click <a href="https://vimeo.com/135490195" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2120, 1606, 11, 100, NULL, NULL, 'Tell your mentor why you selected this topic. Why is it important to you? How does the PSA you created in class encourage resilience in high school students?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2121, 1607, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (457, 2120, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (458, 2121, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (437, 2113, 425, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (438, 2113, 426, TRUE, 200, 0);

--9.4.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (277, 5, 99, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Social');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (897, 277, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (898, 277, 2, 2, 4, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (899, 277, 2, 3, 4, 300, 'Create a PSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (900, 277, 2, 4, 4, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1608, 897, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1609, 898, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1610, 899, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1611, 899, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1612, 899, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1613, 900, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1614, 900, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2122, 1608, 11, 100, NULL, NULL, 'Your mentor offered advice on the academic challenge that you shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2123, 1609, 11, 100, NULL, NULL, 'As you watch the video, think about the following:<ul><li>How is this video similar to the social life in your school?</li><li>How is it different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2124, 1609, 3, 200, NULL, 'https://vimeo.com/141564659', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2125, 1610, 11, 100, NULL, NULL, 'Click through the slides below to learn what a “PSA” is and see examples, so you can make your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2126, 1610, 6, 200, NULL, 'https://docs.google.com/presentation/d/1cw0SjE-kgeL9uD36eAwurAQXGbGkADPJy53WVj9JLhg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2127, 1611, 11, 100, NULL, NULL, 'Make your own Public Service Announcement<ul><li>​Choose an aspect of social life at your school that needs a PSA.</li><li>What do you want students to know about this topic?</li><li>How can you encourage them to demonstrate resilience?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2128, 1612, 11, 100, NULL, NULL, 'Click <a href="https://docs.google.com/drawings/d/1U6aDkdDp125YznKo0qNorQKDg10Hkg9W5iwJFVVYp6Y/edit?usp=sharing" target="_blank">here</a> to start your PSA in Google Drawing.<p><p>For instructions on using Google Drawing, click <a href="https://vimeo.com/135490195" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2129, 1613, 11, 100, NULL, NULL, 'Tell your mentor why you selected this topic. Why is it important to you? How does the PSA you created in class encourage resilience in high school students?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2130, 1614, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (459, 2129, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (460, 2130, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (439, 2122, 425, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (440, 2122, 426, TRUE, 200, 0);

--9.4.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (278, 4, 99, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Resilience and Grit in High School: Social');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (901, 278, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (902, 278, 2, 2, 3, 200, 'Respond to your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (903, 278, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1615, 901, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1616, 901, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1617, 901, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1618, 902, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1619, 903, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2131, 1615, 11, 100, NULL, NULL, 'Your mentee used the following video to discuss the different aspects of social life in their high school.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2132, 1615, 3, 200, NULL, 'https://vimeo.com/141564659', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2133, 1616, 11, 100, NULL, NULL, 'Then, your mentee selected an aspect of social life that is important to them and created a Public Service Announcement (“PSA”) for it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2134, 1617, 11, 100, NULL, NULL, 'Check out your mentee’s PSA and explanation.<p><p>Click <a href="https://docs.google.com/drawings/d/1U6aDkdDp125YznKo0qNorQKDg10Hkg9W5iwJFVVYp6Y/edit?usp=sharing" target="_blank">here</a> to view your mentee’s PSA.</p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2136, 1618, 11, 100, NULL, NULL, 'Share some thoughts with your mentee on the topic they chose, the PSA they created, and how it demonstrates resilience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2137, 1619, 11, 100, NULL, NULL, 'Read your mentee’s personal update and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (461, 2136, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (462, 2137, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (441, 2134, 459, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (442, 2137, 460, TRUE, 100, 0);

--12.5.1 Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.5.1.jpg'
WHERE id = 95;

--12.5.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (100, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 24, 2, NULL, 'FAFSA Refresher', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (279, 1, 100, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Refresher');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (904, 279, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (905, 279, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (906, 279, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (907, 279, 2, 2, 3, 400, 'Learn about FAFSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (908, 279, 2, 3, 3, 500, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1620, 904, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1621, 904, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1622, 904, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1623, 905, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1624, 906, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1625, 906, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1626, 907, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1627, 907, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1628, 907, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1629, 908, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2138, 1620, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to help mentees access prior knowledge of the FAFSA and be prepared to file in the following weeks.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Watch and discuss a video that describes an overview of the FAFSA</li><li>Review the FAFSA application process</li><li>Review the FAFSA application and identify where they can acquire the information needed to complete it</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/fafsa-refresher" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2139, 1621, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2140, 1621, 6, 200, NULL, 'https://docs.google.com/presentation/d/1V46__Y6v4yYS0pFeZIABHTzTkAeAUJYmLn89xBerqU0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2141, 1622, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2142, 1622, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2143, 1623, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2144, 1624, 11, 100, NULL, NULL, 'Your mentor responded to the concerns you shared about the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2145, 1625, 11, 100, NULL, NULL, 'Your mentor then offered some insight into their own experience with paying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2146, 1626, 11, 100, NULL, NULL, 'As you watch the video, consider the following:<ul><li>What is the FAFSA used for?</li><li>Why is it important that anyone even thinking about going to college complete the FAFSA?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2147, 1626, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2148, 1627, 11, 100, NULL, NULL, 'Look at the following infographic about the FAFSA. Consider what questions you have about the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2149, 1627, 8, 200, NULL, '/new_platform/static/canvas/documents/FAFSA_Infographic.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2150, 1628, 11, 100, NULL, NULL, 'Create a FSA ID at the FAFSA site below. If you already have one, use your FSA ID to log in and confirm your ID.<p><p>Visit <a href="https://fsaid.ed.gov/npas/index.htm" target="_blank">https://fsaid.ed.gov/npas/index.htm</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2151, 1629, 11, 100, NULL, NULL, 'Share the following with your mentor.<ul><li>Summarize your feelings about the FAFSA process.</li><li>What do you think will be the most challenging part of the application and process?</li><li>How might your mentor help you complete the application on time?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (463, 2151, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (443, 2144, 449, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (444, 2145, 450, TRUE, 100, 0);

--12.5.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (280, 5, 100, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Refresher');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (909, 280, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (910, 280, 2, 2, 3, 200, 'Learn about FAFSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (911, 280, 2, 3, 3, 300, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1630, 909, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1631, 909, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1632, 910, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1633, 910, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1634, 910, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1635, 911, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2152, 1630, 11, 100, NULL, NULL, 'Your mentor responded to the concerns you shared about the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2153, 1631, 11, 100, NULL, NULL, 'Your mentor then offered some insight into their own experience with paying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2154, 1632, 11, 100, NULL, NULL, 'As you watch the video, consider the following:<ul><li>What is the FAFSA used for?</li><li>Why is it important that anyone even thinking about going to college complete the FAFSA?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2155, 1632, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2156, 1633, 11, 100, NULL, NULL, 'Look at the following infographic about the FAFSA. Consider what questions you have about the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2157, 1633, 8, 200, NULL, '/new_platform/static/canvas/documents/FAFSA_Infographic.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2158, 1634, 11, 100, NULL, NULL, 'Create a FSA ID at the FAFSA site below. If you already have one, use your FSA ID to log in and confirm your ID.<p><p>Visit <a href="https://fsaid.ed.gov/npas/index.htm" target="_blank">https://fsaid.ed.gov/npas/index.htm</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2159, 1635, 11, 100, NULL, NULL, 'Share the following with your mentor.<ul><li>Summarize your feelings about the FAFSA process.</li><li>What do you think will be the most challenging part of the application and process?</li><li>How might your mentor help you complete the application on time?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (464, 2159, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (445, 2152, 449, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (446, 2153, 450, TRUE, 100, 0);

--12.5.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (281, 4, 100, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Refresher');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (912, 281, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (913, 281, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1636, 912, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1637, 912, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1638, 913, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1639, 913, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2160, 1636, 11, 100, NULL, NULL, 'Your mentee watched the following video about FAFSA and discussed what the FAFSA is used for.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2161, 1636, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2162, 1637, 11, 100, NULL, NULL, 'Then, your mentee reviewed the following infographic about the FAFSA process and discussed specific questions they have about the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2163, 1637, 8, 200, NULL, '/new_platform/static/canvas/documents/FAFSA_Infographic.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2164, 1638, 11, 100, NULL, NULL, 'Your mentee reflected on your experiences and the information they learned during class. They wrote about their feelings about the FAFSA process, any challenges they think they’ll face, and how they think you can help them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2165, 1639, 11, 100, NULL, NULL, 'To receive federal financial aid, your mentee MUST complete the FAFSA. Even if your mentee is unsure about going to college, they should still be prepared to complete the FAFSA.<p><p>Click <a href="https://learn.imentor.org/help/article/link/how-mentors-can-help-with-the-fafsa" target="_blank">here</a> for more information on how to support your mentee.</p></p>When you respond to your mentee:<ul><li>Stress the importance of completing the FAFSA on time.</li><li>What tips do you have for your mentee to navigate their identified challenges?</li><li>How might you help your mentee complete the FAFSA on time?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (465, 2165, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (447, 2164, 464, TRUE, 100, 0);