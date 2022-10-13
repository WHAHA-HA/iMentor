--Staff Lesson 12.1.3

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (25, 1, '6/24/15 00:00:00', '6/24/15 23:59:59', 4, 5, 3, NULL, 'Growth Mindset Revisited');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (55, 1, 25, '6/24/15 00:00:00', '6/24/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (163, 55, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (164, 55, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (165, 55, 2, 1, 2, 300, 'Self Assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (166, 55, 2, 2, 2, 400, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (262, 163, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (263, 163, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (264, 164, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (265, 165, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (266, 165, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (267, 165, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (268, 165, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (269, 165, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (270, 165, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (271, 165, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (272, 166, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (375, 262, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will revisit the difference between a growth and fixed mindset and apply that content as mentees reflect on their progress.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define and explain the characteristics of a fixed mindset</li><li>Define and explain the characteristics of a growth mindset</li><li>Describe how they intend to personally embody growth mindset over senior year</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/growth-mindset-revisited-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (376, 263, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (377, 263, 6, 200, NULL, 'https://docs.google.com/presentation/d/1LKoJhEaSUdV1CBCtXVnhZwJn00ftNS_x8QAd9Ah0eJw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (378, 264, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (379, 265, 11, 100, NULL, NULL, 'You will rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (380, 266, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (381, 267, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (382, 268, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (383, 269, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (384, 270, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (385, 271, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (386, 272, 11, 100, NULL, NULL, 'Read your mentor’s response.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (55, 380, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (56, 381, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (57, 382, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (58, 383, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (59, 384, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (60, 385, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (39, 386, 41, TRUE, 100, 0);

--Mentee Lesson 12.1.3

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (56, 5, 25, '6/24/15 00:00:00', '6/24/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (167, 56, 2, 1, 2, 100, 'Self Assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (168, 56, 2, 2, 2, 200, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (273, 167, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (274, 167, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (275, 167, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (276, 167, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (277, 167, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (278, 167, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (279, 167, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (280, 168, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (387, 273, 11, 100, NULL, NULL, 'You will rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (388, 274, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (389, 275, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (390, 276, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (391, 277, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (392, 278, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (393, 279, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (394, 280, 11, 100, NULL, NULL, 'Read your mentor’s response.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (61, 388, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (62, 389, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (63, 390, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (64, 391, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (65, 392, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (66, 393, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (40, 394, 41, TRUE, 100, 0);

--Mentor Lesson 12.1.3

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (57, 4, 25, '6/24/15 00:00:00', '6/24/15 23:59:59', 'Growth Mindset Revisited');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (169, 57, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (170, 57, 2, 2, 3, 200, 'Read and respond to your mentee’s assessment');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (171, 57, 2, 3, 3, 300, 'Growth mindset in your relationship');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (281, 169, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (282, 170, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (283, 170, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (284, 170, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (285, 170, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (286, 170, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (287, 170, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (288, 170, 700);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (289, 171, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (395, 281, 11, 100, NULL, NULL, 'Your mentee reflected on how they utilize a growth mindset. Want to learn more about what a growth mindset is and how to help your mentee utilize one? Click <a href="https://learn.imentor.org/help/article/link/how-to-develop-a-growth-mindset-voice" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (396, 282, 11, 100, NULL, NULL, 'Your mentee ranked themselves from 1-5 on the following statements. Read your mentee’s response and share your thoughts about their self-assessment.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (397, 283, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (398, 284, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (399, 285, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something hard it just means I haven’t learned it yet.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (400, 286, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (401, 287, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (402, 288, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (403, 289, 11, 100, NULL, NULL, 'Now that you’ve read and responded to your mentee’s self-assessment, share any other reflections you have on how growth mindset can help you and your mentee successfully navigate their senior year in high school.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (67, 397, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (68, 398, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (69, 399, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (70, 400, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (71, 401, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (72, 402, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (73, 403, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (41, 397, 61, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (42, 398, 62, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (43, 399, 63, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (44, 400, 64, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (45, 401, 65, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (46, 402, 66, TRUE, 100, 0);