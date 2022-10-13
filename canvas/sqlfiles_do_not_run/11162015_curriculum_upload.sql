--12.5.2 Lesson Image Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.5.2.jpg'
WHERE id = 100;

--12.5.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (101, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 24, 3, NULL, 'Completing the FAFSA', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (282, 1, 101, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Completing the FAFSA');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (914, 282, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (915, 282, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (916, 282, 2, 1, 3, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (917, 282, 2, 2, 3, 400, 'Begin the FAFSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (918, 282, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1640, 914, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1641, 914, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1642, 915, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1643, 916, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1644, 917, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1645, 917, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1646, 918, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2166, 1640, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will address any lingering questions mentees have about the FAFSA and get them started on completing the application.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Answer remaining questions they have about the FAFSA</li><li>Complete the student section of the FAFSA</li><li>Create a plan for acquiring the information they need to complete the parent section of the FAFSA</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/completing-fafsa" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2167, 1641, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2168, 1641, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Xh3Ln0gsWTkhaqP3VUbUnZghtFHZusB-UmjCQyDIZZQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2169, 1642, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2170, 1643, 11, 100, NULL, NULL, 'Your mentor shared ways that they can help you through the FAFSA process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2171, 1644, 11, 100, NULL, NULL, 'Log in to the FAFSA website below using your FSA ID. Complete Sections 1 and 2 of the FAFSA.<p><p><a href="https://studentaid.ed.gov/npas/index.htm" target="_blank">https://studentaid.ed.gov/npas/index.htm</a></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2172, 1645, 11, 100, NULL, NULL, 'Review sections 3 and 4 of the FAFSA. As you review, identify sections where you have questions and/or are unclear about what information your parents need to provide.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2173, 1646, 11, 100, NULL, NULL, 'Reflect on your progress of completing the application.<ul><li>Do you need additional support to complete the FAFSA? How can your mentor provide that support?</li><li>What challenges, if any, are you having or think you will have when completing the FAFSA?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (466, 2173, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (448, 2170, 465, TRUE, 100, 0);

--12.5.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (283, 5, 101, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Completing the FAFSA');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (919, 283, 2, 1, 3, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (920, 283, 2, 2, 3, 200, 'Begin the FAFSA');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (921, 283, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1647, 919, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1648, 920, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1649, 920, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1650, 921, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2174, 1647, 11, 100, NULL, NULL, 'Your mentor shared ways that they can help you through the FAFSA process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2175, 1648, 11, 100, NULL, NULL, 'Log in to the FAFSA website below using your FSA ID. Complete Sections 1 and 2 of the FAFSA.<p><p><a href="https://studentaid.ed.gov/npas/index.htm" target="_blank">https://studentaid.ed.gov/npas/index.htm</a></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2176, 1649, 11, 100, NULL, NULL, 'Review sections 3 and 4 of the FAFSA. As you review, identify sections where you have questions and/or are unclear about what information your parents need to provide.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2177, 1650, 11, 100, NULL, NULL, 'Reflect on your progress of completing the application.<ul><li>Do you need additional support to complete the FAFSA? How can your mentor provide that support?</li><li>What challenges, if any, are you having or think you will have when completing the FAFSA?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (467, 2177, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (449, 2174, 465, TRUE, 100, 0);

--12.5.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (284, 4, 101, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Completing the FAFSA');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (922, 284, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1651, 922, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1652, 922, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1653, 922, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2178, 1651, 11, 100, NULL, NULL, 'Your mentee logged in to the FAFSA website and began working on Sections 1 and 2 of the FAFSA.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2179, 1652, 11, 100, NULL, NULL, 'Then, your mentee reviewed Section 3 of the FAFSA, which discusses parent information, and Section 4 of the FAFSA, which applies to students who file taxes independently from their parents. Your mentee identified the specific items where parents need to provide information.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2180, 1653, 11, 100, NULL, NULL, 'Your mentee wrote the following reflection on the FAFSA, additional support they need, and any challenges they think they will encounter.<p><p>If you haven’t already, click <a href="https://learn.imentor.org/help/article/link/how-mentors-can-help-with-the-fafsa" target="_blank">here</a> to learn how you may be able to support your mentee in this process.</p></p>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (450, 2180, 467, TRUE, 100, 0);

--13.1.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (102, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 5, 6, 3, NULL, 'Financial Obligations, Part 1', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (285, 1, 102, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 1');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (923, 285, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (924, 285, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (925, 285, 2, 1, 4, 300, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (926, 285, 2, 2, 4, 400, 'Break down tuition costs');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (927, 285, 2, 3, 4, 500, 'Know your requirements');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (928, 285, 2, 4, 4, 600, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1659, 923, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1660, 924, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1661, 925, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1662, 926, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1663, 927, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1664, 927, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1665, 928, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1666, 928, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2186, 1659, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This learning topic is part of a two-part series meant to provide you with the foundational financial literacy that will help you make financially smart decisions about paying for college. In this first part of the series, we will discuss how to use a tuition bill to identify what financial obligations you have. Then, in the second part of the series, we will help you create a budget to meet the financial obligations that you identify.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze their tuition bill to determine total tuition cost and, of this cost, amount borrowed, gifted, and owed out-of-pocket</li><li>Identify any requirements they need to meet for money borrowed or gifted</li><li>Understand loan repayment rates and repayment options for any money borrowed</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/online-lesson-financial-obligations-part-1" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2187, 1660, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2188, 1661, 11, 100, NULL, NULL, 'We are now beginning a two-part series on “financial obligations” in college. Below are our objectives for the first part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-1" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2189, 1661, 6, 200, NULL, 'https://docs.google.com/presentation/d/1NRqgen-a1uZRPzBgE0JEjZ3qbbFELokxjGvF0y7geGU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2190, 1662, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/reading-your-college-tuition-bill" target="_blank">this</a> article about how to read your tuition bill. Use the article to identify:<ul><li>Your total tuition cost</li><li>The amount you are paying with borrowed money (i.e. loans)</li><li>The amount you are paying with gifted money (i.e. scholarships & grants)</li><li>The remaining amount you owe out-of-pocket</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2191, 1663, 11, 100, NULL, NULL, 'Watch the video to learn more about loans and debt.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2192, 1663, 2, 200, NULL, 'https://www.youtube.com/watch?v=E8jeQcDH1fM#action=share', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2193, 1664, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/know-the-details-of-your-loans-and-scholarships" target="_blank">this</a> article to learn more about loan repayment options and scholarship requirements.<ul><li>If you have any loans, identify your loan repayment rates</li><li>If you have loans OR scholarships, use the directions in the article to identify the requirements you need to meet to keep them</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2194, 1665, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2195, 1665, 6, 200, NULL, 'https://docs.google.com/presentation/d/1OZLQ75lychmd6E5rPjF-Gu9A8jpfcurDDRiID1r_Ub4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2196, 1666, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--13.1.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (286, 5, 102, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 1');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (929, 286, 2, 1, 4, 100, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (930, 286, 2, 2, 4, 200, 'Break down tuition costs');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (931, 286, 2, 3, 4, 300, 'Know your requirements');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (932, 286, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1667, 929, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1668, 930, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1669, 931, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1670, 931, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1671, 932, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1672, 932, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2197, 1667, 11, 100, NULL, NULL, 'We are now beginning a two-part series on “financial obligations” in college. Below are our objectives for the first part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-1" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2198, 1667, 6, 200, NULL, 'https://docs.google.com/presentation/d/1NRqgen-a1uZRPzBgE0JEjZ3qbbFELokxjGvF0y7geGU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2199, 1668, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/reading-your-college-tuition-bill" target="_blank">this</a> article about how to read your tuition bill. Use the article to identify:<ul><li>Your total tuition cost</li><li>The amount you are paying with borrowed money (i.e. loans)</li><li>The amount you are paying with gifted money (i.e. scholarships & grants)</li><li>The remaining amount you owe out-of-pocket</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2200, 1669, 11, 100, NULL, NULL, 'Watch the video to learn more about loans and debt.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2201, 1669, 2, 200, NULL, 'https://www.youtube.com/watch?v=E8jeQcDH1fM#action=share', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2202, 1670, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/know-the-details-of-your-loans-and-scholarships" target="_blank">this</a> article to learn more about loan repayment options and scholarship requirements.<ul><li>If you have any loans, identify your loan repayment rates</li><li>If you have loans OR scholarships, use the directions in the article to identify the requirements you need to meet to keep them</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2203, 1671, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2204, 1671, 6, 200, NULL, 'https://docs.google.com/presentation/d/1OZLQ75lychmd6E5rPjF-Gu9A8jpfcurDDRiID1r_Ub4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2205, 1672, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--13.1.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (287, 4, 102, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 1');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (933, 287, 2, 1, 4, 100, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (934, 287, 2, 2, 4, 200, 'Break down tuition costs');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (935, 287, 2, 3, 4, 300, 'Know your requirements');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (936, 287, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1673, 933, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1674, 934, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1675, 935, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1676, 935, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1677, 936, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1678, 936, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2206, 1673, 11, 100, NULL, NULL, 'We are now beginning a two-part series on “financial obligations” in college. Below are our objectives for the first part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-1" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2207, 1673, 6, 200, NULL, 'https://docs.google.com/presentation/d/1NRqgen-a1uZRPzBgE0JEjZ3qbbFELokxjGvF0y7geGU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2208, 1674, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/reading-your-college-tuition-bill" target="_blank">this</a> article about how to read a tuition bill. Use the article to ensure that your mentee understands:<ul><li>Their total tuition cost</li><li>The amount they are paying with borrowed money (i.e. loans)</li><li>The amount they are paying with gifted money (i.e. scholarships & grants)</li><li>The remaining amount they owe out-of-pocket</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2209, 1675, 11, 100, NULL, NULL, 'Watch the video to learn more about loans and debt.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2210, 1675, 2, 200, NULL, 'https://www.youtube.com/watch?v=E8jeQcDH1fM#action=share', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2211, 1676, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/know-the-details-of-your-loans-and-scholarships" target="_blank">this</a> article to learn more about loan repayment options and scholarship requirements.<ul><li>If your mentee has any loans, help them identify their loan repayment rates</li><li>If your mentee has any loans OR scholarships, use the directions in the article to help them identify the requirements they need to meet to keep this source of financial aid</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2212, 1677, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that your mentee should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2213, 1677, 6, 200, NULL, 'https://docs.google.com/presentation/d/1OZLQ75lychmd6E5rPjF-Gu9A8jpfcurDDRiID1r_Ub4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2214, 1678, 11, 100, NULL, NULL, 'Schedule some time to work on these things with your mentee. This should include at least one in-person meeting plus any combination of additional meetings, phone calls, texts, etc. <a href="https://learn.imentor.org/help/article/link/suggested-pair-meetings-for-topics-3-and-4" target="_blank">Here</a> are some suggestions for in-person meetings this month.', NULL);

--13.1.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (103, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 5, 6, 4, NULL, 'Financial Obligations, Part 2', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (288, 1, 103, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 2');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (937, 288, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (938, 288, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (939, 288, 2, 1, 4, 300, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (940, 288, 2, 2, 4, 400, 'Create a budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (941, 288, 2, 3, 4, 500, 'Review your budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (942, 288, 2, 4, 4, 600, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1679, 937, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1680, 938, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1681, 939, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1682, 940, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1683, 941, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1684, 941, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1685, 942, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1686, 942, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2215, 1679, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This learning topic is part of a two-part series meant to provide you with the foundational financial literacy that will help you make financially smart decisions about paying for college. In the first part of the series, we discussed how to use a tuition bill to identify what financial obligations you have. Now, this second part of the series will help you create a budget to meet the financial obligations that you identified.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create a budget for additional out-of-pocket college expenses</li><li>Confirm your ability to cover the out-of-pocket costs in your budget</li><li>Establish a process for monitoring your budget over time</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/online-lesson-financial-obligations-part-2" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2216, 1680, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2217, 1681, 11, 100, NULL, NULL, 'We are now moving on to the second part of our series on “financial obligations” in college. Below are our objectives for the second part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-2" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2218, 1681, 6, 200, NULL, 'https://docs.google.com/presentation/d/1SDburS9aTPjoKeLD5cFvROvku3hRxms6Sw4SQjrR0tc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2219, 1682, 11, 100, NULL, NULL, 'Click into <a href="https://docs.google.com/spreadsheets/d/1O6hp78cI81Ti2zrSvqR81nUocYQXcRzY0pdorTuCEbw/edit?usp=sharing" target="_blank">this</a> template to create a college budget. For help, refer to this article about <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">how to budget for college costs</a>.<p><p>Your budget should include the out-of-pocket tuition costs you identified in our last lesson, plus any additional living costs of college (such as food, books, transportation, etc).</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2220, 1683, 11, 100, NULL, NULL, 'Check your budget to make sure that you have enough money coming in to cover all of the costs of college.<p><p>Concerned about your ability to pay for college? Check out <a href="https://learn.imentor.org/help/article/link/what-to-do-if-college-costs-get-too-high" target="_blank">this</a> article for tips on how to weigh your different options.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2221, 1684, 11, 100, NULL, NULL, 'A budget isn’t something you do once and forget about it. Talk to your mentor about a process that you could use to monitor your budget over time.<p><p>Check out <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">this</a> article for advice!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2222, 1685, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2223, 1685, 6, 200, NULL, 'https://docs.google.com/presentation/d/13VvC1t4oK7Si6-wZQ0nAUH8CYB0Q3zWiKh2iw_RwcS0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2224, 1686, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--13.1.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (289, 5, 103, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 2');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (943, 289, 2, 1, 4, 100, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (944, 289, 2, 2, 4, 200, 'Create a budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (945, 289, 2, 3, 4, 300, 'Review your budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (946, 289, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1687, 943, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1688, 944, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1689, 945, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1690, 945, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1691, 946, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1692, 946, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2225, 1687, 11, 100, NULL, NULL, 'We are now moving on to the second part of our series on “financial obligations” in college. Below are our objectives for the second part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-2" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2226, 1687, 6, 200, NULL, 'https://docs.google.com/presentation/d/1SDburS9aTPjoKeLD5cFvROvku3hRxms6Sw4SQjrR0tc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2227, 1688, 11, 100, NULL, NULL, 'Click into <a href="https://docs.google.com/spreadsheets/d/1O6hp78cI81Ti2zrSvqR81nUocYQXcRzY0pdorTuCEbw/edit?usp=sharing" target="_blank">this</a> template to create a college budget. For help, refer to this article about <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">how to budget for college costs</a>.<p><p>Your budget should include the out-of-pocket tuition costs you identified in our last lesson, plus any additional living costs of college (such as food, books, transportation, etc).</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2228, 1689, 11, 100, NULL, NULL, 'Check your budget to make sure that you have enough money coming in to cover all of the costs of college.<p><p>Concerned about your ability to pay for college? Check out <a href="https://learn.imentor.org/help/article/link/what-to-do-if-college-costs-get-too-high" target="_blank">this</a> article for tips on how to weigh your different options.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2229, 1690, 11, 100, NULL, NULL, 'A budget isn’t something you do once and forget about it. Talk to your mentor about a process that you could use to monitor your budget over time.<p><p>Check out <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">this</a> article for advice!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2230, 1691, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2231, 1691, 6, 200, NULL, 'https://docs.google.com/presentation/d/13VvC1t4oK7Si6-wZQ0nAUH8CYB0Q3zWiKh2iw_RwcS0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2232, 1692, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--13.1.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (290, 4, 103, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Financial Obligations, Part 2');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (947, 290, 2, 1, 4, 100, 'Read the objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (948, 290, 2, 2, 4, 200, 'Create a budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (949, 290, 2, 3, 4, 300, 'Review your budget');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (950, 290, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1693, 947, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1694, 948, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1695, 949, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1696, 949, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1697, 950, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1698, 950, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2233, 1693, 11, 100, NULL, NULL, 'We are now moving on to the second part of our series on “financial obligations” in college. Below are our objectives for the second part of the series. You can learn more about the topic <a href="https://learn.imentor.org/help/article/link/topic-overview-financial-obligations-part-2" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2234, 1693, 6, 200, NULL, 'https://docs.google.com/presentation/d/1SDburS9aTPjoKeLD5cFvROvku3hRxms6Sw4SQjrR0tc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2235, 1694, 11, 100, NULL, NULL, 'Help your mentee create a college budget. You and your mentee can use <a href="https://docs.google.com/spreadsheets/d/1O6hp78cI81Ti2zrSvqR81nUocYQXcRzY0pdorTuCEbw/edit?usp=sharing" target="_blank">this</a> template to get started.<p><p>This budget should include the out-of-pocket tuition costs that your mentee identified in our last lesson, plus any additional living costs of college (such as food, books, transportation, etc).</p></p>For help, refer to this article about <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">how to budget for college costs</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2236, 1695, 11, 100, NULL, NULL, 'Help your mentee review their budget once completed. Make sure that your mentee feels confident in their ability to cover all of the costs of college.<p><p>If your mentee is concerned about their ability to pay for college, check out <a href="https://learn.imentor.org/help/article/link/what-to-do-if-college-costs-get-too-high" target="_blank">this</a> article for tips on how to help your mentee weigh some different options.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2237, 1696, 11, 100, NULL, NULL, 'It’s important that you help your mentee revisit their budget regularly. This will help your mentee resolve potential financial obstacles before they become barriers to paying for college.<p><p>Talk to your mentee about a process for monitoring their budget over time. Check out <a href="https://learn.imentor.org/help/article/link/budgeting-for-out-of-pocket-college-costs" target="_blank">this</a> article for advice!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2238, 1697, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that your mentee should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2239, 1697, 6, 200, NULL, 'https://docs.google.com/presentation/d/13VvC1t4oK7Si6-wZQ0nAUH8CYB0Q3zWiKh2iw_RwcS0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2240, 1698, 11, 100, NULL, NULL, 'Schedule some time to work on these things with your mentee. This should include at least one in-person meeting plus any combination of additional meetings, phone calls, texts, etc. <a href="https://learn.imentor.org/help/article/link/suggested-pair-meetings-for-topics-3-and-4" target="_blank">Here</a> are some suggestions for in-person meetings this month.', NULL);