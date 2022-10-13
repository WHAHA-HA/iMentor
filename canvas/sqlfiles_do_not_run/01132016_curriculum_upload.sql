--Unit Icon Updates

UPDATE canvas_unit_info
SET featured_image = 'college_visit'
WHERE id = 26;

UPDATE canvas_unit_info
SET featured_image = 'college_fit'
WHERE id = 28;

UPDATE canvas_unit_info
SET featured_image = 'intro_to_fafsa'
WHERE id = 29;

--12.7.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (32, 7, 'College vs High School', NULL, 'How is high school different from college?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (32, 4, 32, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How will you apply what you''ve learned this year?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How will you apply what you''ve learned this year?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (126, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 32, 1, NULL, 'Succeeding in College', '/new_platform/static/canvas/images/12.7.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (357, 1, 126, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Succeeding in College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1163, 357, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1164, 357, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1165, 357, 2, 1, 3, 400, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1166, 357, 2, 2, 3, 500, 'How to succeed in college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1167, 357, 2, 3, 3, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2042, 1163, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2043, 1163, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2044, 1164, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2045, 1165, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2046, 1166, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2047, 1167, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2048, 1167, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2680, 2042, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to strategies for how to be successful in college.<p><p>In this lesson, mentees will:<ul><li>Read and discuss an article that describes nine tips for succeeding in college</li><li>Apply their understanding of the strategies to create definitions, taglines, and images to help them and their peers retain the information</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-college" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2681, 2043, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2682, 2043, 6, 200, NULL, 'https://docs.google.com/presentation/d/1yAdRU3kEcOBCNGlvvA92hkAw_1xOoyRgqSLvotA8q40/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2683, 2044, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2684, 2045, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2685, 2046, 11, 100, NULL, NULL, 'Read the article, “Tip Sheet: How to Succeed in College”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2686, 2046, 8, 200, NULL, '/new_platform/static/canvas/documents/How_To_Succeed_In_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2687, 2047, 11, 100, NULL, NULL, 'Share what you worked on in class with your mentor. What strategy did you work on? What did you create to help you and your classmates remember that strategy?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2688, 2048, 11, 100, NULL, NULL, 'Share a personal update with your mentor. How is your senior year going? Hear any news from colleges?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (571, 2687, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (572, 2688, 100, 0, 2);

--12.7.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (358, 5, 126, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Succeeding in College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1168, 358, 2, 1, 3, 100, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1169, 358, 2, 2, 3, 200, 'How to succeed in college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1170, 358, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2049, 1168, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2050, 1169, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2051, 1170, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2052, 1170, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2689, 2049, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2690, 2050, 11, 100, NULL, NULL, 'Read the article, “Tip Sheet: How to Succeed in College”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2691, 2050, 8, 200, NULL, '/new_platform/static/canvas/documents/How_To_Succeed_In_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2692, 2051, 11, 100, NULL, NULL, 'Share what you worked on in class with your mentor. What strategy did you work on? What did you create to help you and your classmates remember that strategy?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2693, 2052, 11, 100, NULL, NULL, 'Share a personal update with your mentor. How is your senior year going? Hear any news from colleges?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (573, 2692, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (574, 2693, 100, 0, 2);

--12.7.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (359, 4, 126, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Succeeding in College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1171, 359, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1172, 359, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2053, 1171, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2054, 1172, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2055, 1172, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2694, 2053, 11, 100, NULL, NULL, 'During class, your mentee discussed the importance of not just getting into college, but successfully completing college. The article they read is below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2695, 2053, 8, 200, NULL, '/new_platform/static/canvas/documents/How_To_Succeed_In_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2696, 2054, 11, 100, NULL, NULL, 'After reading and discussing the article on tips for succeeding in college, your mentee created a visual or tagline to make a specific strategy “stick”. Read about what your mentee created in class and share your feedback.<ul><li>What can you add to the strategy they shared?</li><li>What other strategies or tips do you want to share with your mentee?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2697, 2055, 11, 100, NULL, NULL, 'Your mentee shared a personal update. Read their update and share one of your own. If you haven’t checked in on the college process, please do so.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (575, 2696, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (576, 2697, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (546, 2696, 573, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (547, 2697, 574, TRUE, 100, 0);

--12.7.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (127, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 32, 2, NULL, 'College vs High School', '/new_platform/static/canvas/images/12.7.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (360, 1, 127, '6/26/15 00:00:00', '6/26/15 23:59:59', 'College vs High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1173, 360, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1174, 360, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1175, 360, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1176, 360, 2, 2, 3, 400, 'Understanding the differences between high school and college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1177, 360, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2056, 1173, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2057, 1173, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2058, 1174, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2059, 1175, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2060, 1176, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2061, 1177, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2698, 2056, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson explores the academic and social differences between high school and college.<p><p>In this lesson, mentees will:<ul><li>Read and review a list of differences between high school and college</li><li>Categorize each item as either academic or social</li><li>Identify major trends in each category and create strategies or approaches to prepare for these differences</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/college-vs-high-school" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2699, 2057, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2700, 2057, 6, 200, NULL, 'https://docs.google.com/presentation/d/1sviquMcih6h99Jy3x2K-QC04_k2D4jOFOUewZNzeDNE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2701, 2058, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2702, 2059, 11, 100, NULL, NULL, 'Your mentor responded to your tips for college success, added to the ones you shared, and shared tips and strategies of their own. They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2703, 2060, 11, 100, NULL, NULL, 'So how similar or different are high school and college really? Read the list below and review potential differences you may experience in college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2704, 2060, 8, 200, NULL, '/new_platform/static/canvas/documents/40_Potential_Differences.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2705, 2061, 11, 100, NULL, NULL, 'Share the following with your mentor about the differences between high school and college:<ul><li>What differences are you most excited about? Why?</li><li>What differences are you most nervous about? Why?</li><li>What can you do now to help you prepare for the transition to life after high school?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (577, 2705, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (548, 2702, 575, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (549, 2702, 576, TRUE, 200, 0);

--12.7.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (361, 5, 127, '6/26/15 00:00:00', '6/26/15 23:59:59', 'College vs High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1178, 361, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1179, 361, 2, 2, 3, 200, 'Understanding the differences between high school and college');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1180, 361, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2062, 1178, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2063, 1179, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2064, 1180, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2706, 2062, 11, 100, NULL, NULL, 'Your mentor responded to your tips for college success, added to the ones you shared, and shared tips and strategies of their own. They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2707, 2063, 11, 100, NULL, NULL, 'So how similar or different are high school and college really? Read the list below and review potential differences you may experience in college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2708, 2063, 8, 200, NULL, '/new_platform/static/canvas/documents/40_Potential_Differences.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2709, 2064, 11, 100, NULL, NULL, 'Share the following with your mentor about the differences between high school and college:<ul><li>What differences are you most excited about? Why?</li><li>What differences are you most nervous about? Why?</li><li>What can you do now to help you prepare for the transition to life after high school?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (578, 2709, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (550, 2706, 575, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (551, 2706, 576, TRUE, 200, 0);

--12.7.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (362, 4, 127, '6/26/15 00:00:00', '6/26/15 23:59:59', 'College vs High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1181, 362, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1182, 362, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2065, 1181, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2066, 1182, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2067, 1182, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2710, 2065, 11, 100, NULL, NULL, 'This class was all about the difference between high school and college. To help them get started on thinking on the many potential differences, your mentee reviewed the list below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2711, 2065, 8, 200, NULL, '/new_platform/static/canvas/documents/40_Potential_Differences.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2712, 2066, 11, 100, NULL, NULL, 'After reviewing the list, your mentee categorized the major differences and shared the differences they are most excited about, most nervous about, and ways they can start preparing for the transition after high school.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2713, 2067, 11, 100, NULL, NULL, 'Respond to what your mentee shared.<ul><li>What stands out to you about what excites them and makes the nervous?</li><li>What difference between high school and college stood out to you in your experience?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (579, 2713, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (552, 2712, 578, TRUE, 100, 0);

--11.10.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (128, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 29, 3, NULL, 'FAFSA Action Plan', '/new_platform/static/canvas/images/11.10.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (363, 1, 128, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Action Plan');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1183, 363, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1184, 363, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1185, 363, 2, 1, 3, 300, 'What do I need to do before I start my application?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1186, 363, 2, 2, 3, 400, 'What is my dependency status?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1187, 363, 2, 3, 3, 500, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2068, 1183, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2069, 1183, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2070, 1183, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2071, 1184, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2072, 1185, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2073, 1186, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2074, 1187, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2075, 1187, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2076, 1187, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2714, 2068, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Completing the FAFSA properly requires many steps and pieces of information. This lesson will help mentees prepare early by identifying the information and documents they need to collect, steps they need to complete, questions they need to answer, and people they need to talk to before filing their application.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify the steps they need to complete and pieces of information they need to collect prior to starting their application.</li><li>Define and determine their dependency status.</li><li>Understand how their dependency status impacts the information they will need in order to file their FAFSA.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/fafsa-action-plan" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2715, 2069, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2716, 2069, 6, 200, NULL, 'https://docs.google.com/presentation/d/1qb97lSa8AK8RvkggHjVqXN_OCi2NdHIonjizWw0buLw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2717, 2070, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2718, 2070, 3, 200, NULL, 'https://vimeo.com/151063046', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2719, 2071, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2720, 2072, 11, 100, NULL, NULL, 'As you watch the video, answer the following questions:<ul><li>What steps do you need to complete before starting your application?</li><li>What information or documents do you need to collect before starting your application?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2721, 2072, 3, 200, NULL, 'https://vimeo.com/151063046', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2722, 2073, 11, 100, NULL, NULL, 'You need to know what your dependency status is before starting your FAFSA since it does impact what information you need to successfully complete the application.<p><p>Use the infographic below to help you determine your dependency status.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2723, 2073, 9, 200, NULL, '/new_platform/static/canvas/images/Dependency_Status.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2724, 2074, 11, 100, NULL, NULL, 'Your mentor shared feedback on your myth vs reality comments. They also shared their personal experiences with loans.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2725, 2075, 11, 100, NULL, NULL, 'Write to your mentor.<ul><li>Do you know where to get all the information you need to complete the FAFSA? If not, ask your mentor where you might find that information.</li><li>Do you expect to run into challenges getting the information you need? If so, what are they?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2726, 2076, 11, 100, NULL, NULL, 'Share a personal update with your mentor. How’s the college list process going?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (580, 2725, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (581, 2726, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (553, 2724, 570, TRUE, 100, 0);

--11.10.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (364, 5, 128, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Action Plan');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1188, 364, 2, 1, 3, 100, 'What do I need to do before I start my application?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1189, 364, 2, 2, 3, 200, 'What is my dependency status?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1190, 364, 2, 3, 3, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2077, 1188, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2078, 1189, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2079, 1190, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2080, 1190, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2081, 1190, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2727, 2077, 11, 100, NULL, NULL, 'As you watch the video, answer the following questions:<ul><li>What steps do you need to complete before starting your application?</li><li>What information or documents do you need to collect before starting your application?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2728, 2077, 3, 200, NULL, 'https://vimeo.com/151063046', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2729, 2078, 11, 100, NULL, NULL, 'You need to know what your dependency status is before starting your FAFSA since it does impact what information you need to successfully complete the application.<p><p>Use the infographic below to help you determine your dependency status.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2730, 2078, 9, 200, NULL, '/new_platform/static/canvas/images/Dependency_Status.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2731, 2079, 11, 100, NULL, NULL, 'Your mentor shared feedback on your myth vs reality comments. They also shared their personal experiences with loans.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2732, 2080, 11, 100, NULL, NULL, 'Write to your mentor.<ul><li>Do you know where to get all the information you need to complete the FAFSA? If not, ask your mentor where you might find that information.</li><li>Do you expect to run into challenges getting the information you need? If so, what are they?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2733, 2081, 11, 100, NULL, NULL, 'Share a personal update with your mentor. How’s the college list process going?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (582, 2732, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (583, 2733, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (554, 2731, 570, TRUE, 100, 0);

--11.10.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (365, 4, 128, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Action Plan');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1191, 365, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1192, 365, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2082, 1191, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2083, 1191, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2084, 1192, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2085, 1192, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2086, 1192, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2734, 2082, 11, 100, NULL, NULL, 'Now that your mentee has been introduced to the FAFSA, how loans work, and the general financial aid process, it’s time to start thinking about what they need to do and collect before starting the application.<p><p>Please watch the following video to familiarize yourself with the steps they need to complete before starting the FAFSA.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2735, 2082, 3, 200, NULL, 'https://vimeo.com/151063046', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2736, 2083, 11, 100, NULL, NULL, 'Before starting the FAFSA, your mentee needs to know what their dependency status is. If your mentee is an independent student, they may not need to enter their parents’ information. Review the infographic below to understand the difference between dependent and independent students.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2737, 2083, 9, 200, NULL, '/new_platform/static/canvas/images/Dependency_Status.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2738, 2084, 11, 100, NULL, NULL, 'Before formally starting their FAFSA their senior year, your mentee will need to do the following or have the following pieces of information:<ul><li>Create FSA ID</li><li>Social security # (and parents if dependent)</li><li>Driver’s license # (if they have one, or Alien registration # if not a US citizen)</li><li>Tax records (and parents if dependent)</li><li>List of colleges they are planning to apply to (67% of students only list one school on the FAFSA. Don’t let your mentee make this mistake).</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2739, 2085, 11, 100, NULL, NULL, 'Your mentee shared their concerns or expected challenges for the FAFSA prep process with you. They also shared an update on how things are going.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2740, 2086, 11, 100, NULL, NULL, 'Respond to your mentee. If they asked you questions or expressed concerns about the FAFSA prep process, answer them to the best of your ability. Remember, if you are not sure how to respond to a financial aid question, you can always reach out to your staff member.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (584, 2740, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (555, 2739, 582, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (556, 2739, 583, TRUE, 200, 0);

--11.10.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (129, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 29, 4, NULL, 'Summer Plans', '/new_platform/static/canvas/images/11.10.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (366, 1, 129, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1193, 366, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1194, 366, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1195, 366, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1196, 366, 2, 2, 2, 400, 'My summer plans');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2087, 1193, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2088, 1193, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2089, 1194, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2090, 1195, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2091, 1196, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2741, 2087, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Mentees will recap and review the year and share their summer plans with their mentors.<p><p>In this lesson, mentees will:<ul><li>Share their summer plans with their mentor.</li><li>Complete their end of year survey (if applicable).</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-survey-11" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2742, 2088, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2743, 2088, 6, 200, NULL, 'https://docs.google.com/presentation/d/1z8ZQOrByJg-OQli-JxvNIyHsThdPXwJe8Q8NVFMM3S0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2744, 2089, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2745, 2090, 11, 100, NULL, NULL, 'Your mentor responded to your questions and concerns about the FAFSA prep process. Read their comments and respond.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2746, 2091, 11, 100, NULL, NULL, 'Mentees, share your summer plans with your mentor.<ul><li>What are you looking forward to doing over the summer?</li><li>What’s one thing you have to do to prepare for the college process?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (585, 2745, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (586, 2746, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (557, 2745, 584, TRUE, 100, 0);

--11.10.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (367, 5, 129, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1197, 367, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1198, 367, 2, 2, 2, 200, 'My summer plans');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2092, 1197, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2093, 1198, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2747, 2092, 11, 100, NULL, NULL, 'Your mentor responded to your questions and concerns about the FAFSA prep process. Read their comments and respond.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2748, 2093, 11, 100, NULL, NULL, 'Mentees, share your summer plans with your mentor.<ul><li>What are you looking forward to doing over the summer?</li><li>What’s one thing you have to do to prepare for the college process?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (587, 2747, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (588, 2748, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (558, 2747, 584, TRUE, 100, 0);

--11.10.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (368, 4, 129, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Summer Plans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1199, 368, 2, 1, 1, 100, 'Supporting your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2094, 1199, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2095, 1199, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2749, 2094, 11, 100, NULL, NULL, 'Leading up to your mentee’s senior year, you should do the following to help them prepare for the college process:<ul><li><b>Refine and complete their college list.</b> Once their senior begins, your mentee should have a complete or near complete list. Based on where your mentee is now, you may want to check in during your personal updates and/or reach out over the summer.</li><li><b>Complete steps and gather information to complete the FAFSA.</b> Don’t let your mentee put this off till the last minute. Having conversations with their parents, creating an FSA ID, and gathering all the documents early will decrease the chances your mentee feels overwhelmed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2750, 2095, 11, 100, NULL, NULL, 'Your mentee:<ul><li>Reviewed this unit on the FAFSA and responded to your comments.</li><li>Discussed their summer plans and shared them with you.</li></ul>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (559, 2750, 587, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (560, 2750, 588, TRUE, 200, 0);