--Staff Lesson 13.1.2

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (49, 1, '7/18/15 00:00:00', '7/18/15 23:59:59', 5, 6, 2, NULL, 'Campus Engagement');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (127, 1, 49, '7/18/15 00:00:00', '7/18/15 23:59:59', 'Campus Engagement');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (395, 127, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (396, 127, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (397, 127, 2, 1, 4, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (398, 127, 2, 2, 4, 400, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (399, 127, 2, 3, 4, 500, 'Get engaged');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (400, 127, 2, 4, 4, 600, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (675, 395, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (676, 396, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (677, 397, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (678, 397, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (679, 398, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (680, 399, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (681, 399, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (682, 399, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (683, 400, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (684, 400, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (924, 675, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This learning topic covers different ways to connect with a new college environment and ways to account for the factors that can make campus involvement difficult. It provides resources to help you pursue campus engagement in the ways that make sense for you.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Understand the importance of campus engagement for many different types of students</li><li>Select an approach to improving campus engagement that applies personally, then pursue it</li><li>Review their Pair To Do List for the month</li><li>Schedule time to work on the items on their Pair To Do List with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/online-lesson-campus-engagement" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (925, 676, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (926, 677, 11, 100, NULL, NULL, 'Watch the following CollegeBoard video of a student discussing campus engagement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (927, 677, 2, 200, NULL, 'https://www.youtube.com/watch?v=KxiiMoD9EMQ&feature=youtu.be', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (928, 678, 11, 100, NULL, NULL, 'Browse through 10 other student stories of campus engagement <a href="https://bigfuture.collegeboard.org/find-colleges/campus-life/my-college-life-outside-the-classroom" target="_blank">here</a>.<ul><li>Look for students whose interests or circumstances seem similar to yours.</li><li>Consider what these students did to shape their college lives.</li><li>Reflect on how campus involvement could impact your college experience.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (929, 679, 11, 100, NULL, NULL, 'This month, our curriculum focuses on “campus engagement”. Below are our objectives. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-campus-engagement" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (930, 679, 6, 200, NULL, 'https://docs.google.com/presentation/d/1RmLwp7w9Z0ISDGgBKIkIdJRxfevS_NKBreMm7wY-YmQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (931, 680, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/ways-to-get-involved-on-campus" target="_blank">this</a> article about ways to get involved on campus. Select at least 1 that applies to you personally.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (932, 681, 11, 100, NULL, NULL, 'Identify at least one action step for the approach you selected from the article. You can use one of the recommended steps provided, or create your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (933, 682, 11, 100, NULL, NULL, 'Use the google doc below to explain your action step, or write a draft of your next step so your mentor can see it and give you feedback.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (934, 682, 6, 200, NULL, 'https://docs.google.com/document/d/1kt_7iY8N8nBbm8g5jnReqKe6czyenAUuEebpFl2t0Vg/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (935, 683, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (936, 683, 6, 200, NULL, 'https://docs.google.com/presentation/d/13REfYKZQq1yPmSd6UHecaMuHINC-9K2cQ_iO1Z0b4Qg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (937, 684, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--Mentee Lesson 13.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (128, 5, 49, '7/18/15 00:00:00', '7/18/15 23:59:59', 'Campus Engagement');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (401, 128, 2, 1, 4, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (402, 128, 2, 2, 4, 200, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (403, 128, 2, 3, 4, 300, 'Get engaged');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (404, 128, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (685, 401, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (686, 401, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (687, 402, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (688, 403, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (689, 403, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (690, 403, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (691, 404, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (692, 404, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (938, 685, 11, 100, NULL, NULL, 'Watch the following CollegeBoard video of a student discussing campus engagement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (939, 685, 2, 200, NULL, 'https://www.youtube.com/watch?v=KxiiMoD9EMQ&feature=youtu.be', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (940, 686, 11, 100, NULL, NULL, 'Browse through 10 other student stories of campus engagement <a href="https://bigfuture.collegeboard.org/find-colleges/campus-life/my-college-life-outside-the-classroom" target="_blank">here</a>.<ul><li>Look for students whose interests or circumstances seem similar to yours.</li><li>Consider what these students did to shape their college lives.</li><li>Reflect on how campus involvement could impact your college experience.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (941, 687, 11, 100, NULL, NULL, 'This month, our curriculum focuses on “campus engagement”. Below are our objectives. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-campus-engagement" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (942, 687, 6, 200, NULL, 'https://docs.google.com/presentation/d/1RmLwp7w9Z0ISDGgBKIkIdJRxfevS_NKBreMm7wY-YmQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (943, 688, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/ways-to-get-involved-on-campus" target="_blank">this</a> article about ways to get involved on campus. Select at least 1 that applies to you personally.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (944, 689, 11, 100, NULL, NULL, 'Identify at least one action step for the approach you selected from the article. You can use one of the recommended steps provided, or create your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (945, 690, 11, 100, NULL, NULL, 'Use the google doc below to explain your action step, or write a draft of your next step so your mentor can see it and give you feedback.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (946, 690, 6, 200, NULL, 'https://docs.google.com/document/d/1kt_7iY8N8nBbm8g5jnReqKe6czyenAUuEebpFl2t0Vg/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (947, 691, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (948, 691, 6, 200, NULL, 'https://docs.google.com/presentation/d/13REfYKZQq1yPmSd6UHecaMuHINC-9K2cQ_iO1Z0b4Qg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (949, 692, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--Mentor Lesson 13.1.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (129, 4, 49, '7/18/15 00:00:00', '7/18/15 23:59:59', 'Campus Engagement');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (405, 129, 2, 1, 4, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (406, 129, 2, 2, 4, 200, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (407, 129, 2, 3, 4, 300, 'Get engaged');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (408, 129, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (693, 405, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (694, 405, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (695, 406, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (696, 407, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (697, 407, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (698, 407, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (699, 408, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (700, 408, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (950, 693, 11, 100, NULL, NULL, 'Watch the following CollegeBoard video of a student discussing campus engagement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (951, 693, 2, 200, NULL, 'https://www.youtube.com/watch?v=KxiiMoD9EMQ&feature=youtu.be', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (952, 694, 11, 100, NULL, NULL, 'Browse through 10 other student stories of campus engagement <a href="https://bigfuture.collegeboard.org/find-colleges/campus-life/my-college-life-outside-the-classroom" target="_blank">here</a>.<ul><li>Look for students whose interests or circumstances seem similar to your mentee’s. Consider what they did to shape their college experience.</li><li>Reflect on how you got involved on your college campus and the impact it had on your college experience.</li><li>Talk to your mentee about how campus involvement could impact their college experience.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (953, 695, 11, 100, NULL, NULL, 'This month, our curriculum focuses on “campus engagement”. Below are our objectives. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-campus-engagement" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (954, 695, 6, 200, NULL, 'https://docs.google.com/presentation/d/1RmLwp7w9Z0ISDGgBKIkIdJRxfevS_NKBreMm7wY-YmQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (955, 696, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/ways-to-get-involved-on-campus" target="_blank">this</a> article about ways to get involved on campus. Talk to your mentee about which of these applies to them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (956, 697, 11, 100, NULL, NULL, 'Work with your mentee to develop at least one action step for the approach to campus involvement that makes sense for them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (957, 698, 11, 100, NULL, NULL, 'The google doc below is for you and your mentee to use as relevant for outlining your mentee’s next steps or drafting any next steps (e.g. emails).<p><p>Talk to your mentee about the best way to collaborate on an action plan and draft.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (958, 698, 6, 200, NULL, 'https://docs.google.com/document/d/1kt_7iY8N8nBbm8g5jnReqKe6czyenAUuEebpFl2t0Vg/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (959, 699, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that your mentee should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (960, 699, 6, 200, NULL, 'https://docs.google.com/presentation/d/13REfYKZQq1yPmSd6UHecaMuHINC-9K2cQ_iO1Z0b4Qg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (961, 700, 11, 100, NULL, NULL, 'Schedule some time to work on these things with your mentee. This should include at least one in-person meeting plus any combination of additional meetings, phone calls, texts, etc. <a href="https://learn.imentor.org/help/article/link/suggested-pair-meetings-for-topic-2" target="_blank">Here</a> are some suggestions for in-person meetings this month.', NULL);

--Staff Lesson 11.2.1

INSERT into canvas_unit_info (id, unit_number, description) VALUES (7, 2, 'My College Pathways');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (50, 1, '7/19/15 00:00:00', '7/19/15 23:59:59', 3, 7, 1, NULL, 'Making it Real: My Personal Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (130, 1, 50, '7/19/15 00:00:00', '7/19/15 23:59:59', 'Making it Real: My Personal Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (409, 130, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (410, 130, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (411, 130, 2, 1, 2, 300, 'Click through the following statements');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (412, 130, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (701, 409, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (702, 409, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (703, 410, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (704, 411, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (705, 412, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (962, 701, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees narrow potential career pathways, write a personal vision statement, and create goals for 10 years down the road.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Brainstorm about their future goals</li><li>Create a mind map that expresses their long-term vision and goals</li><li>Reflect on and write a personal vision statement to their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/making-it-real-personal-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (963, 702, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (964, 702, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Z66wfHNgRgMkMfzJhVI6Dghw_D1NsfY7laonstgyTC0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (965, 703, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (966, 704, 6, 100, NULL, 'https://docs.google.com/presentation/d/1ZYMye1NB8X7eic-bz2qqBxkuKAIQlzO8MXVsDSQ5bHg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (967, 704, 11, 200, NULL, NULL, '<ul><li>What do each of the statements mean?</li><li>How do you think the statements show up in the day-to-day lives of their authors?</li><li>How do you think setting personal vision and mission statements can be helpful in achieving long-term goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (968, 705, 11, 100, NULL, NULL, 'Share your personal mission statement with your mentor. Remember to consider the following:<ul><li>Where do you want to be in 10 years?</li><li>Remember to include your personal and professional goals.</li><li>How can your mentor help you along the way?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (178, 968, 100, 0, 2);

--Mentee Lesson 11.2.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (131, 5, 50, '7/19/15 00:00:00', '7/19/15 23:59:59', 'Making it Real: My Personal Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (413, 131, 2, 1, 2, 100, 'Click through the following statements');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (414, 131, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (706, 413, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (707, 414, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (969, 706, 6, 100, NULL, 'https://docs.google.com/presentation/d/1ZYMye1NB8X7eic-bz2qqBxkuKAIQlzO8MXVsDSQ5bHg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (970, 706, 11, 200, NULL, NULL, '<ul><li>What do each of the statements mean?</li><li>How do you think the statements show up in the day-to-day lives of their authors?</li><li>How do you think setting personal vision and mission statements can be helpful in achieving long-term goals?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (971, 707, 11, 100, NULL, NULL, 'Share your personal mission statement with your mentor. Remember to consider the following:<ul><li>Where do you want to be in 10 years?</li><li>Remember to include your personal and professional goals.</li><li>How can your mentor help you along the way?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (179, 971, 100, 0, 2);

--Mentor Lesson 11.2.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (132, 4, 50, '7/19/15 00:00:00', '7/19/15 23:59:59', 'Making it Real: My Personal Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (415, 132, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (416, 132, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (708, 415, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (709, 416, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (710, 416, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (711, 416, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (972, 708, 6, 100, NULL, 'https://docs.google.com/presentation/d/1ZYMye1NB8X7eic-bz2qqBxkuKAIQlzO8MXVsDSQ5bHg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (973, 708, 11, 200, NULL, NULL, 'Your mentee reviewed and discussed the personal mission statements above. They discussed where they want to be in 10 years, created a mind map of their goals, and wrote a personal mission statement of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (974, 709, 11, 100, NULL, NULL, 'Read your mentee’s personal mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (975, 710, 11, 100, NULL, NULL, 'Respond to your mentee and comment on their personal mission statement. What resonates with you about your mentee and their statement?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (976, 711, 11, 100, NULL, NULL, 'Now write your own personal mission statement or share an existing personal statement you’ve already been using.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (180, 975, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (181, 976, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (185, 974, 179, TRUE, 100, 0);

--Staff Lesson 11.2.2

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (51, 1, '7/20/15 00:00:00', '7/20/15 23:59:59', 3, 7, 2, NULL, 'Making it Real: My Community');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (133, 1, 51, '7/20/15 00:00:00', '7/20/15 23:59:59', 'Making it Real: My Community');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (417, 133, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (418, 133, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (419, 133, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (420, 133, 2, 2, 3, 400, 'Determine the difference');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (421, 133, 2, 3, 3, 500, 'Map your community');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (712, 417, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (713, 417, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (714, 418, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (715, 419, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (716, 419, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (717, 419, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (718, 420, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (719, 420, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (720, 421, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (721, 421, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (977, 712, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages mentees in understanding the importance of networking, leveraging their existing community, and gives them explicit ways to begin the networking process now.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define and discuss the concept of being "asset-based"</li><li>Explore the process and purpose of community mapping</li><li>Create a community map</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/making-it-real-my-community" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (978, 713, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (979, 713, 6, 200, NULL, 'https://docs.google.com/presentation/d/167ki0107DHJvOpepifgmApL1iYN4RKzUu_TWKPpi-8Y/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (980, 714, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (981, 715, 11, 100, NULL, NULL, 'Read your mentor’s feedback on your mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (982, 716, 11, 100, NULL, NULL, 'Read your mentor’s personal mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (983, 717, 11, 100, NULL, NULL, 'Respond to your mentor and comment on their personal mission statement. What resonates with you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (984, 718, 9, 100, NULL, '/new_platform/static/canvas/images/cup-half-full.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (985, 718, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the image mean?</li><li>What is the difference between the two perspectives?</li><li>How can that difference show up in everyday life?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (986, 719, 9, 100, NULL, '/new_platform/static/canvas/images/tree-image-quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (987, 719, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the quote mean?</li><li>How does this quote apply to the people in the room?</li><li>What are the different items that compose your "roots"?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (988, 720, 11, 100, NULL, NULL, 'A community map lays out the assets or resources that you have access to in your community.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (989, 720, 9, 200, NULL, '/new_platform/static/canvas/images/Community_Mapping_Tool.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (990, 721, 11, 100, NULL, NULL, '<ul><li>What 2-3 assets from your community map do you want to describe to your mentor?</li><li>How are they assets? How have they influenced and shaped you?</li><li>What about your community inspires and motivates you?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (182, 983, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (183, 990, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (186, 981, 180, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (187, 982, 181, TRUE, 100, 0);

--Mentee Lesson 11.2.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (134, 5, 51, '7/20/15 00:00:00', '7/20/15 23:59:59', 'Making it Real: My Community');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (422, 134, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (423, 134, 2, 2, 3, 200, 'Determine the difference');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (424, 134, 2, 3, 3, 300, 'Map your community');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (722, 422, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (723, 422, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (724, 422, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (725, 423, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (726, 423, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (727, 424, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (728, 424, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (991, 722, 11, 100, NULL, NULL, 'Read your mentor’s feedback on your mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (992, 723, 11, 100, NULL, NULL, 'Read your mentor’s personal mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (993, 724, 11, 100, NULL, NULL, 'Respond to your mentor and comment on their personal mission statement. What resonates with you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (994, 725, 9, 100, NULL, '/new_platform/static/canvas/images/cup-half-full.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (995, 725, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the image mean?</li><li>What is the difference between the two perspectives?</li><li>How can that difference show up in everyday life?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (996, 726, 9, 100, NULL, '/new_platform/static/canvas/images/tree-image-quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (997, 726, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the quote mean?</li><li>How does this quote apply to the people in the room?</li><li>What are the different items that compose your "roots"?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (998, 727, 11, 100, NULL, NULL, 'A community map lays out the assets or resources that you have access to in your community.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (999, 727, 9, 200, NULL, '/new_platform/static/canvas/images/Community_Mapping_Tool.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1000, 728, 11, 100, NULL, NULL, '<ul><li>What 2-3 assets from your community map do you want to describe to your mentor?</li><li>How are they assets? How have they influenced and shaped you?</li><li>What about your community inspires and motivates you?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (184, 993, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (185, 1000, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (188, 991, 180, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (189, 992, 181, TRUE, 100, 0);

--Mentor Lesson 11.2.2

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (135, 4, 51, '7/20/15 00:00:00', '7/20/15 23:59:59', 'Making it Real: My Community');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (425, 135, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (426, 135, 2, 2, 2, 200, 'Map your community');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (729, 425, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (730, 425, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (731, 426, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (732, 426, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (733, 426, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1001, 729, 11, 100, NULL, NULL, 'Your mentee read your personal mission statement and provided the following response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1002, 730, 11, 100, NULL, NULL, 'Your mentee discussed the difference between an asset-based and deficit-based approach by discussing the following image in class.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1003, 730, 9, 200, NULL, '/new_platform/static/canvas/images/cup-half-full.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1004, 731, 11, 100, NULL, NULL, 'Your mentee identified 2-3 assets from their community that have influenced and shaped them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1005, 731, 9, 200, NULL, '/new_platform/static/canvas/images/Community_Mapping_Tool.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1006, 732, 11, 100, NULL, NULL, 'What questions do you have about the assets in your mentee’s community? What inspires you about your mentee’s community?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1007, 733, 11, 100, NULL, NULL, 'What asset from your community can you share with your mentee? How has it influenced or shaped you?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (186, 1006, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (187, 1007, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (190, 1001, 184, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (191, 1005, 185, TRUE, 100, 0);

--Staff Lesson 10.2.1

INSERT into canvas_unit_info (id, unit_number, description) VALUES (8, 2, 'Critical Thinking');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (52, 1, '7/21/15 00:00:00', '7/21/15 23:59:59', 2, 8, 1, NULL, 'What is Critical Thinking?');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (136, 1, 52, '7/21/15 00:00:00', '7/21/15 23:59:59', 'What is Critical Thinking?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (427, 136, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (428, 136, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (429, 136, 2, 1, 3, 300, 'Choose an item');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (430, 136, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (431, 136, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (734, 427, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (735, 427, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (736, 427, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (737, 428, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (738, 429, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (739, 429, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (740, 430, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (741, 431, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (742, 431, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1008, 734, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the concept of critical thinking and provides an opportunity for mentees to practice this skill through a variety of activities. This lesson will begin a multi-week unit that will require mentees, with help from their mentors, to learn and demonstrate each of the steps in the critical thinking process to a problem they identify on their own.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Synthesize and compare two ideas, then make a decision as a result of that process</li><li>Establish a working definition of critical thinking in their own words</li><li>Formulate examples of how to think critically about daily activities</li><li>Share their examples and definitions with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/what-is-critical-thinking" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1009, 735, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1010, 735, 6, 200, NULL, 'https://docs.google.com/presentation/d/1XPDYeSVMhDEO4RHYVxpZCKKHf1zfl-0TZaIF4pZZMV4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1011, 736, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1012, 736, 3, 200, NULL, 'https://vimeo.com/139626601', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1013, 737, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1014, 738, 11, 100, NULL, NULL, 'Choose one of the following items.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1015, 738, 9, 200, NULL, '/new_platform/static/canvas/images/Rock_Or_Feather.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1016, 739, 11, 100, NULL, NULL, 'Consider the following questions about the item that you chose:<ul><li>Why did you choose this item over the other?</li><li>Which specific characteristics do you share with the item you chose?</li><li>If you could choose another item that is somewhere in between the two items presented, what would it be and why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1017, 740, 11, 100, NULL, NULL, 'As you watch the video, think about what it means to think critically in your own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1018, 740, 3, 200, NULL, 'https://vimeo.com/139626601', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1019, 741, 11, 100, NULL, NULL, 'Share your own personal definition of critical thinking with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1020, 742, 11, 100, NULL, NULL, 'Choose one example from the list below and tell your mentor some of the critical thinking questions you would ask about that task.<ul><li>Buying a new item of clothing</li><li>Deciding what to eat for breakfast</li><li>Building a relationship with your mentor</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (188, 1019, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (189, 1020, 100, 0, 2);

--Mentee Lesson 10.2.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (137, 5, 52, '7/21/15 00:00:00', '7/21/15 23:59:59', 'What is Critical Thinking?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (432, 137, 2, 1, 3, 100, 'Choose an item');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (433, 137, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (434, 137, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (743, 432, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (744, 432, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (745, 433, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (746, 434, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (747, 434, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1021, 743, 11, 100, NULL, NULL, 'Choose one of the following items.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1022, 743, 9, 200, NULL, '/new_platform/static/canvas/images/Rock_Or_Feather.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1023, 744, 11, 100, NULL, NULL, 'Consider the following questions about the item that you chose:<ul><li>Why did you choose this item over the other?</li><li>Which specific characteristics do you share with the item you chose?</li><li>If you could choose another item that is somewhere in between the two items presented, what would it be and why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1024, 745, 11, 100, NULL, NULL, 'As you watch the video, think about what it means to think critically in your own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1025, 745, 3, 200, NULL, 'https://vimeo.com/139626601', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1026, 746, 11, 100, NULL, NULL, 'Share your own personal definition of critical thinking with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1027, 747, 11, 100, NULL, NULL, 'Choose one example from the list below and tell your mentor some of the critical thinking questions you would ask about that task.<ul><li>Buying a new item of clothing</li><li>Deciding what to eat for breakfast</li><li>Building a relationship with your mentor</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (190, 1026, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (191, 1027, 100, 0, 2);

--Mentor Lesson 10.2.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (138, 4, 52, '7/21/15 00:00:00', '7/21/15 23:59:59', 'What is Critical Thinking?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (435, 138, 2, 1, 2, 100, 'Define critical thinking');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (436, 138, 2, 2, 2, 200, 'Assess your thinking');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (748, 435, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (749, 435, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (750, 435, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (751, 436, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (752, 436, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1028, 748, 11, 100, NULL, NULL, 'Your mentee watched the following video about critical thinking:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1029, 748, 3, 200, NULL, 'https://vimeo.com/139626601', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1030, 749, 11, 100, NULL, NULL, 'Then they came up with a definition of critical thinking in their own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1031, 750, 11, 100, NULL, NULL, 'Build off of your mentee’s critical thinking definition to articulate the concept in your own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1032, 751, 11, 100, NULL, NULL, 'After defining critical thinking in their own words, your mentee came up with critical questions they would ask about an everyday task.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1033, 752, 11, 100, NULL, NULL, 'Now, choose your own example from the list below and tell your mentee some of the critical thinking questions you would ask about that task.<ul><li>Buying a new item of clothing</li><li>Deciding what to eat for breakfast</li><li>Building a relationship with your mentor</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (192, 1031, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (193, 1033, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (192, 1030, 190, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (193, 1032, 191, TRUE, 100, 0);