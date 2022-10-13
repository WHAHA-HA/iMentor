--College Unit 1 Reflection

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (16, 5, 6, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li></ul>');

--12.4 Unit Icon Update

UPDATE canvas_unit_info SET unit_number = 4, description = 'Completing My Applications', featured_image = 'Completing_My_Applications', secondary_description = 'When are my applications due?<p>What do I need to complete them?</p>' WHERE id = 15;

--12.3.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (16, 3, 'Understanding the College Application', 'Understanding_College_Applications', 'What are the components of my college application?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (15, 4, 16, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How can you improve through the rest of the college application process?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How can you improve through the rest of the college application process?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (63, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 16, 1, NULL, 'Breaking Down the College Application', '/new_platform/static/canvas/images/12.3.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (169, 1, 63, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Breaking Down the College Application');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (536, 169, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (537, 169, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (538, 169, 2, 1, 3, 300, 'Complete the chart');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (539, 169, 2, 2, 3, 400, 'Review the Common Application');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (540, 169, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (925, 536, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (926, 536, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (927, 537, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (928, 538, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (929, 539, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (930, 540, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (931, 540, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (932, 540, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1242, 925, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to help mentees understand 1) the components of a college application and 2) how activities and decisions made in high school can impact the overall strength of their applications.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Complete a KWL chart about the college application and its different sections</li><li>Review the Common Application</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/breaking-down-college-application" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1243, 926, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1244, 926, 6, 200, NULL, 'https://docs.google.com/presentation/d/1p0M0q70qxJLfW7WqDmx99SpiVC1gN7xtTYdnup_rvnU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1245, 927, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1246, 928, 11, 100, NULL, NULL, 'A “KWL” chart includes 3 sections:<ul><li>“K” (Know): everything you already know</li><li>“W” (Want): everything you want to know</li><li>“L” (Learned): everything you learned during class</li></ul><p><p>Complete the first two columns of the “KWL” chart below about the college application and its components.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1247, 928, 6, 200, NULL, 'https://docs.google.com/document/d/1U9MZ96bIh_aHammMxcDqaCEhD4blET0m484BCDkEJRU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1248, 929, 11, 100, NULL, NULL, 'Review the Common Application by clicking <a href="https://drive.google.com/file/d/0B-7uUglJA5seQk1jWHc4N1VrLUU/view?usp=sharing" target="_blank">here</a>.<p><p>After you review, consider the following.<ul><li>What questions from the “W” section of your “KWL” chart can you answer? Add them into the “L” section of your “KWL” chart above.</li><li>Where are your areas of strength in this application?</li><li>Where are your areas of growth in this application?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1249, 930, 11, 100, NULL, NULL, 'What did you learn about the college application today? What questions do you still have about the college application that didn’t get answered today?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1250, 931, 11, 100, NULL, NULL, 'What are your areas of strength in the college application? What are your areas of growth in the college application? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1251, 932, 11, 100, NULL, NULL, 'Between now and when your applications are due, what can you do to improve in your areas of growth?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (253, 1249, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (254, 1250, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (255, 1251, 100, 0, 2);

--12.3.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (170, 5, 63, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Breaking Down the College Application');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (541, 170, 2, 1, 3, 100, 'Complete the chart');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (542, 170, 2, 2, 3, 200, 'Review the Common Application');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (543, 170, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (933, 541, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (934, 542, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (935, 543, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (936, 543, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (937, 543, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1252, 933, 11, 100, NULL, NULL, 'A “KWL” chart includes 3 sections:<ul><li>“K” (Know): everything you already know</li><li>“W” (Want): everything you want to know</li><li>“L” (Learned): everything you learned during class</li></ul><p><p>Complete the first two columns of the “KWL” chart below about the college application and its components.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1253, 933, 6, 200, NULL, 'https://docs.google.com/document/d/1U9MZ96bIh_aHammMxcDqaCEhD4blET0m484BCDkEJRU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1254, 934, 11, 100, NULL, NULL, 'Review the Common Application by clicking <a href="https://drive.google.com/file/d/0B-7uUglJA5seQk1jWHc4N1VrLUU/view?usp=sharing" target="_blank">here</a>.<p><p>After you review, consider the following.<ul><li>What questions from the “W” section of your “KWL” chart can you answer? Add them into the “L” section of your “KWL” chart above.</li><li>Where are your areas of strength in this application?</li><li>Where are your areas of growth in this application?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1255, 935, 11, 100, NULL, NULL, 'What did you learn about the college application today? What questions do you still have about the college application that didn’t get answered today?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1256, 936, 11, 100, NULL, NULL, 'What are your areas of strength in the college application? What are your areas of growth in the college application? Why?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1257, 937, 11, 100, NULL, NULL, 'Between now and when your applications are due, what can you do to improve in your areas of growth?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (256, 1255, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (257, 1256, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (258, 1257, 100, 0, 2);

--12.3.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (171, 4, 63, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Breaking Down the College Application');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (544, 171, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (545, 171, 2, 2, 2, 200, 'Discuss your personal essay');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (938, 544, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (939, 544, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (940, 544, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (941, 544, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (942, 544, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (943, 545, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1258, 938, 11, 100, NULL, NULL, 'Your mentee completed a “KWL” chart about the college application and its components. A “KWL” chart includes 3 sections:<ul><li>“K” (Know): everything they already know</li><li>“W” (Want): everything they want to know</li><li>“L” (Learned): everything they learned during class</li></ul><p><p>You can review your mentee’s KWL chart below:</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1259, 938, 6, 200, NULL, 'https://docs.google.com/document/d/1U9MZ96bIh_aHammMxcDqaCEhD4blET0m484BCDkEJRU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1260, 939, 11, 100, NULL, NULL, 'Your mentee reviewed a college application during class and wrote the following reflection about what they learned and what questions they still have.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1261, 940, 11, 100, NULL, NULL, 'Answer your mentee’s remaining questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1262, 941, 11, 100, NULL, NULL, 'Finally, your mentee reflected on their areas of strength and growth in the college application, and thought about how they can improve on their areas of growth before their applications are due.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1263, 942, 11, 100, NULL, NULL, 'Answer the following questions about your mentee’s reflection.<ul><li>Do you agree with your mentee’s self-identified areas of strength and growth?</li><li>What other areas of strength do you see in your mentee?</li><li>What else can your mentee do to improve in their areas of growth?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1264, 943, 11, 100, NULL, NULL, 'Next week, your mentee will review strategies for writing a strong personal essay. Answer the following to prepare your mentee for class.<ul><li>What did you write about in your personal essay? Why did you select that topic?</li><li>What tips do you have for your mentee in writing a personal essay?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (259, 1261, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (260, 1263, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (261, 1264, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (261, 1260, 256, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (262, 1262, 257, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (263, 1262, 258, TRUE, 200, 0);

--11.3.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (64, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 7, 3, NULL, 'Growth Mindset', '/new_platform/static/canvas/images/11.3.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (172, 1, 64, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (546, 172, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (547, 172, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (548, 172, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (549, 172, 2, 2, 3, 400, 'Define a growth and fixed mindset');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (550, 172, 2, 3, 3, 500, 'Assess yourself');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (944, 546, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (945, 546, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (946, 547, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (947, 548, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (948, 548, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (949, 548, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (950, 549, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (951, 549, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (952, 550, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (953, 550, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (954, 550, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (955, 550, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (956, 550, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (957, 550, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (958, 550, 700);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1265, 944, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees understand growth mindset and differentiate it from a fixed mindset.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Deconstruct a visual representation of growth vs. fixed mindsets</li><li>Define growth and fixed mindsets in their own words</li><li>Discuss and complete a growth mindset self-assessment</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/growth-mindset-11" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1266, 945, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1267, 945, 6, 200, NULL, 'https://docs.google.com/presentation/d/1bUdkr_42Qy5_5n7WoiTucYHyxMOcd3RbSIyyOezpTQM/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1268, 946, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1269, 947, 11, 100, NULL, NULL, 'Your mentor wrote you about the assets in your community and answered your questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1270, 948, 11, 100, NULL, NULL, 'Your mentor shared with you the assets in their community that have influenced and shaped them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1271, 949, 11, 100, NULL, NULL, '<ul><li>Answer your mentor’s questions about your community.</li><li>Share your thoughts about the assets in your mentor’s community.</li><li>What inspires you about your mentor’s community?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1272, 950, 11, 100, NULL, NULL, 'Use the following infographic to understand the difference between a growth and fixed mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1273, 950, 9, 200, NULL, '/new_platform/static/canvas/images/Growth-vs-Fixed-Mindset-Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1274, 951, 11, 100, NULL, NULL, 'Consider the following.<ul><li>Summarize growth and fixed mindset in your own words</li><li>Think of an example of a growth and fixed mindset from your first two years in high school</li><li>Predict a time when using a growth mindset will be important in the remaining two years of high school</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1275, 952, 11, 100, NULL, NULL, 'Rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1276, 953, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1277, 954, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1278, 955, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1279, 956, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1280, 957, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.</p></p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1281, 958, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (262, 1271, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (263, 1276, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (264, 1277, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (265, 1278, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (266, 1279, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (267, 1280, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (268, 1281, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (264, 1269, 186, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (265, 1270, 187, TRUE, 100, 0);

--11.3.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (173, 5, 64, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (551, 173, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (552, 173, 2, 2, 3, 200, 'Define a growth and fixed mindset');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (553, 173, 2, 3, 3, 300, 'Assess yourself');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (959, 551, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (960, 551, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (961, 551, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (962, 552, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (963, 552, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (964, 553, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (965, 553, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (966, 553, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (967, 553, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (968, 553, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (969, 553, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (970, 553, 700);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1282, 959, 11, 100, NULL, NULL, 'Your mentor wrote you about the assets in your community and answered your questions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1283, 960, 11, 100, NULL, NULL, 'Your mentor shared with you the assets in their community that have influenced and shaped them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1284, 961, 11, 100, NULL, NULL, '<ul><li>Answer your mentor’s questions about your community.</li><li>Share your thoughts about the assets in your mentor’s community.</li><li>What inspires you about your mentor’s community?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1285, 962, 11, 100, NULL, NULL, 'Use the following infographic to understand the difference between a growth and fixed mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1286, 962, 9, 200, NULL, '/new_platform/static/canvas/images/Growth-vs-Fixed-Mindset-Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1287, 963, 11, 100, NULL, NULL, 'Consider the following.<ul><li>Summarize growth and fixed mindset in your own words</li><li>Think of an example of a growth and fixed mindset from your first two years in high school</li><li>Predict a time when using a growth mindset will be important in the remaining two years of high school</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1288, 964, 11, 100, NULL, NULL, 'Rate yourself on the following statements from 1-5 and then explain your rating.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1289, 965, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1290, 966, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1291, 967, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1292, 968, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1293, 969, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.</p></p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1294, 970, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.<p><p><i>Remember to first give yourself a rating from 1-5 using the above scale and then explain your answer.</i></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (269, 1284, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (270, 1289, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (271, 1290, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (272, 1291, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (273, 1292, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (274, 1293, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (275, 1294, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (266, 1282, 186, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (267, 1283, 187, TRUE, 100, 0);

--11.3.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (174, 4, 64, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (554, 174, 2, 1, 3, 100, 'Read your mentee’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (555, 174, 2, 2, 3, 200, 'Define a growth and fixed mindset');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (556, 174, 2, 3, 3, 300, 'Read your mentee’s assessment');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (971, 554, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (972, 555, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (973, 555, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (974, 556, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (975, 556, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (976, 556, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (977, 556, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (978, 556, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (979, 556, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (980, 556, 700);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1295, 971, 11, 100, NULL, NULL, 'Your mentee answered your questions and shared their reflections on the assets in your community.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1296, 972, 11, 100, NULL, NULL, 'Your mentee used the following infographic to understand the difference between a growth and fixed mindset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1297, 972, 9, 200, NULL, '/new_platform/static/canvas/images/Growth-vs-Fixed-Mindset-Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1298, 973, 11, 100, NULL, NULL, 'They discussed these questions in class:<ul><li>Summarize growth and fixed mindset in your own words</li><li>Think of an example of a growth and fixed mindset from your first two years in high school</li><li>Predict a time when using a growth mindset will be important in the remaining two years of high school</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1299, 974, 11, 100, NULL, NULL, 'Your mentee ranked themselves from 1-5 on the following statements. Read your mentee’s response and share your thoughts about their self-assessment.<ul><li>1 = never</li><li>2 = rarely</li><li>3 = sometimes</li><li>4 = often</li><li>5 = always</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1300, 975, 11, 100, NULL, NULL, 'When someone gives me feedback on how to improve I will listen and try to take their feedback. I won’t shut down. I won’t give up. Feedback is a chance to get smarter. Feedback doesn’t mean I’m not smart.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1301, 976, 11, 100, NULL, NULL, 'If I make a mistake I won’t get upset or stop trying. I will see my mistake as a chance to learn and get better. I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1302, 977, 11, 100, NULL, NULL, 'If something is hard I won’t give up. I will keep trying and I will keep looking for answers. I won’t stop in frustration. If something is hard it just means I haven’t learned it yet.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1303, 978, 11, 100, NULL, NULL, 'I know practice helps me get better so I will practice every chance I get. This means I will do all my homework (homework is practice). I will do all my work in class and activities after school. I will even do more work to help me practice if I need to.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1304, 979, 11, 100, NULL, NULL, 'When a new challenge comes along I will take a risk to try it. I won’t be afraid to fail. I will not be afraid to take a risk. If I don’t succeed the first time I’ll keep trying.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1305, 980, 11, 100, NULL, NULL, 'When I don’t know something I will ask for help. Asking for help doesn’t mean I’m not smart, it means I want to learn. When I ask for help I learn more and get smarter.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (268, 1295, 269, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (269, 1300, 270, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (270, 1301, 271, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (271, 1302, 272, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (272, 1303, 273, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (273, 1304, 274, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (274, 1305, 275, TRUE, 100, 0);