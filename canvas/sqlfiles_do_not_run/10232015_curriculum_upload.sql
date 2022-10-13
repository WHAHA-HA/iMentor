--9.3.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (17, 3, 'Growth Mindset', 'Growth_Mindset', 'What is a growth mindset?<p>How will it help me learn?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (17, 1, 17, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (65, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 17, 1, NULL, 'Growth Mindset', '/new_platform/static/canvas/images/9.3.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (175, 1, 65, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (557, 175, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (558, 175, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (559, 175, 2, 1, 3, 300, 'Learn about Growth Mindset');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (560, 175, 2, 2, 3, 400, 'Apply the definition');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (561, 175, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (981, 557, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (982, 557, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (983, 558, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (984, 559, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (985, 559, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (986, 560, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (987, 560, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (988, 561, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (989, 561, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1306, 981, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces pairs to the concepts of growth mindset and fixed mindset and how both affect learning.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define growth mindset and fixed mindset in their own words</li><li>Choose a person they consider successful and analyze how this person demonstrates a growth mindset</li><li>Consider how a growth mindset and fixed mindset relate differently to success</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-growth-mindset" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1307, 982, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1308, 982, 6, 200, NULL, 'https://docs.google.com/presentation/d/1FyI8Q7aszgw29TdyIU5-ZOqwg6puO6X-oj2Qu65xBCE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1309, 983, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1310, 984, 11, 100, NULL, NULL, 'Click through the slides below to learn about the differences between a “growth mindset” and a “fixed mindset”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1311, 984, 6, 200, NULL, 'https://docs.google.com/presentation/d/10uyrdbnrnF6h1-ZxbmOjzsrcH1TvDZHkR3pZqd_OHbE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1312, 985, 11, 100, NULL, NULL, 'Click through the slides below to learn about LeBron James and his pathway to success. As you read, consider:<ul><li>How does LeBron James demonstrate a growth mindset?</li><li>If LeBron James had used a fixed mindset, how might his story be different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1313, 985, 6, 200, NULL, 'https://docs.google.com/presentation/d/1QHBKMrjBy-GNnO-IKhTd8HeZBhJ_KIhv8I1733HeTMc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1314, 986, 11, 100, NULL, NULL, 'Think about someone you consider successful. Describe the person you chose and why you consider them successful.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1315, 987, 11, 100, NULL, NULL, 'Describe this person’s pathway to success. If you’re not sure, here are some questions you can research.<ul><li>What skills help this person succeed?</li><li>When did this person first learn these skills? How often have they practiced them?</li><li>Who helped this person succeed? How?</li><li>What challenges or setbacks did this person face? How did they respond?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1316, 988, 11, 100, NULL, NULL, 'Define “growth mindset” and “fixed mindset” in your own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1317, 989, 11, 100, NULL, NULL, 'Do you live by a growth mindset? If so, how? If not, how might your story be different if you did?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (276, 1314, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (277, 1315, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (278, 1316, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (279, 1317, 100, 0, 2);

--9.3.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (176, 5, 65, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (562, 176, 2, 1, 3, 100, 'Learn about Growth Mindset');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (563, 176, 2, 2, 3, 200, 'Apply the definition');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (564, 176, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (990, 562, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (991, 562, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (992, 563, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (993, 563, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (994, 564, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (995, 564, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1318, 990, 11, 100, NULL, NULL, 'Click through the slides below to learn about the differences between a “growth mindset” and a “fixed mindset”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1319, 990, 6, 200, NULL, 'https://docs.google.com/presentation/d/10uyrdbnrnF6h1-ZxbmOjzsrcH1TvDZHkR3pZqd_OHbE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1320, 991, 11, 100, NULL, NULL, 'Click through the slides below to learn about LeBron James and his pathway to success. As you read, consider:<ul><li>How does LeBron James demonstrate a growth mindset?</li><li>If LeBron James had used a fixed mindset, how might his story be different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1321, 991, 6, 200, NULL, 'https://docs.google.com/presentation/d/1QHBKMrjBy-GNnO-IKhTd8HeZBhJ_KIhv8I1733HeTMc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1322, 992, 11, 100, NULL, NULL, 'Think about someone you consider successful. Describe the person you chose and why you consider them successful.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1323, 993, 11, 100, NULL, NULL, 'Describe this person’s pathway to success. If you’re not sure, here are some questions you can research.<ul><li>What skills help this person succeed?</li><li>When did this person first learn these skills? How often have they practiced them?</li><li>Who helped this person succeed? How?</li><li>What challenges or setbacks did this person face? How did they respond?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1324, 994, 11, 100, NULL, NULL, 'Define “growth mindset” and “fixed mindset” in your own words.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1325, 995, 11, 100, NULL, NULL, 'Do you live by a growth mindset? If so, how? If not, how might your story be different if you did?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (280, 1322, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (281, 1323, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (282, 1324, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (283, 1325, 100, 0, 2);

--9.3.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (177, 4, 65, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Growth Mindset');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (565, 177, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (566, 177, 2, 2, 3, 200, 'Collaborate on the definition');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (567, 177, 2, 3, 3, 300, 'Apply the definition');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (996, 565, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (997, 565, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (998, 566, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (999, 566, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1000, 567, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1001, 567, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1326, 996, 11, 100, NULL, NULL, 'Your mentee used the slides below to learn about the differences between a “growth mindset” and a “fixed mindset”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1327, 996, 6, 200, NULL, 'https://docs.google.com/presentation/d/10uyrdbnrnF6h1-ZxbmOjzsrcH1TvDZHkR3pZqd_OHbE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1328, 997, 11, 100, NULL, NULL, 'Then, your mentee’s class discussed LeBron James and his pathway to success as an example of growth vs. fixed mindset in action. Your mentee’s class viewed the following slides and discussed these questions:<ul><li>How does LeBron James demonstrate a growth mindset?</li><li>If LeBron James had used a fixed mindset, how might his story be different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1329, 997, 6, 200, NULL, 'https://docs.google.com/presentation/d/1QHBKMrjBy-GNnO-IKhTd8HeZBhJ_KIhv8I1733HeTMc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1330, 998, 11, 100, NULL, NULL, '<ul><li>Your mentee thought about someone they consider successful and reflected on their pathway to success.</li><li>Then, your mentee used this example to define “growth mindset” and “fixed mindset” in their own words.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1331, 999, 11, 100, NULL, NULL, 'Build on your mentee’s definitions. Share some thoughts about how the person your mentee described demonstrates the definitions they wrote.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1332, 1000, 11, 100, NULL, NULL, 'Your mentee ended class by considering whether they live by a growth mindset and wrote the following response.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1333, 1001, 11, 100, NULL, NULL, 'Describe an example of how you utilize a growth mindset in your work or personal life.<p><p>Please be as specific as possible, since your mentee will use this as another example of growth mindset during our next class. You can include details such as how you developed any skills you used, any people who helped you, challenges that you overcame, etc.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (284, 1331, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (285, 1333, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (275, 1330, 280, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (276, 1330, 281, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (277, 1330, 282, TRUE, 300, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (278, 1332, 283, TRUE, 100, 0);

--11.9.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (18, 9, 'Paying for College', 'paying_for_college', 'How much does college cost?<p>How will I pay for college?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (18, 3, 18, '<ul><li>How would you rate your performance this year? As an individual? As a pair?</li><li>What can you do differently next year to improve?</li></ul>', '<ul><li>How would you rate your performance this year? As an individual? As a pair?</li><li>What can you do differently next year to improve?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (66, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 18, 1, NULL, 'How Much Does College Cost and Why?', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (178, 1, 66, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Much Does College Cost and Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (568, 178, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (569, 178, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (570, 178, 2, 1, 2, 300, 'Break down college costs');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (571, 178, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1002, 568, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1003, 568, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1004, 569, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1005, 570, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1006, 571, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1007, 571, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1334, 1002, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the typical costs of attending college and what factors impact that cost.<p><p>In this lesson, mentees will:<ul><li>Read and review a college cost chart</li><li>Discuss the five major cost categories across different institution types</li><li>Research and compare the cost of specific local colleges (optional)</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/how-much-does-college-cost" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1335, 1003, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1336, 1003, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Oe_9wut6tHsdTYZ8Ka1H7pZ7RBuyIf7NO1D1sdHT6e8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1337, 1004, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1338, 1005, 8, 100, NULL, '/new_platform/static/canvas/documents/CollegeCostChart.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1339, 1005, 11, 200, NULL, NULL, 'Review the chart above and answer the following questions:<ul><li>What are the five major categories?</li><li>How are costs similar or different according to the type of college?</li><li>Why do you think they are similar or different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1340, 1006, 11, 100, NULL, NULL, 'Share what you learned today with your mentor:<ul><li>What did you learn about college cost?</li><li>Did any of the costs surprise you? Why?</li><li>Do you have any concerns about paying for college? Say more.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1341, 1007, 11, 100, NULL, NULL, 'What’s new with you? Share it with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (286, 1340, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (287, 1341, 100, 0, 2);

--11.9.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (179, 5, 66, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Much Does College Cost and Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (572, 179, 2, 1, 2, 100, 'Break down college costs');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (573, 179, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1008, 572, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1009, 573, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1010, 573, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1342, 1008, 8, 100, NULL, '/new_platform/static/canvas/documents/CollegeCostChart.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1343, 1008, 11, 200, NULL, NULL, 'Review the chart above and answer the following questions:<ul><li>What are the five major categories?</li><li>How are costs similar or different according to the type of college?</li><li>Why do you think they are similar or different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1344, 1009, 11, 100, NULL, NULL, 'Share what you learned today with your mentor:<ul><li>What did you learn about college cost?</li><li>Did any of the costs surprise you? Why?</li><li>Do you have any concerns about paying for college? Say more.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1345, 1010, 11, 100, NULL, NULL, 'What’s new with you? Share it with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (288, 1344, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (289, 1345, 100, 0, 2);

--11.9.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (180, 4, 66, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Much Does College Cost and Why?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (574, 180, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (575, 180, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1011, 574, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1012, 575, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1013, 575, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1014, 575, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1346, 1011, 11, 100, NULL, NULL, 'Your mentee reviewed and discussed the college cost chart below. They defined each of the five categories in their own words, compared the similarities and differences in cost for different types of colleges, and discussed which factors impacted cost the most.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1347, 1011, 8, 200, NULL, '/new_platform/static/canvas/documents/CollegeCostChart.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1348, 1012, 11, 100, NULL, NULL, 'Your mentee wrote you about college costs.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1349, 1013, 11, 100, NULL, NULL, 'Respond to your mentee.<ul><li>Acknowledge any concerns your mentee has about paying for college.</li><li>Consider the role you can play in helping your mentee navigate those concerns.</li><li>How did you pay for college? Share some tips with your mentee.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1350, 1014, 11, 100, NULL, NULL, 'What’s new? Read your mentee’s update and share one of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (290, 1349, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (291, 1350, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (279, 1348, 288, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (280, 1350, 289, TRUE, 100, 0);

--10.6.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (67, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 14, 2, NULL, 'Personality Assessment / Interest Inventory', '/new_platform/static/canvas/images/10.6.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (181, 1, 67, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Personality Assessment / Interest Inventory');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (576, 181, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (577, 181, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (578, 181, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (579, 181, 2, 2, 3, 400, 'What is my personality type?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (580, 181, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1015, 576, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1016, 576, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1017, 577, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1018, 578, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1019, 579, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1020, 579, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1021, 580, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1022, 580, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1023, 580, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1024, 580, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1025, 580, 500);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1351, 1015, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will walk mentees through a personality assessment/skills inventory to help them learn more about themselves, how they learn, and what their interests are as a means to informing their thinking for future lessons.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Take a personality test</li><li>Assess the results of their personality test</li><li>Share the results and assessment with their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-personality-assessment" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1352, 1016, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1353, 1016, 6, 200, NULL, 'https://docs.google.com/presentation/d/1ZI6ijjTO_DRvCWbLmqp_zUbspI3Hz3u7rb4jDiKYEKE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1354, 1017, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1355, 1018, 11, 100, NULL, NULL, 'Read your mentor''s response to your "why," and what they shared about their own "why".', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1356, 1019, 11, 100, NULL, NULL, 'Keep the following things in mind as you take this personality test:<ul><li>The test should not take more than 15 minutes.</li><li>Try to answer as honestly as possible, even if you don’t like the answer.</li><li>Try not to leave “neutral” answers so your results are as accurate as possible.</li></ul><p><p>Take the test <a href="http://www.16personalities.com/free-personality-test" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1357, 1020, 11, 100, NULL, NULL, 'Find your type <a href="http://www.16personalities.com/personality-types" target="_blank">here</a> and click on it to learn more.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1358, 1021, 11, 100, NULL, NULL, 'Describe your personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1359, 1022, 11, 100, NULL, NULL, 'What''s one major strength about your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1360, 1023, 11, 100, NULL, NULL, 'What''s one thing you don''t like about the characteristics of your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1361, 1024, 11, 100, NULL, NULL, 'Is this how you would describe yourself? Why or why not?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1362, 1025, 11, 100, NULL, NULL, 'A personality assessment can never capture everything about a person. What else would you want your mentor to know about you?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (292, 1358, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (293, 1359, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (294, 1360, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (295, 1361, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (296, 1362, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (281, 1355, 243, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (282, 1355, 244, TRUE, 200, 0);

--10.6.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (182, 5, 67, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Personality Assessment / Interest Inventory');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (581, 182, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (582, 182, 2, 2, 3, 200, 'What is my personality type?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (583, 182, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1026, 581, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1027, 582, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1028, 582, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1029, 583, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1030, 583, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1031, 583, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1032, 583, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1033, 583, 500);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1363, 1026, 11, 100, NULL, NULL, 'Read your mentor''s response to your "why," and what they shared about their own "why".', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1364, 1027, 11, 100, NULL, NULL, 'Keep the following things in mind as you take this personality test:<ul><li>The test should not take more than 15 minutes.</li><li>Try to answer as honestly as possible, even if you don’t like the answer.</li><li>Try not to leave “neutral” answers so your results are as accurate as possible.</li></ul><p><p>Take the test <a href="http://www.16personalities.com/free-personality-test" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1365, 1028, 11, 100, NULL, NULL, 'Find your type <a href="http://www.16personalities.com/personality-types" target="_blank">here</a> and click on it to learn more.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1366, 1029, 11, 100, NULL, NULL, 'Describe your personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1367, 1030, 11, 100, NULL, NULL, 'What''s one major strength about your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1368, 1031, 11, 100, NULL, NULL, 'What''s one thing you don''t like about the characteristics of your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1369, 1032, 11, 100, NULL, NULL, 'Is this how you would describe yourself? Why or why not?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1370, 1033, 11, 100, NULL, NULL, 'A personality assessment can never capture everything about a person. What else would you want your mentor to know about you?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (297, 1366, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (298, 1367, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (299, 1368, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (300, 1369, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (301, 1370, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (283, 1363, 243, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (284, 1363, 244, TRUE, 200, 0);

--10.6.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (183, 4, 67, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Personality Assessment / Interest Inventory');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (584, 183, 2, 1, 4, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (585, 183, 2, 2, 4, 200, 'Respond to your mentee’s personality test results');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (586, 183, 2, 3, 4, 300, 'What’s your personality type?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (587, 183, 2, 4, 4, 400, 'Share with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1034, 584, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1035, 584, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1036, 584, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1037, 584, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1038, 584, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1039, 584, 600);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1040, 585, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1041, 586, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1042, 586, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1043, 587, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1371, 1034, 11, 100, NULL, NULL, 'First, your mentee took a <a href="http://www.16personalities.com/free-personality-test" target="_blank">personality test</a> and clicked into <a href="http://www.16personalities.com/personality-types" target="_blank">their type</a> to learn more about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1372, 1035, 11, 100, NULL, NULL, 'Then, your mentee reflected on their type and how they show up to others using the following questions:<p><p>Describe your personality type.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1373, 1036, 11, 100, NULL, NULL, 'What''s one major strength about your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1374, 1037, 11, 100, NULL, NULL, 'What''s one thing you don''t like about the characteristics of your type?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1375, 1038, 11, 100, NULL, NULL, 'Is this how you would describe yourself? Why or why not?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1376, 1039, 11, 100, NULL, NULL, 'A personality assessment can never capture everything about a person. What else would you want your mentor to know about you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1377, 1040, 11, 100, NULL, NULL, 'Share the following with your mentee:<ul><li>Did the result surprise you, based on what you know about your mentee?</li><li>What about this personality type suits your mentee? What specific examples can you share?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1378, 1041, 11, 100, NULL, NULL, 'Now it’s your turn! Keep the following things in mind as you take this personality test:<ul><li>The test should not take more than 15 minutes.</li><li>Try to answer as honestly as possible, even if you don’t like the answer.</li><li>Try not to leave “neutral” answers so your results are as accurate as possible.</li></ul><p><p>Take the test <a href="http://www.16personalities.com/free-personality-test" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1379, 1042, 11, 100, NULL, NULL, 'Then, click on your type <a href="http://www.16personalities.com/personality-types" target="_blank">here</a> to learn more about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1380, 1043, 11, 100, NULL, NULL, '<ul><li>Describe your personality type.</li><li>What is one major strength about your type?</li><li>What''s one thing you don''t like about the characteristics of your type?</li><li>Is this how you would describe yourself? Why or why not?</li><li>A personality assessment can never capture everything about a person. What else would you want your mentee to know about you?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (302, 1377, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (303, 1380, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (285, 1372, 297, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (286, 1373, 298, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (287, 1374, 299, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (288, 1375, 300, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (289, 1376, 301, TRUE, 100, 0);

--10.6.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (69, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 14, 3, NULL, 'Dream Careers', '/new_platform/static/canvas/images/10.6.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (187, 1, 69, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Dream Careers');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (598, 187, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (599, 187, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (600, 187, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (601, 187, 2, 2, 4, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (602, 187, 2, 3, 4, 500, 'What would you do if you knew you could not fail?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (603, 187, 2, 4, 4, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1056, 598, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1057, 598, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1058, 598, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1059, 599, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1060, 600, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1061, 600, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1062, 600, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1063, 601, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1064, 602, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1065, 603, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1066, 603, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1397, 1056, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will ask mentees to consider what they would attempt to achieve if they knew they would not fail. This lesson will stress big and open-ended possibilities, without concern for immediate challenges and barriers.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Connect their "why" to what they would attempt if they could not fail</li><li>Identify personal goals and ambitions independent of careers</li><li>Understand that life ambitions and career goals are not synonymous</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-dream-careers" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1398, 1057, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1399, 1057, 6, 200, NULL, 'https://docs.google.com/presentation/d/15Gqp2u46DeIoVJWT4FpsraBWhGrPs1_73j6KP5ALZ34/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1400, 1058, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1401, 1058, 3, 200, NULL, 'https://vimeo.com/141170526', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1402, 1059, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1403, 1060, 11, 100, NULL, NULL, 'Your mentor wrote you a message about your personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1404, 1061, 11, 100, NULL, NULL, 'Learn about your mentor’s personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1405, 1062, 11, 100, NULL, NULL, 'What do you think about your mentor’s personality type?<ul><li>Did your mentor’s results surprise you?  Why or why not?</li><li>What about this personality type fits your mentor? What doesn’t fit?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1406, 1063, 11, 100, NULL, NULL, 'While watching the video, think about the following questions:<ul><li>What did each chef want to be when they were kids?</li><li>Why do you think they didn''t become those things?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1407, 1063, 3, 200, NULL, 'https://vimeo.com/141170526', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1408, 1064, 11, 100, NULL, NULL, 'Identify something that you love and want to accomplish, and investigate it further using the <a href="https://careervillage.org/home/" target="_blank">Career Village</a> website.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1409, 1065, 11, 100, NULL, NULL, 'What is your dream career and how does it connect to your “why”?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1410, 1066, 11, 100, NULL, NULL, 'Teach your mentor one new thing you learned about your dream career from Career Village.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (307, 1405, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (308, 1409, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (309, 1410, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (293, 1403, 302, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (294, 1404, 303, TRUE, 100, 0);

--10.6.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (188, 5, 69, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Dream Careers');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (604, 188, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (605, 188, 2, 2, 4, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (606, 188, 2, 3, 4, 300, 'What would you do if you knew you could not fail?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (607, 188, 2, 4, 4, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1067, 604, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1068, 604, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1069, 604, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1070, 605, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1071, 606, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1072, 607, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1073, 607, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1411, 1067, 11, 100, NULL, NULL, 'Your mentor wrote you a message about your personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1412, 1068, 11, 100, NULL, NULL, 'Learn about your mentor’s personality type.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1413, 1069, 11, 100, NULL, NULL, 'What do you think about your mentor’s personality type?<ul><li>Did your mentor’s results surprise you?  Why or why not?</li><li>What about this personality type fits your mentor? What doesn’t fit?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1414, 1070, 11, 100, NULL, NULL, 'While watching the video, think about the following questions:<ul><li>What did each chef want to be when they were kids?</li><li>Why do you think they didn''t become those things?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1415, 1070, 3, 200, NULL, 'https://vimeo.com/141170526', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1416, 1071, 11, 100, NULL, NULL, 'Identify something that you love and want to accomplish, and investigate it further using the <a href="https://careervillage.org/home/" target="_blank">Career Village</a> website.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1417, 1072, 11, 100, NULL, NULL, 'What is your dream career and how does it connect to your “why”?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1418, 1073, 11, 100, NULL, NULL, 'Teach your mentor one new thing you learned about your dream career from Career Village.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (310, 1413, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (311, 1417, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (312, 1418, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (295, 1411, 302, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (296, 1412, 303, TRUE, 100, 0);

--10.6.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (189, 4, 69, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Dream Careers');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (608, 189, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (609, 189, 2, 2, 2, 200, 'Share with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1074, 608, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1075, 608, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1076, 608, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1077, 608, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1078, 609, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1079, 609, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1080, 609, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1419, 1074, 11, 100, NULL, NULL, 'First, your mentee read about your personality type and answered the following questions:<ul><li>Did the results surprise you, based on what you know about your mentor? Why or why not?</li><li>What about this personality type fits your mentor? Share a specific example.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1420, 1075, 11, 100, NULL, NULL, 'Then, your mentee watched the following video to introduce them to the idea of “dream careers” and discussed the following questions in class:<ul><li>What did each chef want to be when they were kids?</li><li>Why do you think they didn''t become those things?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1421, 1075, 3, 200, NULL, 'https://vimeo.com/141170526', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1422, 1076, 11, 100, NULL, NULL, 'Your mentee worked in class to come up with one thing they would attempt if they could not fail. They investigated this dream career further through <a href="https://careervillage.org/home/" target="_blank">Career Village</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1423, 1077, 11, 100, NULL, NULL, 'Your mentee shared the following with you about their dream career and what they learned on Career Village.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1424, 1078, 11, 100, NULL, NULL, 'Share some reflections on your mentee’s dream career and what they learned on Career Village.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1425, 1079, 11, 100, NULL, NULL, 'Teach your mentee one thing about your current career.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1426, 1080, 11, 100, NULL, NULL, 'Share a dream career you had when you were a kid. How does your current career relate to your dream career?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (313, 1424, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (314, 1425, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (315, 1426, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (297, 1419, 310, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (298, 1423, 311, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (299, 1423, 312, TRUE, 200, 0);

--10.6.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (70, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 14, 4, NULL, 'My Career Roadmap', '/new_platform/static/canvas/images/10.6.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (190, 1, 70, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Career Roadmap');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (610, 190, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (611, 190, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (612, 190, 2, 1, 3, 300, 'Continuing the conversation');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (613, 190, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (614, 190, 2, 3, 3, 500, 'What is my dream career?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1081, 610, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1082, 610, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1083, 610, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1084, 611, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1085, 612, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1086, 612, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1087, 613, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1088, 614, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1089, 614, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1427, 1081, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />After thinking through dream possibilities in the prior lesson, this lesson will engage mentees to start mapping how they might achieve those dreams via careers with specific questions like: what kind of education do I need, what skills do I need to have, who do I need to know, etc.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and articulate their dream career</li><li>Map backwards to start thinking through what they can do now to help them pursue that dream</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-career-readiness-my-career-roadmap" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1428, 1082, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1429, 1082, 6, 200, NULL, 'https://docs.google.com/presentation/d/1pw9ZuJQ8aRkKU-0QYXlVZ6Qwk1adU_pTAJqd8zCHVNc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1430, 1083, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1431, 1083, 3, 200, NULL, 'https://vimeo.com/141173890', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1432, 1084, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1433, 1085, 11, 100, NULL, NULL, 'Read your mentor’s thoughts on your dream career, and about their own dream career as a kid.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1434, 1086, 11, 100, NULL, NULL, 'Revisit <a href="https://careervillage.org/" target="_blank">Career Village</a> to review any responses to the question(s) you posted.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1435, 1087, 11, 100, NULL, NULL, 'Consider the following as you watch the video about Neil Degrasse Tyson:<ul><li>What does Neil Degrasse Tyson say is the "great tragedy"?</li><li>How will identifying your passions now help you to avoid that "tragedy"?</li><li>What are the benefits of choosing a career by matching it with your passions?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1436, 1087, 3, 200, NULL, 'https://vimeo.com/141173890', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1437, 1088, 11, 100, NULL, NULL, 'Draft an objective statement that describes your dream career. Your statement should include the following:<ul><li>The job you want</li><li>Why you want that job</li><li>The skills that make you a good fit for that job</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1438, 1089, 11, 100, NULL, NULL, 'Use the Backwards Mapping Tool to map backwards from your dream into the specific steps you will need to take to make it a reality.<p><p>Use <a href="https://careervillage.org/home/" target="_blank">Career Village</a> to answer any questions that come up about your dream career as you complete the tool.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1439, 1089, 6, 200, NULL, 'https://docs.google.com/document/d/1e3v5uZqUzu0DX2ugll5vqTsO-6Qb8vlB5VtolYTO9NA/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (316, 1437, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (300, 1433, 313, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (301, 1433, 314, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (302, 1433, 315, TRUE, 300, 0);

--10.6.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (191, 5, 70, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Career Roadmap');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (615, 191, 2, 1, 3, 100, 'Continuing the conversation');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (616, 191, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (617, 191, 2, 3, 3, 300, 'What is my dream career?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1090, 615, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1091, 615, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1092, 616, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1093, 617, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1094, 617, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1440, 1090, 11, 100, NULL, NULL, 'Read your mentor’s thoughts on your dream career, and about their own dream career as a kid.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1441, 1091, 11, 100, NULL, NULL, 'Revisit <a href="https://careervillage.org/" target="_blank">Career Village</a> to review any responses to the question(s) you posted.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1442, 1092, 11, 100, NULL, NULL, 'Consider the following as you watch the video about Neil Degrasse Tyson:<ul><li>What does Neil Degrasse Tyson say is the "great tragedy"?</li><li>How will identifying your passions now help you to avoid that "tragedy"?</li><li>What are the benefits of choosing a career by matching it with your passions?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1443, 1092, 3, 200, NULL, 'https://vimeo.com/141173890', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1444, 1093, 11, 100, NULL, NULL, 'Draft an objective statement that describes your dream career. Your statement should include the following:<ul><li>The job you want</li><li>Why you want that job</li><li>The skills that make you a good fit for that job</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1445, 1094, 11, 100, NULL, NULL, 'Use the Backwards Mapping Tool to map backwards from your dream into the specific steps you will need to take to make it a reality.<p><p>Use <a href="https://careervillage.org/home/" target="_blank">Career Village</a> to answer any questions that come up about your dream career as you complete the tool.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1446, 1094, 6, 200, NULL, 'https://docs.google.com/document/d/1e3v5uZqUzu0DX2ugll5vqTsO-6Qb8vlB5VtolYTO9NA/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (317, 1444, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (303, 1440, 313, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (304, 1440, 314, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (305, 1440, 315, TRUE, 300, 0);

--10.6.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (192, 4, 70, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Career Roadmap');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (618, 192, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (619, 192, 2, 2, 2, 200, 'Collaborate with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1095, 618, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1096, 618, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1097, 618, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1098, 618, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1099, 619, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1447, 1095, 11, 100, NULL, NULL, 'Your mentee watched the following video in class:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1448, 1095, 3, 200, NULL, 'https://vimeo.com/141173890', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1449, 1096, 11, 100, NULL, NULL, 'They discussed the following questions with their peers:<ul><li>What does Neil Degrasse Tyson say is the "great tragedy"?</li><li>How will identifying your passions now help you to avoid that "tragedy"?</li><li>What are the benefits of choosing a career by matching it with your passions?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1450, 1097, 11, 100, NULL, NULL, 'Then, they drafted an objective statement to describe their dream career.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1451, 1098, 11, 100, NULL, NULL, 'Last, your mentee completed a Backwards Mapping Tool to outline the steps needed to turn their dream into a reality.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1452, 1098, 6, 200, NULL, 'https://docs.google.com/document/d/1e3v5uZqUzu0DX2ugll5vqTsO-6Qb8vlB5VtolYTO9NA/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1453, 1099, 11, 100, NULL, NULL, 'Review your mentee’s responses in the Backwards Mapping Tool. Type directly into the document to provide feedback. Encourage your mentee, asking probing questions, and including additional suggestions for learning more about or getting closer to their dream career.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (306, 1450, 317, TRUE, 100, 0);