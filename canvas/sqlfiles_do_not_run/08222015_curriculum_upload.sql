--Staff Lesson 9.1.3

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (14, 1, '6/13/15 00:00:00', '6/13/15 23:59:59', 1, 2, NULL, 'Survey');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (28, 1, 14, '6/13/15 00:00:00', '6/13/15 23:59:59', 'Survey');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (83, 28, 2, 1, 1, 100, 'Lesson Overview');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (133, 83, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (134, 83, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (203, 133, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will be introduced to the purpose and process of surveying in the program and complete their first program survey.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Learn and demonstrate their understanding of the purpose of using a pre-course survey to collect data</li><li>Complete matching applications</li><li>Complete pre-course survey</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-relationships-survey" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (204, 134, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (205, 134, 6, 200, NULL, 'https://docs.google.com/presentation/d/1e5-1s5VhC1wmK5uW1Ga_iwT-gO6euZDJJhK2AvNDN5s/embed', NULL, NULL);

--Staff Lesson 12.1.1

INSERT into canvas_unit_info (id, unit_number, description) VALUES (5, 1, 'Building Relationships and Finishing My College List');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, member_id, description) VALUES (15, 1, '6/14/15 00:00:00', '6/14/15 23:59:59', 4, 5, NULL, 'Refresh and Reconnect');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (29, 1, 15, '6/14/15 00:00:00', '6/14/15 23:59:59', 'Refresh and Reconnect');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (84, 29, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (85, 29, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (86, 29, 2, 1, 2, 300, 'Read the following quotes');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (87, 29, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (135, 84, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (136, 84, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (137, 84, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (138, 85, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (139, 86, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (140, 87, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (141, 87, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (206, 135, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In today''s lesson, mentees will refresh themselves on the goals of the program, reconnect with their mentors, and craft a mission statement for the year.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Recollect and restate the goals of the program</li><li>Reflect on their summer experiences</li><ul style="list-style-type: circle"><li>Process and revise those experiences through peer feedback</li><li>Share experiences with their mentor</li></ul><li>Analyze quotes from different graduation speakers</li><li>Develop their own quotes to be shared with their peers at graduation</li><ul style="list-style-type: circle"><li>Share quote with mentors</li></ul></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-relationships-refresh-and-reconnect-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (207, 136, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/check.png" style="float:right;" />Play the following graduation song as mentees arrive to class. The recognizable graduation march starts one minute into the song.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (208, 136, 14, 200, NULL, 'https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/60352387&amp;color=00aabb&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (209, 137, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (210, 137, 6, 200, NULL, 'https://docs.google.com/presentation/d/1_01RVSlThl0Nocv57uzcNds8moGeBs8-XXgzhlx57EA/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (211, 138, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (212, 139, 9, 100, NULL, '/new_platform/static/canvas/images/Graduation_Quotes.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (213, 139, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What do you think each of the quotes mean?</li><li>How can you apply these quotes to your senior year in high school?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (214, 140, 11, 100, NULL, NULL, '<ul><li>Create your own quote about graduation to share with your mentor.</li><li>Explain why you wrote or chose that quote and why its message is important to you.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (215, 141, 11, 100, NULL, NULL, '<ul><li>Share your summer highlights with your mentor.</li><li>Ask your mentor three questions about his or her summer.</li><li>Share what you are most looking forward to this year.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (27, 214, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (28, 215, 100, 0, 2);

--Mentee Lesson 12.1.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (30, 5, 15, '6/14/15 00:00:00', '6/14/15 23:59:59', 'Refresh and Reconnect');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (88, 30, 2, 1, 2, 100, 'Read the following quotes');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (89, 30, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (142, 88, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (143, 89, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (144, 89, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (216, 142, 9, 100, NULL, '/new_platform/static/canvas/images/Graduation_Quotes.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (217, 142, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What do you think each of the quotes mean?</li><li>How can you apply these quotes to your senior year in high school?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (218, 143, 11, 100, NULL, NULL, '<ul><li>Create your own quote about graduation to share with your mentor.</li><li>Explain why you wrote or chose that quote and why its message is important to you.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (219, 144, 11, 100, NULL, NULL, '<ul><li>Share your summer highlights with your mentor.</li><li>Ask your mentor three questions about his or her summer.</li><li>Share what you are most looking forward to this year.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (29, 218, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (30, 219, 100, 0, 2);

--Mentor Lesson 12.1.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (31, 4, 15, '6/14/15 00:00:00', '6/14/15 23:59:59', 'Refresh and Reconnect');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (90, 31, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (91, 31, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (145, 90, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (146, 91, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (147, 91, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (148, 91, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (149, 91, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (220, 145, 9, 100, NULL, '/new_platform/static/canvas/images/Graduation_Quotes.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (221, 145, 11, 200, NULL, NULL, 'After reading the above quotes, your mentee considered the following questions:<ul><li>What do you think each of the quotes mean?</li><li>How can you apply these quotes to your senior year in high school?</li></ul><p><p>Then they created their own graduation quotes.</p></p>Next, the class reflected on their summer experiences.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (222, 146, 11, 100, NULL, NULL, 'Read your mentee’s quote and why they chose to share that quote with you. ', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (223, 147, 11, 100, NULL, NULL, '<ul><li>Respond by sharing what that quote means to you.</li><li>Come up with your own quote or share one that resonates with you.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (224, 148, 11, 100, NULL, NULL, 'Your mentee practiced asking clarifying questions by sharing their summer experiences with peers. They then shared those experiences with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (225, 149, 11, 100, NULL, NULL, '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share you what are most looking forward to this year.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (31, 223, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (32, 225, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (12, 222, 29, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (13, 224, 30, TRUE, 100, 0);