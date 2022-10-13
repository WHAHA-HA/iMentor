--10.6.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (14, 6, 'Career Exploration', '/new_platform/static/canvas/images/career_exploration_2_grey.png', 'If I could do anything, what would it be?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (13, 2, 14, '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>', '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (60, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 14, 1, NULL, 'What’s My Why?', '/new_platform/static/canvas/images/10.6.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (160, 1, 60, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What’s My Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (508, 160, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (509, 160, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (510, 160, 2, 1, 3, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (511, 160, 2, 2, 3, 400, 'What is a “why”?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (512, 160, 2, 3, 3, 500, 'What’s your “why”?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (872, 508, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (873, 508, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (874, 508, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (875, 509, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (876, 510, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (877, 510, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (878, 511, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (879, 512, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (880, 512, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (881, 512, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1177, 872, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the importance of "starting with your why". As mentees consider various career and education opportunities, staying anchored to what is most important to them will help them navigate through a long and often times challenging process.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Articulate the value of motivation when working towards their goals</li><li>Identify the specific factors that motivate them as individuals</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-whats-my-why" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1178, 873, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1179, 873, 6, 200, NULL, 'https://docs.google.com/presentation/d/1EV0OOP-GkxFnPmAdWOwfM6A2T0_erptm4iH9qOinVlA/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1180, 874, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1181, 874, 3, 200, NULL, 'https://vimeo.com/141054078', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1182, 875, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1183, 876, 9, 100, NULL, '/new_platform/static/canvas/images/why-for-canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1184, 877, 11, 100, NULL, NULL, 'Consider the following as you watch the video:<ul><li>What is Kevin Durant''s "why"?</li><li>What role does his "why" serve when he''s on the court? Why is this important?</li><li>How would you explain having a "why" in your own words?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1185, 877, 3, 200, NULL, 'https://vimeo.com/141054078', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1186, 878, 11, 100, NULL, NULL, 'How would you explain having a "why" in your own words?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1187, 879, 11, 100, NULL, NULL, 'What is the one thing you want to achieve in life? What is your "why" behind it?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1188, 880, 11, 100, NULL, NULL, 'How does this "why" affect how you will achieve this goal? How would it look different if you didn''t have this why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1189, 881, 11, 100, NULL, NULL, 'What questions do you have about your mentor''s "why"?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (235, 1186, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (236, 1187, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (237, 1188, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (238, 1189, 100, 0, 2);

--10.6.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (161, 5, 60, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What’s My Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (513, 161, 2, 1, 3, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (514, 161, 2, 2, 3, 200, 'What is a “why”?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (515, 161, 2, 3, 3, 300, 'What’s your “why”?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (882, 513, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (883, 513, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (884, 514, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (885, 515, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (886, 515, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (887, 515, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1190, 882, 9, 100, NULL, '/new_platform/static/canvas/images/why-for-canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1191, 883, 11, 100, NULL, NULL, 'Consider the following as you watch the video:<ul><li>What is Kevin Durant''s "why"?</li><li>What role does his "why" serve when he''s on the court? Why is this important?</li><li>How would you explain having a "why" in your own words?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1192, 883, 3, 200, NULL, 'https://vimeo.com/141054078', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1193, 884, 11, 100, NULL, NULL, 'How would you explain having a "why" in your own words?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1194, 885, 11, 100, NULL, NULL, 'What is the one thing you want to achieve in life? What is your "why" behind it?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1195, 886, 11, 100, NULL, NULL, 'How does this "why" affect how you will achieve this goal? How would it look different if you didn''t have this why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1196, 887, 11, 100, NULL, NULL, 'What questions do you have about your mentor''s "why"?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (239, 1193, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (240, 1194, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (241, 1195, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (242, 1196, 100, 0, 2);

--10.6.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (162, 4, 60, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What’s My Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (516, 162, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (517, 162, 2, 2, 2, 200, 'What’s your “why”?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (888, 516, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (889, 516, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (890, 516, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (891, 516, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (892, 516, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (893, 516, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (894, 516, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (895, 517, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (896, 517, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1197, 888, 9, 100, NULL, '/new_platform/static/canvas/images/why-for-canvas.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1198, 889, 11, 100, NULL, NULL, 'Your mentee watched the following video about finding their “why,” and discussed the following questions in class:<ul><li>What is Kevin Durant''s "why"?</li><li>What role does his "why" serve when he''s on the court? Why is this important?</li><li>How would you explain having a "why" in your own words?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1199, 889, 3, 200, NULL, 'https://vimeo.com/141054078', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1200, 890, 11, 100, NULL, NULL, 'Then, they created their own personal definition of what having a “why” means.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1201, 891, 11, 100, NULL, NULL, 'Then, they reflected on the ONE thing they want to achieve most in their lives, and discussed the following questions in class:<ul><li>Why is this thing important to you? What is your "why" behind it?</li><li>What would achieving it mean?</li><li>Could you achieve it without feeling passionate or motivated about it? What would that look like?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1202, 892, 11, 100, NULL, NULL, 'Last, your mentee independently responded to the following questions:<p><p>What is the one thing you want to achieve in life? What is your "why" behind it?</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1203, 893, 11, 100, NULL, NULL, 'How does this "why" affect how you will achieve this goal? How would it look different if you didn''t have this why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1204, 894, 11, 100, NULL, NULL, 'What questions do you have about your mentor''s "why"?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1205, 895, 11, 100, NULL, NULL, 'Respond to your mentee’s goal and their “why” behind it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1206, 896, 11, 100, NULL, NULL, '<ul><li>Respond to your mentee’s questions about your why.</li><li>What is one thing in your life that is very important to you? What is the "why" behind it?</li><li>How has this "why" affected your life beyond this particular goal/activity?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (243, 1205, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (244, 1206, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (250, 1200, 239, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (251, 1202, 240, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (252, 1203, 241, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (253, 1204, 242, TRUE, 100, 0);

--12.4.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (15, 4, 'Completing My Applications', '/new_platform/static/canvas/images/completing_my_applications_grey.png', 'When are my applications due?<p>What do I need to complete them?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (14, 4, 15, '<ul><li>Did you meet your goals in this unit? Why or why not?</li><li>What can you have done differently to improve?</li></ul>', '<ul><li>Did you meet your goals in this unit? Why or why not?</li><li>What can you have done differently to improve?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (61, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 15, 1, NULL, 'Starting My Applications', '/new_platform/static/canvas/images/12.4.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (163, 1, 61, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (518, 163, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (519, 163, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (520, 163, 2, 1, 2, 300, 'Starting my applications');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (521, 163, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (897, 518, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (898, 518, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (899, 519, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (900, 520, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (901, 520, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (902, 521, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1207, 897, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will walk mentees through the application they intend to start first, giving them the opportunity to begin filling out the application, using their peers as resources, and asking questions of their staff.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review the overall application and all of its components</li><li>Identify the information, resources, and people needed to successfully complete the application</li><li>Begin filling out the application</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/starting-my-applications" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1208, 898, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1209, 898, 6, 200, NULL, 'https://docs.google.com/presentation/d/1VKKXA2TgxucXSKLeZf0cmicAdukzLdQCjtb6LiYitek/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1210, 899, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1211, 900, 11, 100, NULL, NULL, 'The Common Application allows you to apply to over 600 colleges with one application. If you plan on using the Common App, create an account <a href="https://apply.commonapp.org/createaccount" target="_blank">here</a>.<p><p>If you are applying to colleges through another website, create your account(s) now.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1212, 901, 11, 100, NULL, NULL, 'Log into your account and begin your application.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1213, 902, 11, 100, NULL, NULL, '<ul><li>How confident am I in completing my applications, and on time?</li><li>What challenges do I expect to encounter?</li><li>What can my mentor do to help me in this process?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (245, 1213, 100, 0, 2);

--12.4.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (164, 5, 61, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (522, 164, 2, 1, 2, 100, 'Starting my applications');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (523, 164, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (903, 522, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (904, 522, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (905, 523, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1214, 903, 11, 100, NULL, NULL, 'The Common Application allows you to apply to over 600 colleges with one application. If you plan on using the Common App, create an account <a href="https://apply.commonapp.org/createaccount" target="_blank">here</a>.<p><p>If you are applying to colleges through another website, create your account(s) now.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1215, 904, 11, 100, NULL, NULL, 'Log into your account and begin your application.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1216, 905, 11, 100, NULL, NULL, '<ul><li>How confident am I in completing my applications, and on time?</li><li>What challenges do I expect to encounter?</li><li>What can my mentor do to help me in this process?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (246, 1216, 100, 0, 2);

--12.4.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (165, 4, 61, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Starting My Applications');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (524, 165, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (525, 165, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (906, 524, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (907, 524, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (908, 525, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1217, 906, 11, 100, NULL, NULL, 'Your mentee created an online account to start their college application(s).<p><p>They may have used the <a href="https://www.commonapp.org/" target="_blank">Common Application</a>, which allows them to apply to over 600 schools through one application, or they may have used a different application for a specific college or set of colleges.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1218, 907, 11, 100, NULL, NULL, 'Then, your mentee answered the following reflection questions about the process:<ul><li>How confident am I in completing my applications, and on time?</li><li>What challenges do I expect to encounter?</li><li>What can my mentor do to help me in this process?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1219, 908, 11, 100, NULL, NULL, 'Read your mentee’s message. Respond to your mentee and answer the following questions:<ul><li>How will you support your mentee in the area(s) they identified as needing your help?</li><li>What advice do you have for your mentee considering the challenges and confidence level they have expressed?</li><li>What was this process like for you when you were applying to colleges? What about your own experience can you share with your mentee?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (247, 1219, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (254, 1218, 246, TRUE, 100, 0);

--10.3.2 Staff Lesson

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (12, 2, 8, '<ul><li>What did you learn about critical thinking?</li><li>What did you learn about yourself?</li><li>What did you learn about your mentee/mentor?</li></ul>', '<ul><li>What did you learn about critical thinking?</li><li>What did you learn about yourself?</li><li>What did you learn about your mentee/mentor?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (62, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 2, NULL, 'Identify the Problem', '/new_platform/static/canvas/images/10.3.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (166, 1, 62, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Identify the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (526, 166, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (527, 166, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (528, 166, 2, 1, 3, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (529, 166, 2, 2, 3, 400, 'Think critically');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (530, 166, 2, 3, 3, 500, 'Create a problem statement');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (909, 526, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (910, 526, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (911, 527, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (912, 528, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (913, 529, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (914, 530, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (915, 530, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (916, 530, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1220, 909, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees learn how to identify a problem and then articulate it in the form of a problem statement. Mentees will apply this step of the process to the problem that they will be exploring over the next several weeks.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify the components of a problem statement</li><li>Practice identifying problem statements</li><li>Choose a problem to investigate over the next several weeks</li><li>Articulate a problem statement for the problem selected and share it with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/identify-the-problem" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1221, 910, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1222, 910, 6, 200, NULL, 'https://docs.google.com/presentation/d/1XZrT0oIKXyMZSJp_IRkWSTNzmzaAfyPZY0AIOEkKWJs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1223, 911, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1224, 912, 11, 100, NULL, NULL, 'Read your mentor’s critical thinking definition and example.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1225, 913, 11, 100, NULL, NULL, 'Consider the following as you look at the photos below:<ul><li>What is happening in this picture?</li><li>What do you see that makes you say that?</li><li>What else can you find?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1226, 913, 6, 200, NULL, 'https://docs.google.com/presentation/d/1w5WAqYkqy9L9ds0LQIhmktEIxXRlgLSmqzZhRcD7Lkw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1227, 914, 11, 100, NULL, NULL, 'Click through the following slideshow and select a problem that you’re interested in investigating over the next few weeks.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1228, 914, 6, 200, NULL, 'https://docs.google.com/presentation/d/1lviXuaOi_P8LmqwYJBU-W0wsy811WnGq49pVUHsQUnk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1229, 915, 11, 100, NULL, NULL, 'A problem statement addresses three main questions:<ul><li>What is the problem?</li><li>Who does it affect?</li><li>What happens if this problem is not solved?</li></ul><p><p>Create a problem statement about the issue that you have chosen, and share it with your mentor.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1230, 916, 11, 100, NULL, NULL, 'Tell your mentor why you chose this problem.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (248, 1229, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (249, 1230, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (255, 1224, 192, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (256, 1224, 193, TRUE, 200, 0);

--10.3.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (167, 5, 62, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Identify the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (531, 167, 2, 1, 3, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (532, 167, 2, 2, 3, 200, 'Think critically');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (533, 167, 2, 3, 3, 300, 'Create a problem statement');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (917, 531, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (918, 532, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (919, 533, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (920, 533, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (921, 533, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1231, 917, 11, 100, NULL, NULL, 'Read your mentor’s critical thinking definition and example.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1232, 918, 11, 100, NULL, NULL, 'Consider the following as you look at the photos below:<ul><li>What is happening in this picture?</li><li>What do you see that makes you say that?</li><li>What else can you find?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1233, 918, 6, 200, NULL, 'https://docs.google.com/presentation/d/1w5WAqYkqy9L9ds0LQIhmktEIxXRlgLSmqzZhRcD7Lkw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1234, 919, 11, 100, NULL, NULL, 'Click through the following slideshow and select a problem that you’re interested in investigating over the next few weeks.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1235, 919, 6, 200, NULL, 'https://docs.google.com/presentation/d/1lviXuaOi_P8LmqwYJBU-W0wsy811WnGq49pVUHsQUnk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1236, 920, 11, 100, NULL, NULL, 'A problem statement addresses three main questions:<ul><li>What is the problem?</li><li>Who does it affect?</li><li>What happens if this problem is not solved?</li></ul><p><p>Create a problem statement about the issue that you have chosen, and share it with your mentor.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1237, 921, 11, 100, NULL, NULL, 'Tell your mentor why you chose this problem.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (250, 1236, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (251, 1237, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (257, 1231, 192, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (258, 1231, 193, TRUE, 200, 0);

--10.3.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (168, 4, 62, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Identify the Problem');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (534, 168, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (535, 168, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (922, 534, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (923, 534, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (924, 535, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1238, 922, 11, 100, NULL, NULL, 'Using their critical thinking skills, your mentee answered the following questions about the images below.<ul><li>What is happening in this picture?</li><li>What do you see that makes you say that?</li><li>What else can you find?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1239, 922, 6, 200, NULL, 'https://docs.google.com/presentation/d/1w5WAqYkqy9L9ds0LQIhmktEIxXRlgLSmqzZhRcD7Lkw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1240, 923, 11, 100, NULL, NULL, 'Over the next few weeks, you and your mentee will be digging into a problem together.<p><p>In class, your mentee chose an issue they are interested in investigating and drafted a problem statement around it.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1241, 924, 11, 100, NULL, NULL, 'Give your mentee feedback on their problem statement. Keep in mind the three components of a problem statement as you review your mentee’s:<ul><li>What is the problem?</li><li>Who does it affect?</li><li>What happens if this problem is not solved?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (252, 1241, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (259, 1240, 250, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (260, 1240, 251, TRUE, 200, 0);