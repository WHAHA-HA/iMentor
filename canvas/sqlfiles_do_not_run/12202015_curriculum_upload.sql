--11.6.1 Lesson Update

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/11.6.1.jpg'
WHERE id = 111;

--12.9.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (27, 9, 'Choosing the Right College', 'choose_the_right_college', 'What college is right for me?<p>How do I know?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (27, 4, 27, '<ul><li>How have you grown personally this year?</li><li>How have you grown as a pair this year?</li></ul>', '<ul><li>How have you grown personally this year?</li><li>How have you grown as a pair this year?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (112, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 27, 1, NULL, 'My Plan After High School', '/new_platform/static/canvas/images/12.9.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (315, 1, 112, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Plan After High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1021, 315, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1022, 315, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1023, 315, 2, 1, 2, 300, 'The road less traveled');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1024, 315, 2, 2, 2, 400, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1828, 1021, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1829, 1021, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1830, 1022, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1831, 1023, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1832, 1023, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1833, 1024, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1834, 1024, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2408, 1828, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />As mentees progress through the college admissions process and begin to weigh their options, it is important that they pursue making a "good" or "best" decision, not the "right" decision. This lesson will help mentees understand the difference between the two sets of decision-making strategies and how to apply them to their personal college admissions process.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Discuss and understand the difference between making the "best" possible decision vs making the "right" decision in the college and post-high school process</li><li>Use case studies to apply a "best vs. right" decision-making approach</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-postsecondary-path" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2409, 1829, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2410, 1829, 6, 200, NULL, 'https://docs.google.com/presentation/d/1JqYSebx9SoSSXm02LGKLmA6TXo7yTv04Bw7RiZxYg38/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2411, 1830, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2412, 1831, 9, 100, NULL, '/new_platform/static/canvas/images/Frost_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2413, 1832, 9, 100, NULL, '/new_platform/static/canvas/images/Right_vs_Best_Choice.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2414, 1832, 11, 200, NULL, NULL, '<ul><li>Is there ever just one “right” road?</li><li>When is the road less traveled the right one?</li><li>When is the road less traveled the wrong one?</li><li>What is the difference between trying to choose the “right” college and choosing the “best” college for you?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2415, 1833, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2416, 1834, 11, 100, NULL, NULL, 'Share your long term goals with your mentor. How should they guide your decision on what to do after high school?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (509, 2415, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (510, 2416, 100, 0, 2);

--12.9.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (316, 5, 112, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Plan After High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1025, 316, 2, 1, 2, 100, 'The road less traveled');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1026, 316, 2, 2, 2, 200, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1835, 1025, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1836, 1025, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1837, 1026, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1838, 1026, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2417, 1835, 9, 100, NULL, '/new_platform/static/canvas/images/Frost_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2418, 1836, 9, 100, NULL, '/new_platform/static/canvas/images/Right_vs_Best_Choice.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2419, 1836, 11, 200, NULL, NULL, '<ul><li>Is there ever just one “right” road?</li><li>When is the road less traveled the right one?</li><li>When is the road less traveled the wrong one?</li><li>What is the difference between trying to choose the “right” college and choosing the “best” college for you?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2420, 1837, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2421, 1838, 11, 100, NULL, NULL, 'Share your long term goals with your mentor. How should they guide your decision on what to do after high school?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (511, 2420, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (512, 2421, 100, 0, 2);

--12.9.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (317, 4, 112, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Plan After High School');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1027, 317, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1028, 317, 2, 2, 3, 200, 'Your role in supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1029, 317, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1839, 1027, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1840, 1027, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1841, 1028, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1842, 1029, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1843, 1029, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2422, 1839, 11, 100, NULL, NULL, 'It is time for your mentee to think about and decide on what they want to do after high school. In this lesson, your mentee discussed the difference between trying to make the “right” or perfect decision vs making the “best” decision for them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2423, 1840, 11, 100, NULL, NULL, 'They used the quote below to discuss and answer the following questions:<ul><li>Is there ever just one “right” road?</li><li>When is the road less traveled the right one?</li><li>When is the road less traveled the wrong one?</li><li>What is the difference between trying to choose the “right” college and choosing the “best” college for you?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2424, 1840, 9, 200, NULL, '/new_platform/static/canvas/images/Frost_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2425, 1841, 11, 100, NULL, NULL, 'Choosing a college and deciding what to do after high school can be difficult. It can be made more difficult if your mentee adds extra pressure by trying to make the perfect or right decision. In many cases, we just don’t know enough to determine if a decision is right or wrong.<p><p>Over the next several weeks and months, your relationship with your mentee will play a critical role in helping to determine what the best road for your mentee might be. It’ll be important that you support, guide, and advise your mentee through the many factors they should consider in order to make the best decision possible.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2426, 1842, 11, 100, NULL, NULL, 'Your mentee shared one high (an event, experience or moment that was positive) and low (an event, experience or moment that was negative)  from last week. Read your mentee’s high and low and share one high and low of your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2427, 1843, 11, 100, NULL, NULL, 'Your mentee shared their long term goals with you and how they think it should guide their decision making process.<p><p>Respond to your mentee. Share a time in your own life when you weren’t sure if you were making the right decision. Were you sure that the college you attended was the right one for you before you got there?</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (513, 2426, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (514, 2427, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (493, 2426, 511, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (494, 2427, 512, TRUE, 100, 0);

--11.8.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (28, 8, 'College Fit', NULL, 'What college is right for me?<p>How will I know?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (28, 3, 28, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (113, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 28, 1, NULL, 'My College Fit: Academic Profile', '/new_platform/static/canvas/images/11.8.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (318, 1, 113, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Academic Profile');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1030, 318, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1031, 318, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1032, 318, 2, 1, 3, 300, 'What is a balanced college list?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1033, 318, 2, 2, 3, 400, 'What are safety, target, and reach schools?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1034, 318, 2, 3, 3, 500, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1844, 1030, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1845, 1030, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1846, 1031, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1847, 1032, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1848, 1033, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1849, 1034, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1850, 1034, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2428, 1844, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the concept of college fit and the many factors students should consider when creating their college list. This lesson will focus on academic fit and how students should understand their own individual safety, target, and reach criteria.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify the various factors they should consider when calculating college fit and creating a college list</li><li>Become familiar with the concepts of safety, target, and reach colleges and understand that a balanced college list should include all three</li><li>Apply what they learned to determine, based on the provided grades and test scores, the appropriate safety, target, and reach colleges</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-fit-academic-profile" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2429, 1845, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2430, 1845, 6, 200, NULL, 'https://docs.google.com/presentation/d/1cAbF8kOFgJ-93qXrsoCsQSUzr2H0oEPs3n88ivr5XbU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2431, 1846, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2432, 1847, 9, 100, NULL, '/new_platform/static/canvas/images/Mentee_College_List.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2433, 1848, 9, 100, NULL, '/new_platform/static/canvas/images/Mentee_Safety_Target_Reach.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2434, 1849, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2435, 1850, 11, 100, NULL, NULL, 'Tell your mentor what matters most to you when thinking about choosing colleges. Are you excited about creating a college list? Why or why not?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (515, 2434, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (516, 2435, 100, 0, 2);

--11.8.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (319, 5, 113, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Academic Profile');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1035, 319, 2, 1, 3, 100, 'What is a balanced college list?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1036, 319, 2, 2, 3, 200, 'What are safety, target, and reach schools?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1037, 319, 2, 3, 3, 300, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1851, 1035, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1852, 1036, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1853, 1037, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1854, 1037, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2436, 1851, 9, 100, NULL, '/new_platform/static/canvas/images/Mentee_College_List.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2437, 1852, 9, 100, NULL, '/new_platform/static/canvas/images/Mentee_Safety_Target_Reach.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2438, 1853, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2439, 1854, 11, 100, NULL, NULL, 'Tell your mentor what matters most to you when thinking about choosing colleges. Are you excited about creating a college list? Why or why not?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (517, 2438, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (518, 2439, 100, 0, 2);

--11.8.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (320, 4, 113, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Academic Profile');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1038, 320, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1039, 320, 2, 2, 3, 200, 'Your role in supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1040, 320, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1855, 1038, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1856, 1039, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1857, 1040, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1858, 1040, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2440, 1855, 11, 100, NULL, NULL, 'Your mentee’s class discussed the concept of “college fit” and the many factors they should consider when creating their college list. They focused the concepts to “safety, target, and reach schools”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2441, 1856, 11, 100, NULL, NULL, 'Over the next several weeks and through to their senior year, you can provide invaluable support to your mentee by helping them create a balanced college list. It is likely that your mentee will not know the answer to or preferences for most or all of these factors.<p><p>Please review the slides below to learn more about a balanced college list, the factors your mentee needs to think about when creating their list, and tools to help along the way.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2442, 1856, 6, 200, NULL, 'https://docs.google.com/presentation/d/1IZhGz3ULOBz5paGpiijSfaKX1IBcL4Th4QH6nFmwapo/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2443, 1857, 11, 100, NULL, NULL, 'Your mentee shared one high (an event, experience or moment that was positive) and low (an event, experience or moment that was negative)  from last week. Read your mentee’s high and low and share one high and low of your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2444, 1858, 11, 100, NULL, NULL, 'Your mentee shared what matters most to them when thinking about selecting colleges to put on their list. Respond to your mentee. Ask them questions.<p><p>Remember, your mentee may not yet have a strong idea for what matters to them or what their personal preferences are.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (519, 2443, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (520, 2444, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (495, 2443, 517, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (496, 2444, 518, TRUE, 100, 0);

--11.10.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (29, 10, 'Introduction to FAFSA', NULL, 'What is the FAFSA?<p>What can I do now to prepare for next year?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (29, 3, 29, '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>', '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (114, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 29, 1, NULL, 'FAFSA Introduction', '/new_platform/static/canvas/images/11.10.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (321, 1, 114, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Introduction');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1041, 321, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1042, 321, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1043, 321, 2, 1, 3, 300, 'What is the FAFSA?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1044, 321, 2, 2, 3, 400, 'How much financial aid will I receive?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1045, 321, 2, 3, 3, 500, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1859, 1041, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1860, 1041, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1861, 1041, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1862, 1042, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1863, 1043, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1864, 1044, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1865, 1045, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1866, 1045, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2445, 1859, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is will introduce mentees to the FAFSA -- what it is, why it is important, and how it is used to calculate their financial need.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Watch and discuss a video that describes an overview of the FAFSA</li><li>Review and understand the FAFSA application process</li><li>Understand the terms "EFC" (expected family contribution), "total cost of attendance", and "financial need"</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/fafsa-introduction" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2446, 1860, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2447, 1860, 6, 200, NULL, 'https://docs.google.com/presentation/d/1aCCc3Hg7bQyJ5CB-qDfKDJ2AqyTZ6iv26CifK-K92ps/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2448, 1861, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2449, 1861, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2450, 1862, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2451, 1863, 3, 100, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2452, 1864, 9, 100, NULL, '/new_platform/static/canvas/images/COA_EFC.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2453, 1864, 11, 200, NULL, NULL, 'Use the <a href="https://fafsa.ed.gov/FAFSA/app/f4cForm" target="_blank">FAFSA4Caster</a> to estimate your eligibility for financial aid.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2454, 1865, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2455, 1866, 11, 100, NULL, NULL, 'Tell your mentor how you feel about paying for college. Are you worried about paying for college? Do you think the process will be challenging?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (521, 2454, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (522, 2455, 100, 0, 2);

--11.10.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (322, 5, 114, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Introduction');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1046, 322, 2, 1, 3, 100, 'What is the FAFSA?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1047, 322, 2, 2, 3, 200, 'How much financial aid will I receive?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1048, 322, 2, 3, 3, 300, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1867, 1046, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1868, 1047, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1869, 1048, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1870, 1048, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2456, 1867, 3, 100, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2457, 1868, 9, 100, NULL, '/new_platform/static/canvas/images/COA_EFC.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2458, 1868, 11, 200, NULL, NULL, 'Use the <a href="https://fafsa.ed.gov/FAFSA/app/f4cForm" target="_blank">FAFSA4Caster</a> to estimate your eligibility for financial aid.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2459, 1869, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2460, 1870, 11, 100, NULL, NULL, 'Tell your mentor how you feel about paying for college. Are you worried about paying for college? Do you think the process will be challenging?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (523, 2459, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (524, 2460, 100, 0, 2);

--11.10.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (323, 4, 114, '6/26/15 00:00:00', '6/26/15 23:59:59', 'FAFSA Introduction');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1049, 323, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1050, 323, 2, 2, 3, 200, 'Your role in supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1051, 323, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1871, 1049, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1872, 1050, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1873, 1050, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1874, 1051, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1875, 1051, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2461, 1871, 11, 100, NULL, NULL, 'This lesson introduced the Free Application for Federal Student Aid (FAFSA) to your mentee: what it is, why it is important, and how it used to calculate their financial need.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2462, 1872, 11, 100, NULL, NULL, 'In 2013, graduating seniors missed out on $2.9 Billion in federal aid. Why? They failed to complete the FAFSA.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2463, 1872, 9, 200, NULL, '/new_platform/static/canvas/images/Pennies.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2464, 1873, 11, 100, NULL, NULL, 'Even though your mentee will not be starting and submitting their FAFSA until next year, you can start your support now by understanding the basics of the FAFSA (video below) and its requirements, process, and deadlines.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2465, 1873, 3, 200, NULL, 'https://vimeo.com/142935656', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2466, 1874, 11, 100, NULL, NULL, 'Your mentee shared one high (an event, experience or moment that was positive) and low (an event, experience or moment that was negative)  from last week. Read your mentee’s high and low and share one high and low of your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2467, 1875, 11, 100, NULL, NULL, 'Your mentee shared their concerns about paying for college and how they feel about the financial aid process. Respond to your mentee.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (525, 2466, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (526, 2467, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (497, 2466, 523, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (498, 2467, 524, TRUE, 100, 0);

--12.6.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (30, 6, 'Finishing Strong', 'finishing_strong', 'What am I doing to finish this year on a high note?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (30, 4, 30, '<ul><li>What was the most stressful thing you dealt with this week?</li><li>How were you able to manage your stress?</li><li>What, if anything, would you do differently next time?</li></ul>', 'Have you had a chance to try a stress management strategy?<ul><li>If so, what did you apply it to and how did it go?</li><li>If not, what’s the next opportunity you’ll have to try one out?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (115, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 30, 1, NULL, 'Exam Prep: ACT and SAT', '/new_platform/static/canvas/images/12.6.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (324, 1, 115, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1052, 324, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1053, 324, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1054, 324, 2, 1, 3, 300, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1055, 324, 2, 2, 3, 400, 'ACT vs SAT');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1056, 324, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1876, 1052, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1877, 1052, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1878, 1053, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1879, 1054, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1880, 1055, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1881, 1056, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1882, 1056, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2468, 1876, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees identify which standardized test they need to take, when they need to take it, and how to acquire prep support if they haven''t already.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Compare and contrast SAT vs ACT</li><li>Register for ACT or SAT (optional)</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/exam-prep" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2469, 1877, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2470, 1877, 6, 200, NULL, 'https://docs.google.com/presentation/d/1TBgkWZ8cZjMbggNmEsgToJ37rz36e6Kxrm34usYtnRA/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2471, 1878, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2472, 1879, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2473, 1880, 11, 100, NULL, NULL, 'Review the infographic to identify the differences between the ACT and SAT.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2474, 1880, 9, 200, NULL, '/new_platform/static/canvas/images/Big_Tests.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2475, 1881, 11, 100, NULL, NULL, '<ul><li>How confident or nervous are you about the test?</li><li>What have you done to prepare for the test? What can you still do to prepare?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2476, 1882, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (527, 2475, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (528, 2476, 100, 0, 2);

--12.6.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (325, 5, 115, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1057, 325, 2, 1, 3, 100, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1058, 325, 2, 2, 3, 200, 'ACT vs SAT');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1059, 325, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1883, 1057, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1884, 1058, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1885, 1059, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1886, 1059, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2477, 1883, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2478, 1884, 11, 100, NULL, NULL, 'Review the infographic to identify the differences between the ACT and SAT.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2479, 1884, 9, 200, NULL, '/new_platform/static/canvas/images/Big_Tests.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2480, 1885, 11, 100, NULL, NULL, '<ul><li>How confident or nervous are you about the test?</li><li>What have you done to prepare for the test? What can you still do to prepare?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2481, 1886, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (529, 2480, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (530, 2481, 100, 0, 2);

--12.6.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (326, 4, 115, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1060, 326, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1061, 326, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1887, 1060, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1888, 1061, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1889, 1061, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2482, 1887, 11, 100, NULL, NULL, 'Your mentee is learning the difference between the ACT and SAT so they can make arrangements to take this important college entrance exam.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2483, 1887, 9, 200, NULL, '/new_platform/static/canvas/images/Big_Tests.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2484, 1888, 11, 100, NULL, NULL, '<ul><li>What tips can you offer to your mentee in terms of preparing for the exam?</li><li>What are some ways your mentee can address their test-taking anxieties?</li><li>What are other techniques you use for managing stress in your everyday life?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2485, 1889, 11, 100, NULL, NULL, 'Your mentee also shared a personal update with you. Respond and share one of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (531, 2484, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (532, 2485, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (499, 2484, 529, TRUE, 100, 1);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (500, 2485, 530, TRUE, 100, 0);

--12.6.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (116, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 30, 2, NULL, 'Fighting Senioritis, Dealing with Stress, Finishing Strong', '/new_platform/static/canvas/images/12.6.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (327, 1, 116, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1062, 327, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1063, 327, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1064, 327, 2, 1, 2, 300, 'Dealing with stress');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1065, 327, 2, 2, 2, 400, 'Update your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1890, 1062, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1891, 1062, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1892, 1062, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1893, 1063, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1894, 1064, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1895, 1064, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1896, 1064, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1897, 1065, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1898, 1065, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2486, 1890, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees identify and define the symptoms of senioritis and explore ways to avoid it.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Watch and assess a mockumentary on senioritis</li><li>Identify the symptoms and characteristics of senioritis</li><li>List strategies for dealing with and/or avoiding senioritis and stress</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/fighting-senioritis" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2487, 1891, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2488, 1891, 6, 200, NULL, 'https://docs.google.com/presentation/d/1uWSs8kmjSzHRgLcfFFuH-So2hs74PEmM97f-Y5aI9Y8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2489, 1892, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2490, 1892, 3, 200, NULL, 'https://vimeo.com/146132346', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2491, 1892, 3, 300, NULL, 'https://vimeo.com/146127036', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2492, 1893, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2493, 1894, 3, 100, NULL, 'https://vimeo.com/146127036', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2494, 1895, 11, 100, NULL, NULL, 'Your mentor shared tips for preparing for exams and managing stress.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2495, 1896, 11, 100, NULL, NULL, '<ul><li>Which of the two, senioritis or stress, do you struggle with more? Why?</li><li>Which of the strategies discussed in class today would you adopt? Why?</li><li>How can your mentor help you deal with senioritis and/or stress for the rest of the year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2496, 1897, 11, 100, NULL, NULL, 'Your mentor shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2497, 1898, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (533, 2495, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (534, 2497, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (501, 2494, 531, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (502, 2496, 532, TRUE, 100, 0);

--12.6.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (328, 5, 116, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1066, 328, 2, 1, 2, 100, 'Dealing with stress');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1067, 328, 2, 2, 2, 200, 'Update your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1899, 1066, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1900, 1066, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1901, 1066, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1902, 1067, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1903, 1067, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2498, 1899, 3, 100, NULL, 'https://vimeo.com/146127036', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2499, 1900, 11, 100, NULL, NULL, 'Your mentor shared tips for preparing for exams and managing stress.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2500, 1901, 11, 100, NULL, NULL, '<ul><li>Which of the two, senioritis or stress, do you struggle with more? Why?</li><li>Which of the strategies discussed in class today would you adopt? Why?</li><li>How can your mentor help you deal with senioritis and/or stress for the rest of the year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2501, 1902, 11, 100, NULL, NULL, 'Your mentor shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2502, 1903, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (535, 2500, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (536, 2502, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (503, 2499, 531, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (504, 2501, 532, TRUE, 100, 0);

--12.6.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (329, 4, 116, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exam Prep: ACT and SAT');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1068, 329, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1904, 1068, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1905, 1068, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1906, 1068, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2503, 1904, 3, 100, NULL, 'https://vimeo.com/146127036', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2504, 1905, 11, 100, NULL, NULL, 'Your mentee discussed senioritis and stress and started making a game plan to deal with each.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2505, 1906, 11, 100, NULL, NULL, 'Your mentee also responded to your update and shared one of their own.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (505, 2504, 535, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (506, 2505, 536, TRUE, 100, 0);

--11.7.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (31, 7, 'Exploring Career Pathways', 'exploring_career_pathways', 'What careers fit my goals and interests?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (31, 3, 31, '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>', '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (117, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 31, 1, NULL, 'Exploring Career Pathways: Part I', '/new_platform/static/canvas/images/11.7.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (330, 1, 117, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part I');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1069, 330, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1070, 330, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1071, 330, 2, 1, 3, 300, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1072, 330, 2, 2, 3, 400, 'Exploring my working style');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1073, 330, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1907, 1069, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1908, 1069, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1909, 1070, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1910, 1071, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1911, 1072, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1912, 1073, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2506, 1907, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This unit and lesson is designed to help mentees identify their career interests and/or their individual work style.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and explore their personal work style or career interests</li><li>Interpret results and assess their accuracy</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/exploring-career-pathways" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2507, 1908, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2508, 1908, 6, 200, NULL, 'https://docs.google.com/presentation/d/1nUXDuEv0CVNkftUfSGxS5jWqWSKsb9-3bLLZiZFXwZ4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2509, 1909, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2510, 1910, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2511, 1911, 11, 100, NULL, NULL, '<ul><li>Take <a href="http://www.quizbox.com/personality/test47.aspx" target="_blank">this</a> quiz to identify your working style.</li><li>Share the results with your mentor by copying them in the box below.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2512, 1912, 11, 100, NULL, NULL, '<ul><li>Do you think the style or category selected is an accurate representation of your interests?</li><li>Did you learn anything about yourself in this activity?</li><li>Do you have specific career goals? What are they and why are they important to you?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (537, 2511, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (538, 2512, 100, 0, 2);

--11.7.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (331, 5, 117, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part I');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1074, 331, 2, 1, 3, 100, 'Reflection');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1075, 331, 2, 2, 3, 200, 'Exploring my working style');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1076, 331, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1913, 1074, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1914, 1075, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1915, 1076, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2513, 1913, 11, 100, NULL, NULL, 'Go to Portfolio and review the lessons of the previous unit. Then write your unit reflection.<p><p><i>Note: Portfolio is available through the menu in the top left corner of this page.</i></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2514, 1914, 11, 100, NULL, NULL, '<ul><li>Take <a href="http://www.quizbox.com/personality/test47.aspx" target="_blank">this</a> quiz to identify your working style.</li><li>Share the results with your mentor by copying them in the box below.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2515, 1915, 11, 100, NULL, NULL, '<ul><li>Do you think the style or category selected is an accurate representation of your interests?</li><li>Did you learn anything about yourself in this activity?</li><li>Do you have specific career goals? What are they and why are they important to you?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (539, 2514, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (540, 2515, 100, 0, 2);

--11.7.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (332, 4, 117, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part I');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1077, 332, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1078, 332, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1916, 1077, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1917, 1078, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1918, 1078, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2516, 1916, 11, 100, NULL, NULL, 'Your mentee discussed their <a href="http://www.quizbox.com/personality/test47.aspx" target="_blank">work style preferences</a> and how these preferences can impact their career choices.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2517, 1917, 11, 100, NULL, NULL, 'Take <a href="http://www.quizbox.com/personality/test47.aspx" target="_blank">this</a> quiz to identify your working style, and then paste your results in the box below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2518, 1918, 11, 100, NULL, NULL, 'Answer the following questions:<ul><li>Do you think the style is an accurate representation of your interests?</li><li>How does your current career connect to your working style?</li><li>How are you alike? How are you different?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (541, 2517, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (542, 2518, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (507, 2516, 539, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (508, 2516, 540, TRUE, 200, 0);

--11.7.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (118, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 31, 2, NULL, 'Exploring Career Pathways: Part II', '/new_platform/static/canvas/images/11.7.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (333, 1, 118, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1079, 333, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1080, 333, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1081, 333, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1082, 333, 2, 2, 3, 400, 'My Roadmap');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1083, 333, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1919, 1079, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1920, 1079, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1921, 1080, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1922, 1081, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1923, 1081, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1924, 1082, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1925, 1082, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1926, 1083, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2519, 1919, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, students will learn more about their college and career pathway through guided self-exploration and examining the stories of successful business leaders.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on and identify how they want to be defined and what brings them joy</li><li>Create their own road maps on <a href="http://roadtripnation.com/roadmap" target="_blank">Roadtrip Nation</a></li><li>Read short biographies or listen to highlights to complete a profile for one professional</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/exploring-career-pathways-2" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2520, 1920, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2521, 1920, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jrlM8GJx0n8Tm77Pu6uW0H37pB6kC-07qdUsTvcNdR0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2522, 1921, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2523, 1922, 11, 100, NULL, NULL, 'Check out your mentor’s results from the working style quiz you both took:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2524, 1923, 11, 100, NULL, NULL, 'Your mentor shared a reflection on their quiz results with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2525, 1924, 11, 100, NULL, NULL, 'Use the <a href="http://roadtripnation.com/roadmap" target="_blank">Roadtrip Nation</a> website to create a roadmap of your own. Based on your results, please do the following:<ul><li>Listen to 1-2 interview highlights</li><li>Read the short biographies of 1-2 leaders</li><li>Complete the Roadmap Profile for one person you learned about on the website</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2526, 1925, 11, 100, NULL, NULL, 'For a PDF version of the Roadmap Profile click <a href="https://drive.google.com/file/d/0B-7uUglJA5seOXB2ZGxDYm44Z1U/view?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2527, 1926, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What defines you as a person? What brings you joy?</li><li>Which person did you choose to profile? What did you learn about this person?</li><li>Based on today’s activities, which possible career pathway(s) are you most interested in pursuing?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (543, 2527, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (509, 2523, 541, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (510, 2524, 542, TRUE, 100, 0);

--11.7.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (334, 5, 118, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1084, 334, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1085, 334, 2, 2, 3, 200, 'My Roadmap');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1086, 334, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1927, 1084, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1928, 1084, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1929, 1085, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1930, 1085, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1931, 1086, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2528, 1927, 11, 100, NULL, NULL, 'Check out your mentor’s results from the working style quiz you both took:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2529, 1928, 11, 100, NULL, NULL, 'Your mentor shared a reflection on their quiz results with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2530, 1929, 11, 100, NULL, NULL, 'Use the <a href="http://roadtripnation.com/roadmap" target="_blank">Roadtrip Nation</a> website to create a roadmap of your own. Based on your results, please do the following:<ul><li>Listen to 1-2 interview highlights</li><li>Read the short biographies of 1-2 leaders</li><li>Complete the Roadmap Profile for one person you learned about on the website</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2531, 1930, 11, 100, NULL, NULL, 'For a PDF version of the Roadmap Profile click <a href="https://drive.google.com/file/d/0B-7uUglJA5seOXB2ZGxDYm44Z1U/view?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2532, 1931, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What defines you as a person? What brings you joy?</li><li>Which person did you choose to profile? What did you learn about this person?</li><li>Based on today’s activities, which possible career pathway(s) are you most interested in pursuing?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (544, 2532, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (511, 2528, 541, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (512, 2529, 542, TRUE, 100, 0);

--11.7.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (335, 4, 118, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Exploring Career Pathways: Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1087, 335, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1932, 1087, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1933, 1087, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1934, 1087, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2533, 1932, 11, 100, NULL, NULL, 'Your mentee browsed through the <a href="http://roadtripnation.com/roadmap" target="_blank">Roadtrip Nation</a> website and created a roadmap of their own. Based on their results, they did the following:<ul><li>Listened to 1-2 interview highlights</li><li>Read the short biographies of 1-2 leaders</li><li>Completed the Roadmap Profile for one person you learned about on the website</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2534, 1933, 11, 100, NULL, NULL, 'For a PDF version of the Roadmap Profile click <a href="https://drive.google.com/file/d/0B-7uUglJA5seOXB2ZGxDYm44Z1U/view?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2535, 1934, 11, 100, NULL, NULL, 'Then, your mentee shared a reflection using the following questions as a guide:<ul><li>What defines you as a person? What brings you joy?</li><li>Which person did you choose to profile? What did you learn about this person?</li><li>Based on today’s activities, which possible career pathway(s) are you most interested in pursuing?</li></ul>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (513, 2535, 544, TRUE, 100, 0);