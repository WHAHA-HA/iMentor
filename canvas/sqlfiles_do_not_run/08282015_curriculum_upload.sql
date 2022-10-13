--Staff Lesson 13.1.1

INSERT into canvas_grade_info (id, grade_number, description) VALUES (5, 13, 'Freshman Year, College');

INSERT into canvas_unit_info (id, unit_number, description) VALUES (6, 1, 'Academic Progress');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (20, 1, '6/19/15 00:00:00', '6/19/15 23:59:59', 5, 6, 1, NULL, 'Monthly Lesson');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (42, 1, 20, '6/19/15 00:00:00', '6/19/15 23:59:59', 'Monthly Lesson');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (115, 42, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (116, 42, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (117, 42, 2, 1, 4, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (118, 42, 2, 2, 4, 400, 'Read this month’s objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (119, 42, 2, 3, 4, 500, 'Create a study plan');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (120, 42, 2, 4, 4, 600, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (193, 115, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (194, 116, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (195, 117, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (196, 118, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (197, 119, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (198, 119, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (199, 120, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (200, 120, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (279, 193, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This learning topic covers the habits and activities that support academic success in college. It will provide a framework for monitoring academic progress and pursuing resources as necessary.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Understand the differences in academic expectations between High School and College</li><li>Create a college study plan that organizes when and how they will study for each class</li><li>Review their Pair To Do List for the month</li><li>Schedule time to work on the items on their Pair To Do List with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/monthly-canvas-lesson-academic-progress" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (280, 194, 11, 100, NULL, NULL, 'The following Canvas cards are what your mentees will see when they log in to complete this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (281, 195, 11, 100, NULL, NULL, 'Welcome to your first lesson in the college program! To start, watch this video of iMentor pairs in college.<p><p>As you watch, consider the following:<ul><li>How do academic expectations differ between high school and college?</li><li>What habits or actions allowed the mentees in this video to meet these new expectations?</li><li>How do you want your mentor to support your academics this year?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (282, 195, 2, 200, NULL, 'https://www.youtube.com/watch?v=PEu5Sj-BiQQ', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (283, 196, 11, 100, NULL, NULL, 'Every month, our curriculum will focus on one important difference between high school and college. This month, our focus is on “academic progress”. Below are our objectives, and you can learn more about this topic <a href="https://learn.imentor.org/help/article/link/topic-overview-academic-progress" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (284, 196, 6, 200, NULL, 'https://docs.google.com/presentation/d/12NvNdXO3GXthUBY4Cuk9-ATEUPZIPhpN4aVWf51xA7A/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (285, 197, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/creating-a-college-study-plan" target="_blank">this</a> article about creating a study plan in college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (286, 198, 11, 100, NULL, NULL, 'Follow the instructions in the article above to create a study plan using this template.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (287, 198, 6, 200, NULL, 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit#gid=0', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (288, 199, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (289, 199, 6, 200, NULL, 'https://docs.google.com/presentation/d/1zuZRzG3yidioxRQ7CmE-A-pte2VIvCiAd0vP8m5VDiI/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (290, 200, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--Staff Lesson 9.1.4

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (21, 1, '6/20/15 00:00:00', '6/20/15 23:59:59', 1, 2, 4, NULL, 'About Us');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (43, 1, 21, '6/20/15 00:00:00', '6/20/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (121, 43, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (122, 43, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (123, 43, 2, 1, 2, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (124, 43, 2, 2, 2, 400, 'Class norms');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (201, 121, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (202, 121, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (203, 121, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (204, 122, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (205, 123, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (206, 124, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (291, 201, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the idea of classroom culture and teamwork and provide mentees with an opportunity to create class norms and behaviors regarding the way mentees engage with the curriculum, their mentors, their staff member, and their peers.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create community norms to guide their behavior and interactions in class and with their mentors, staff members and peers</li><li>Complete matching applications</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-relationships-about-us" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (292, 202, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editting-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (293, 202, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Wqn3Y385R0dsD13pauTzib99bsSo8Rp5CsX_3PZwYFE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (294, 203, 11, 100, NULL, NULL, 'If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (295, 203, 3, 200, NULL, 'https://vimeo.com/135689070', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (296, 204, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (297, 205, 3, 100, NULL, 'https://vimeo.com/135689070', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (298, 205, 11, 200, NULL, NULL, 'Consider the following:<ul><li>How did the 2 dogs work together in this video?</li><li>What observations did the dogs need to make about one another in order to work together in this way?</li><li>What role did both dogs play to influence the outcome?</li><li>What would have happened if only one dog was trying to accomplish this task?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (299, 206, 11, 100, NULL, NULL, 'Consider the following:<ul><li>How would you like you and your classmates to interact with each other through the program?</li><li>How do you think your mentor would like you to interact with them in the program?</li><li>How would you like your mentor to interact with you in the program?</li><li>What are you looking forward to about the program, or what successes do you think we might experience?</li><li>What can we do as a class to celebrate and encourage each other during those successes?</li></ul>', NULL);

--Mentee Lesson 9.1.4

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (44, 5, 21, '6/20/15 00:00:00', '6/20/15 23:59:59', 'About Us');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (125, 44, 2, 1, 2, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (126, 44, 2, 2, 2, 200, 'Class norms');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (207, 125, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (208, 126, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (300, 207, 3, 100, NULL, 'https://vimeo.com/135689070', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (301, 207, 11, 200, NULL, NULL, 'Consider the following:<ul><li>How did the 2 dogs work together in this video?</li><li>What observations did the dogs need to make about one another in order to work together in this way?</li><li>What role did both dogs play to influence the outcome?</li><li>What would have happened if only one dog was trying to accomplish this task?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (302, 208, 11, 100, NULL, NULL, 'Consider the following:<ul><li>How would you like you and your classmates to interact with each other through the program?</li><li>How do you think your mentor would like you to interact with them in the program?</li><li>How would you like your mentor to interact with you in the program?</li><li>What are you looking forward to about the program, or what successes do you think we might experience?</li><li>What can we do as a class to celebrate and encourage each other during those successes?</li></ul>', NULL);

--Staff Lesson 10.1.4

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (22, 1, '6/21/15 00:00:00', '6/21/15 23:59:59', 2, 4, 4, NULL, 'New Year, New Expectations');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (45, 1, 22, '6/21/15 00:00:00', '6/21/15 23:59:59', 'New Year, New Expectations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (127, 45, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (128, 45, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (129, 45, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (130, 45, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (209, 127, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (210, 127, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (211, 128, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (212, 129, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (213, 129, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (214, 130, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (303, 209, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce priorities for the 10th grade, discuss how and why this year will be the same or different from last year, and ask mentees to draw upon their 9th grade experiences to consider how to make this year successful.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Diagram differences between the 9th and 10th grades.</li><li>Identify and define key differences worth planning ahead for.</li><li>Predict the challenges they might face in 10th grade.</li><li>Use the data to develop norms with their mentor to help them in navigating these challenges.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/new-year-new-expectations" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (304, 210, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (305, 210, 6, 200, NULL, 'https://docs.google.com/presentation/d/1vTrmSpu7rfH2WxjGtsJVvsvzQXiEwXfNipF1XqR1uyY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (306, 211, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (307, 212, 11, 100, NULL, NULL, 'Here’s your mentor’s response from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (308, 213, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (309, 214, 11, 100, NULL, NULL, 'Based on your activities in class, share the following with your mentor:<ul><li>What are the key challenges you think you’ll face in the 10th grade?</li><li>Why did you choose those examples?</li><li>What suggestions can you give your mentor for supporting you through those challenges?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (46, 308, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (47, 309, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (28, 307, 37, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (29, 307, 38, TRUE, 200, 0);

--Mentee Lesson 10.1.4

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (46, 5, 22, '6/21/15 00:00:00', '6/21/15 23:59:59', 'New Year, New Expectations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (131, 46, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (132, 46, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (215, 131, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (216, 131, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (217, 132, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (310, 215, 11, 100, NULL, NULL, 'Here’s your mentor’s response from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (311, 216, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (312, 217, 11, 100, NULL, NULL, 'Based on your activities in class, share the following with your mentor:<ul><li>What are the key challenges you think you’ll face in the 10th grade?</li><li>Why did you choose those examples?</li><li>What suggestions can you give your mentor for supporting you through those challenges?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (48, 311, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (49, 312, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (30, 310, 37, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (31, 310, 38, TRUE, 200, 0);

--Mentor Lesson 10.1.4

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (47, 4, 22, '6/21/15 00:00:00', '6/21/15 23:59:59', 'New Year, New Expectations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (133, 47, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (134, 47, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (218, 133, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (219, 134, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (220, 134, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (313, 218, 11, 100, NULL, NULL, 'In class, your mentee discussed the key differences between 9th and 10th grade and identified challenges they think they will face as a 10th grader.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (314, 219, 11, 100, NULL, NULL, 'Respond to your mentee’s challenges and the ways they suggested you could support them. What other strategies can you suggest to help your mentee address the challenges they listed?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (315, 220, 11, 100, NULL, NULL, 'Your mentee also responded to you from previous weeks. Read your mentee’s response and share your final thoughts on the below topic.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (50, 314, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (51, 315, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (32, 313, 49, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (33, 315, 48, TRUE, 100, 0);