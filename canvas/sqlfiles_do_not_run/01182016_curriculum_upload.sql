--Update a mentee section description for 12.9.2

UPDATE canvas_app
SET description = 'Share with your mentor'
WHERE id IN (1092, 1095);

UPDATE canvas_app_copy
SET description = 'Share with your mentor'
WHERE parent_id IN (1092, 1095);

--Update a mentor section description for 11.10.4 and 11.10.2

UPDATE canvas_app
SET description = 'Support your mentee'
WHERE id IN (1161, 1199);

UPDATE canvas_app_copy
SET description = 'Support your mentee'
WHERE parent_id IN (1161, 1199);

--9.5.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (132, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 33, 3, NULL, 'Who’s Who in School?', '/new_platform/static/canvas/images/9.5.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (375, 1, 132, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Who’s Who in School?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1216, 375, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1217, 375, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1218, 375, 2, 1, 2, 300, 'What are my resources in school?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1219, 375, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2121, 1216, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2122, 1216, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2123, 1217, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2124, 1218, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2125, 1219, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2126, 1219, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2779, 2121, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will support mentees as they explore who is responsible for supporting them in which specific ways during their high school experience. The list can include their parents, mentors, school staff, teachers, coaches, etc.<p><p>In this lesson, mentees will:<ul><li>Identify resources available to them at school and within their larger network</li><li>Assess whether or not they are utilizing these resources effectively</li><li>Make the connection between understanding their resources and being able to effectively advocate for themselves</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/whos-who-in-school---953" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2780, 2122, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2781, 2122, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ijl_M9ZcS2e-VFuYQj5H6Xz3C1ZGAkaH2FJQN5qZ-Ss/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2782, 2123, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2783, 2124, 9, 100, NULL, '/new_platform/static/canvas/images/School_Resources.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2784, 2124, 11, 200, NULL, NULL, 'Key Questions:<ul><li>What are the resources available to you at school?</li><li>Who are the people that can help you?</li><li>Where are the people, offices, and resources located?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2785, 2125, 11, 100, NULL, NULL, 'Your mentor responded to your learning style quiz results. They also took the quiz and shared their results with you. Read about your mentor’s learning style and respond.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2786, 2126, 11, 100, NULL, NULL, 'Thinking about the resources you went over in class today, share the following with your mentor:<ul><li>Which resources do you use most often? Why?</li><li>Which resource do you not feel comfortable using? Why?</li><li>How can you use these resources to advocate for yourself when you need to?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (598, 2785, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (599, 2786, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (566, 2785, 596, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (567, 2785, 597, TRUE, 200, 0);

--9.5.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (376, 5, 132, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Who’s Who in School?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1220, 376, 2, 1, 2, 100, 'What are my resources in school?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1221, 376, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2127, 1220, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2128, 1221, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2129, 1221, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2787, 2127, 9, 100, NULL, '/new_platform/static/canvas/images/School_Resources.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2788, 2127, 11, 200, NULL, NULL, 'Key Questions:<ul><li>What are the resources available to you at school?</li><li>Who are the people that can help you?</li><li>Where are the people, offices, and resources located?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2789, 2128, 11, 100, NULL, NULL, 'Your mentor responded to your learning style quiz results. They also took the quiz and shared their results with you. Read about your mentor’s learning style and respond.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2790, 2129, 11, 100, NULL, NULL, 'Thinking about the resources you went over in class today, share the following with your mentor:<ul><li>Which resources do you use most often? Why?</li><li>Which resource do you not feel comfortable using? Why?</li><li>How can you use these resources to advocate for yourself when you need to?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (600, 2789, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (601, 2790, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (568, 2789, 596, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (569, 2789, 597, TRUE, 200, 0);

--9.5.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (377, 4, 132, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Who’s Who in School?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1222, 377, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1223, 377, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2130, 1222, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2131, 1223, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2132, 1223, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2791, 2130, 11, 100, NULL, NULL, 'As a new high school student, your mentee may still not know about all the resources that are available to them at school. This lesson introduced some of those resources, i.e. people, offices, materials, etc., to them and reviewed when they might choose to use which resource.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2792, 2131, 11, 100, NULL, NULL, 'Your mentee shared their feedback on your quiz results. They also shared which resources they use most often and which they don’t feel comfortable using at all.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2793, 2132, 11, 100, NULL, NULL, 'Respond to your mentee. Encourage them to use all the resources available to them to ensure a positive and successful high school experience. Share about a resource or person you may have relied on when you were in high school.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (602, 2793, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (570, 2792, 600, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (571, 2792, 601, TRUE, 200, 0);

--9.5.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (133, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 33, 4, NULL, 'How Do I Advocate?', '/new_platform/static/canvas/images/9.5.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (378, 1, 133, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Advocate?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1224, 378, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1225, 378, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1226, 378, 2, 1, 1, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2133, 1224, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2134, 1224, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2135, 1225, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2136, 1226, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2137, 1226, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2794, 2133, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Building on the prior weeks'' lessons, this lesson will ask mentees to apply their learning to a number of specific scenarios.<p><p>In this lesson, mentees will:<ul><li>Identify the different components of successful self-advocacy</li><li>Map those components to their own personal preferences and characteristics</li><li>Apply the components and their preferences to a specific scenario</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/how-do-i-advocate---954" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2795, 2134, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2796, 2134, 6, 200, NULL, 'https://docs.google.com/presentation/d/1g6eGeiyS8QntlrilraU4VbD-rk63beq3_i_PNTvsrVI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2797, 2135, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2798, 2136, 11, 100, NULL, NULL, 'Your mentor responded to you and shared about additional people or resources you may want to access in high school.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2799, 2137, 11, 100, NULL, NULL, 'Share an update with your mentor. You can respond to something your mentor wrote or share something you talked about in class.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (603, 2799, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (572, 2798, 602, TRUE, 100, 0);

--9.5.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (379, 5, 133, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Advocate?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1227, 379, 2, 1, 1, 100, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2138, 1227, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2139, 1227, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2800, 2138, 11, 100, NULL, NULL, 'Your mentor responded to you and shared about additional people or resources you may want to access in high school.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2801, 2139, 11, 100, NULL, NULL, 'Share an update with your mentor. You can respond to something your mentor wrote or share something you talked about in class.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (604, 2801, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (573, 2800, 602, TRUE, 100, 0);

--9.5.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (380, 4, 133, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Advocate?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1228, 380, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1229, 380, 2, 2, 2, 200, 'Support your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2140, 1228, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2141, 1228, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2142, 1229, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2802, 2140, 11, 100, NULL, NULL, 'Building on the lessons from prior weeks, your mentee applied what they learned about self-advocacy to different scenarios. Based on the information provided below, they were asked to determine the following:<ul><li>What is this person asking for?</li><li>What information does this person need?</li><li>What seems like the best way for them to ask for what they need?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2803, 2140, 8, 200, NULL, '/new_platform/static/canvas/documents/Resource_Scenarios.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2804, 2141, 11, 100, NULL, NULL, 'Your mentee shared a personal update with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2805, 2142, 11, 100, NULL, NULL, 'Helping your mentee build their self-advocacy skills will be critical to their high school success and college readiness. Here are two tips to keep in mind as you continue to build your relationship:<ul><li>Encourage your mentee to seek help (from you and others) as the need arises. There will be no shortage of things your mentee will need help with.</li><li>Remember, the ability to assess their own needs and seek help will be a skill they’ll need to rely on more and more. Even if you know your mentee is struggling with something, don’t just always rush in to try and fix it. Use your best judgment.</li></ul>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (574, 2804, 604, TRUE, 100, 0);