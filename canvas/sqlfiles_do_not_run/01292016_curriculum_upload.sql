--10.8.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (143, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 34, 4, NULL, 'LIVE College Ready Now', '/new_platform/static/canvas/images/10.8.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (406, 1, 143, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE College Ready Now');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1298, 406, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1299, 406, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1300, 406, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1301, 406, 2, 2, 3, 400, 'What is college readiness?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1302, 406, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2254, 1298, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2255, 1298, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2256, 1299, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2257, 1300, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2258, 1300, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2259, 1301, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2260, 1302, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2952, 2254, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Becoming college ready is a process, and it''s a process that starts now. In this lesson, mentees will explore a definition for college readiness. They will learn about the LIVE framework and how it can help them prepare for college.<p><p>In this lesson, mentees will:<ul><li>Draw upon prior knowledge to create definitions and list skills for college readiness.</li><li>Review the "4 Keys" college readiness framework.</li><li>Review the "LIVE college ready now" framework.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/college-ready-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2953, 2255, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2954, 2255, 6, 200, NULL, 'https://docs.google.com/presentation/d/1qr1r92JBr2_yGWA9i5qRG_7YcGjlL4FEhunVeeV7iBU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2955, 2256, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2956, 2257, 11, 100, NULL, NULL, 'Your mentor responded to your self-assessment and shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2957, 2258, 11, 100, NULL, NULL, 'Respond to your mentor’s personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2958, 2259, 9, 100, NULL, '/new_platform/static/canvas/images/4_Keys.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2959, 2260, 11, 100, NULL, NULL, 'Share the following with your mentor.<ul><li>What is your personal definition of college readiness? In your opinion, what skills are most important?</li><li>What’s one thing from the LIVE framework you can start doing this year?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (639, 2957, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (640, 2959, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (601, 2956, 635, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (602, 2956, 636, TRUE, 200, 0);

--10.8.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (407, 5, 143, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE College Ready Now');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1303, 407, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1304, 407, 2, 2, 3, 200, 'What is college readiness?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1305, 407, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2261, 1303, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2262, 1303, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2263, 1304, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2264, 1305, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2960, 2261, 11, 100, NULL, NULL, 'Your mentor responded to your self-assessment and shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2961, 2262, 11, 100, NULL, NULL, 'Respond to your mentor’s personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2962, 2263, 9, 100, NULL, '/new_platform/static/canvas/images/4_Keys.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2963, 2264, 11, 100, NULL, NULL, 'Share the following with your mentor.<ul><li>What is your personal definition of college readiness? In your opinion, what skills are most important?</li><li>What’s one thing from the LIVE framework you can start doing this year?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (641, 2961, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (642, 2963, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (603, 2960, 635, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (604, 2960, 636, TRUE, 200, 0);

--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1UYptECnW7_m8j4FE3ND1ufG5fTZfwrPuXRKeuMRUZsU', 'Mentor LIVE Framework');

--10.8.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (408, 4, 143, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE College Ready Now');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1306, 408, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1307, 408, 2, 2, 3, 200, 'Now it’s your turn…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1308, 408, 2, 3, 3, 300, 'LIVE Summer');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2265, 1306, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2266, 1306, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2267, 1307, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2268, 1307, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2269, 1308, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2964, 2265, 11, 100, NULL, NULL, 'Although the college process may feel far away, the process for getting ready starts now. The skills needed to graduate from high school ready to succeed in college, are skills that need to be built and improved over time.<p><p>In this lesson, your mentee explored one definition of college readiness. Review that definition below.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2965, 2265, 9, 200, NULL, '/new_platform/static/canvas/images/4_Keys.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2966, 2266, 11, 100, NULL, NULL, 'If you think there’s a lot there, you are right! To be truly college ready, your mentee will need to build knowledge and skills in more than one area. However, thinking about all of these skills at once can be overwhelming. To help your mentee narrow down a list of possible action steps, we introduced the LIVE Framework.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2967, 2266, 9, 200, NULL, '/new_platform/static/canvas/images/LIVE_Framework.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2968, 2267, 11, 100, NULL, NULL, 'Your mentee shared the following with you:<ul><li>Their personal definition of college readiness.</li><li>One thing from the LIVE framework that can start doing now.</li><li>Response to your personal update.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2969, 2268, 11, 100, NULL, NULL, 'Respond to your mentee. Any feedback or advice on their definition of college readiness or LIVE action step?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2970, 2269, 11, 100, NULL, NULL, 'Next week, your mentee will use the LIVE framework to plan for their summer. They will be asked to think about how they can use their summer to grow, build skills, and learn.<p><p>Help your mentee by providing them with an example. Complete the template below for you plan to use your summer to grow in these areas.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2971, 2269, 6, 200, NULL, 'https://docs.google.com/document/d/1UYptECnW7_m8j4FE3ND1ufG5fTZfwrPuXRKeuMRUZsU/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (643, 2969, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (605, 2968, 642, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (606, 2968, 641, TRUE, 200, 0);

--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1rZNeNT-27mV5K_g_oVv4yFjjXF_sMho34Ohv563fwYE', 'Mentee LIVE Framework');

--10.8.5 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (144, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 34, 5, NULL, 'LIVE During the Summer', '/new_platform/static/canvas/images/10.8.5.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (409, 1, 144, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE During the Summer');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1309, 409, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1310, 409, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1311, 409, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1312, 409, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2270, 1309, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2271, 1309, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2272, 1310, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2273, 1311, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2274, 1312, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2275, 1312, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2276, 1312, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2972, 2270, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will apply the LIVE framework and explore different ways to use their summers to advance their short- and long-term goals.<p><p>In this lesson, mentees will:<ul><li>Review 4 Keys college readiness and LIVE frameworks.</li><li>Apply frameworks to identify ideas for how they might use their summer to advance their short- and long-term goals.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-summer-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2973, 2271, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2974, 2271, 6, 200, NULL, 'https://docs.google.com/presentation/d/1JllsnNbijTKsfdDqAr3KKGzwctjlJ7lI8TRRElpTEyU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2975, 2272, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2976, 2273, 11, 100, NULL, NULL, 'Your mentor responded to your personal update and definition of college readiness.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2977, 2274, 11, 100, NULL, NULL, 'To help you get started, your mentor completed their own Summer LIVE template. Review their summer plans before starting yours.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2978, 2274, 6, 200, NULL, 'https://docs.google.com/document/d/1UYptECnW7_m8j4FE3ND1ufG5fTZfwrPuXRKeuMRUZsU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2979, 2275, 11, 100, NULL, NULL, 'Complete your own LIVE tool.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2980, 2275, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rZNeNT-27mV5K_g_oVv4yFjjXF_sMho34Ohv563fwYE/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2981, 2276, 11, 100, NULL, NULL, 'Tell your mentor what you are most looking forward to this summer. What one item from your LIVE form are you most excited about?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (644, 2981, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (607, 2976, 643, TRUE, 100, 0);

--10.8.5 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (410, 5, 144, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE During the Summer');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1313, 410, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1314, 410, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2277, 1313, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2278, 1314, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2279, 1314, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2280, 1314, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2982, 2277, 11, 100, NULL, NULL, 'Your mentor responded to your personal update and definition of college readiness.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2983, 2278, 11, 100, NULL, NULL, 'To help you get started, your mentor completed their own Summer LIVE template. Review their summer plans before starting yours.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2984, 2278, 6, 200, NULL, 'https://docs.google.com/document/d/1UYptECnW7_m8j4FE3ND1ufG5fTZfwrPuXRKeuMRUZsU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2985, 2279, 11, 100, NULL, NULL, 'Complete your own LIVE tool.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2986, 2279, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rZNeNT-27mV5K_g_oVv4yFjjXF_sMho34Ohv563fwYE/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2987, 2280, 11, 100, NULL, NULL, 'Tell your mentor what you are most looking forward to this summer. What one item from your LIVE form are you most excited about?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (645, 2987, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (608, 2982, 643, TRUE, 100, 0);

--10.8.5 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (411, 4, 144, '6/26/15 00:00:00', '6/26/15 23:59:59', 'LIVE During the Summer');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1315, 411, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1316, 411, 2, 2, 2, 200, 'Support your mentee through the summer');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2281, 1315, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2282, 1316, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2988, 2281, 11, 100, NULL, NULL, 'Your mentee reviewed the college readiness and LIVE frameworks in class. After doing so, they completed their own LIVE framework about their summer plans and shared what they are most looking forward to this summer.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2989, 2281, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1rZNeNT-27mV5K_g_oVv4yFjjXF_sMho34Ohv563fwYE/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2990, 2282, 11, 100, NULL, NULL, 'Don’t let completing this tool be the only time you and your mentee check in about the summer. Here are some tips for checking in about and during the summer months:<ul><li>As summer approaches, revisit this list during a lesson or event. Be sure to encourage your mentee to think strategically about how to use their summer productively.</li><li>Make plans to check in during the summer. If you’re both around, meeting once or twice would be great way to make sure you aren’t losing any momentum you build this year. If you both aren’t around, email/text/call.</li></ul>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (609, 2989, 645, TRUE, 100, 0);

--9.7.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (36, 7, 'Social Capital Skills', 'social_capital_skills', 'Who and what is in your social network?<p>What can you do to make it stronger?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (36, 1, 36, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What can you do to improve your social capital skills?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What can you do to improve your social capital skills?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (145, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 36, 1, NULL, 'What is social capital?', '/new_platform/static/canvas/images/9.7.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (412, 1, 145, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is social capital?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1317, 412, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1318, 412, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1319, 412, 2, 1, 1, 300, 'Defining social capital');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2283, 1317, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2284, 1317, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2285, 1318, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2286, 1319, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2991, 2283, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the concept and importance of developing social capital skills to mentees.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define social capital in their own words.</li><li>Differentiate between bonding vs bridging networks.</li><li>Complete a template to identify individuals or groups that may belong to either.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/what-is-social-capital-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2992, 2284, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2993, 2284, 6, 200, NULL, 'https://docs.google.com/presentation/d/1aO5puvMxOBSGRWu4Vlp0S-x4OOntn_unxAUCnvSI0os/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2994, 2285, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2995, 2286, 9, 100, NULL, '/new_platform/static/canvas/images/Social_Capital.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2996, 2286, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>How would you define “social-capital” in your own words?</li><li>Share about a time when you used social capital skills to achieve something in school or your personal life?<ul  style="list-style-type: circle"><li>Who did you have the relationship with?</li><li>What did you give that person?</li><li>What did you gain from that person?</li></ul></li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (646, 2996, 100, 0, 2);

--9.7.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (413, 5, 145, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is social capital?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1320, 413, 2, 1, 1, 100, 'Defining social capital');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2287, 1320, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2997, 2287, 9, 100, NULL, '/new_platform/static/canvas/images/Social_Capital.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2998, 2287, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>How would you define “social-capital” in your own words?</li><li>Share about a time when you used social capital skills to achieve something in school or your personal life?<ul  style="list-style-type: circle"><li>Who did you have the relationship with?</li><li>What did you give that person?</li><li>What did you gain from that person?</li></ul></li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (647, 2998, 100, 0, 2);

--9.7.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (414, 4, 145, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is social capital?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1321, 414, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2288, 1321, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2289, 1321, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2290, 1321, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2999, 2288, 11, 100, NULL, NULL, 'Your mentee learned about social capital and the importance of building social capital skills. Click through the slides below to learn more.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3000, 2288, 6, 200, NULL, 'https://docs.google.com/presentation/d/1KKT-fy6cGjoThEew_jvy9zOkeGJFqTE-_nDGAhaSqc4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3001, 2289, 11, 100, NULL, NULL, 'They defined social capital in their own words and shared an experience when they used social capital skills and relied on their relationships to achieve something in their personal or school life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3002, 2290, 11, 100, NULL, NULL, 'Respond to your mentee.<p><p>Consider the following as you respond:<ul><li>How have you used social capital skills in your personal or professional life?<ul  style="list-style-type: circle"><li>Who did you have the relationship with?</li><li>What did you give that person?</li><li>What did you gain from that person?</li></ul></li></ul></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (648, 3002, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (610, 3001, 647, TRUE, 100, 0);

--9.7.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (146, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 36, 2, NULL, 'Social Capital Skills in Action', '/new_platform/static/canvas/images/9.7.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (415, 1, 146, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Capital Skills in Action');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1322, 415, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1323, 415, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1324, 415, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1325, 415, 2, 2, 2, 400, 'Who would you like to meet?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2291, 1322, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2292, 1322, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2293, 1323, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2294, 1324, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2295, 1324, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2296, 1325, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3003, 2291, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will apply what they learned about social capital skills in the prior lesson to achieve specific tasks.<p><p>In this lesson, mentees will:<ul><li>Review the definition of social capital</li><li>Identify members in their networks who can provide learning opportunities for colleges and careers</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/social-capital-skills-in-action" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3004, 2292, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3005, 2292, 6, 200, NULL, 'https://docs.google.com/presentation/d/1JC9PlO8vmNRu9VM0nzyKr1sS_Nbd_qvZXQ-308AxAWw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3006, 2293, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3007, 2294, 11, 100, NULL, NULL, 'Your mentor described a time they used their social capital skills.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3008, 2295, 11, 100, NULL, NULL, 'Having strong relationships makes it easier to rely on your social network. Ask your mentor some questions to learn more about their relationships with the people in their story. For example:<ul><li>How long did they know this person?</li><li>Where did they meet?</li><li>What actions did they take to build the relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3009, 2296, 11, 100, NULL, NULL, 'Tell your mentor about two people from a bonded or bridged network you’d like to learn more from. What would you like to learn? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (649, 3008, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (650, 3009, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (611, 3007, 648, TRUE, 100, 0);

--9.7.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (416, 5, 146, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Capital Skills in Action');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1326, 416, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1327, 416, 2, 2, 2, 200, 'Who would you like to meet?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2297, 1326, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2298, 1326, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2299, 1327, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3010, 2297, 11, 100, NULL, NULL, 'Your mentor described a time they used their social capital skills.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3011, 2298, 11, 100, NULL, NULL, 'Having strong relationships makes it easier to rely on your social network. Ask your mentor some questions to learn more about their relationships with the people in their story. For example:<ul><li>How long did they know this person?</li><li>Where did they meet?</li><li>What actions did they take to build the relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3012, 2299, 11, 100, NULL, NULL, 'Tell your mentor about two people from a bonded or bridged network you’d like to learn more from. What would you like to learn? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (651, 3011, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (652, 3012, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (612, 3010, 648, TRUE, 100, 0);

--Update the unit description

UPDATE canvas_unit_info
SET secondary_description = 'What is self-advocacy?<p>How can I advocate for myself in high school?</p>'
WHERE id = 33;

--9.7.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (417, 4, 146, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Capital Skills in Action');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1328, 417, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1329, 417, 2, 2, 2, 200, 'Building your mentee’s network');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2300, 1328, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2301, 1328, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2302, 1329, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2303, 1329, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3013, 2300, 11, 100, NULL, NULL, 'Your mentee read and responded to your example of social capital skills.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3014, 2301, 11, 100, NULL, NULL, 'Respond to your mentee. Answer their questions and provide any final thoughts on your example.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3015, 2302, 11, 100, NULL, NULL, 'Your mentee shared people from their network they could learn from, what they want to learn and why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3016, 2303, 11, 100, NULL, NULL, 'Respond to your mentee. Offer suggestions for how they can build these relationships and what next steps they could take to connect with these people.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (653, 3014, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (654, 3016, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (613, 3013, 651, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (614, 3015, 652, TRUE, 100, 0);

--9.6.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (37, 6, 'Future Focused', 'Career_Exploration', 'What would you attempt to do if you knew you could not fail?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (37, 1, 37, '<ul><li>What would you attempt to do if you knew you could not fail? Why?</li></ul>', '<ul><li>What would you attempt to do if you knew you could not fail? Why?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (147, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 37, 1, NULL, 'Treasure Hunters and Trash Collectors', '/new_platform/static/canvas/images/9.6.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (418, 1, 147, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Treasure Hunters and Trash Collectors');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1330, 418, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1331, 418, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1332, 418, 2, 1, 2, 300, 'Read the following story');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1333, 418, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2304, 1330, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2305, 1330, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2306, 1331, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2307, 1332, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2308, 1333, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3017, 2304, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit, mentees will be introduced to optimism, its qualities and the role it will play in their future. In this lesson, mentees will review the definition of optimism and assess their own approach and perspective using the optimism/pessimism lens.<p><p>In this lesson, mentees will:<ul><li>Define optimism.</li><li>Read and summarize a story about optimism vs pessimism.</li><li>Identify three things they feel good about and explain why.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/treasure-hunter-trash-collector" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3018, 2305, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3019, 2305, 6, 200, NULL, 'https://docs.google.com/presentation/d/1XhEPeUp727eRO_zXvjZVLIaWWCEkyBBreuQZMO_Fozk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3020, 2306, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3021, 2307, 9, 100, NULL, '/new_platform/static/canvas/images/Short_Story.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3022, 2308, 11, 100, NULL, NULL, 'Tell your mentor three things in your life that you feel good about and why.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (655, 3022, 100, 0, 2);

--9.6.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (419, 5, 147, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Treasure Hunters and Trash Collectors');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1334, 419, 2, 1, 2, 100, 'Read the following story');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1335, 419, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2309, 1334, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2310, 1335, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3023, 2309, 9, 100, NULL, '/new_platform/static/canvas/images/Short_Story.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3024, 2310, 11, 100, NULL, NULL, 'Tell your mentor three things in your life that you feel good about and why.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (656, 3024, 100, 0, 2);

--9.6.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (420, 4, 147, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Treasure Hunters and Trash Collectors');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1336, 420, 2, 2, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1337, 420, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2311, 1336, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2312, 1336, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2313, 1336, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2314, 1336, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2315, 1337, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3025, 2311, 11, 100, NULL, NULL, 'Your mentee discussed the difference between optimism and pessimism using the following short story.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3026, 2312, 9, 100, NULL, '/new_platform/static/canvas/images/Short_Story.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3027, 2313, 11, 100, NULL, NULL, 'Learn more about the importance of cultivating optimism as a practice by clicking <a href="http://www.edutopia.org/blog/cultivating-practical-optimism-donna-wilson" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3028, 2314, 11, 100, NULL, NULL, 'Your mentee identified areas in their life they feel good about and why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3029, 2315, 11, 100, NULL, NULL, 'Optimism is something that you can intentionally cultivate.<ul><li>Respond to your mentee by explaining the role that optimism has played in your personal or professional life.</li><li>Share a time where you intentionally shifted your perspective to be more optimistic. What were the results?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (657, 3029, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (615, 3028, 656, TRUE, 100, 0);