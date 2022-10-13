--12.7.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (135, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 32, 3, NULL, 'Life on Campus', '/new_platform/static/canvas/images/12.7.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (384, 1, 135, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Life on Campus');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1236, 384, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1237, 384, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1238, 384, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1239, 384, 2, 2, 2, 400, 'Write a letter to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2155, 1236, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2156, 1236, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2157, 1237, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2158, 1238, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2159, 1239, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2824, 2155, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Building on the previous lesson that focused primarily on the academic and social differences between high school and college, this lesson engages mentees to explore the other aspects of their total college experience.<p><p>In this lesson, mentees will:<ul><li>Define and list the personal, social, and cultural growth opportunities a college may provide</li><li>Research at least one college and complete a graphic organizer highlighting the personal, social, and cultural growth opportunities on campus</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/life-on-campus" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2825, 2156, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2826, 2156, 6, 200, NULL, 'https://docs.google.com/presentation/d/1OE4jEhqcuww6rMw4T30gxUymmxGVofSuWehyB9CD9oQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2827, 2157, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2828, 2158, 11, 100, NULL, NULL, 'Your mentor shared their feedback on what  differences between high school and college excite you or make you nervous. They also shared a difference that stood out in their own college experience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2829, 2159, 11, 100, NULL, NULL, 'Write a letter to your mentor and share what you are excited to experience in college. Here are some questions to think about as you are writing:<ul><li>What personal, social or cultural opportunities are you excited to learn more about?</li><li>Has today’s lesson influenced the way you are thinking about searching for colleges? How so?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (608, 2829, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (576, 2828, 579, TRUE, 100, 0);

--12.7.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (385, 5, 135, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Life on Campus');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1240, 385, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1241, 385, 2, 2, 2, 200, 'Write a letter to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2160, 1240, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2161, 1241, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2830, 2160, 11, 100, NULL, NULL, 'Your mentor shared their feedback on what  differences between high school and college excite you or make you nervous. They also shared a difference that stood out in their own college experience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2831, 2161, 11, 100, NULL, NULL, 'Write a letter to your mentor and share what you are excited to experience in college. Here are some questions to think about as you are writing:<ul><li>What personal, social or cultural opportunities are you excited to learn more about?</li><li>Has today’s lesson influenced the way you are thinking about searching for colleges? How so?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (609, 2831, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (577, 2830, 579, TRUE, 100, 0);

--12.7.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (386, 4, 135, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Life on Campus');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1242, 386, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1243, 386, 2, 2, 2, 200, 'Respond to your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2162, 1242, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2163, 1243, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2164, 1243, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2832, 2162, 11, 100, NULL, NULL, 'Building on the conversations from previous lessons, this class focused on the “other” or non-academic sides of the college experience. More specifically, your mentee’s class explored the personal (i.e. career services, health and wellness, counseling), social (i.e. clubs and organizations, athletics, leadership opportunities) and cultural (i.e. diversity and inclusion, community service, special events) growth opportunities and programs that a college campus may present.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2833, 2163, 11, 100, NULL, NULL, 'Your mentee wrote you a letter and shared the personal, social or cultural experiences and opportunities they are interested in learning more about.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2834, 2164, 11, 100, NULL, NULL, 'Respond to your mentee with a letter of your own. Here are some questions to get you started:<ul><li>What advice can you give your mentee about the personal, social or cultural opportunities they shared?</li><li>How would you encourage your mentee to grow in college? What tips can you give them?</li><li>What experiences from college do you cherish? Why?</li><li>What obstacles did you run into?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (610, 2834, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (578, 2833, 609, TRUE, 100, 0);

--12.7.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (136, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 32, 4, NULL, 'Navigating Obstacles', '/new_platform/static/canvas/images/12.7.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (387, 1, 136, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Navigating Obstacles');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1244, 387, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1245, 387, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1246, 387, 2, 1, 2, 300, 'Knowledge is power');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1247, 387, 2, 2, 2, 400, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2165, 1244, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2166, 1244, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2167, 1245, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2168, 1246, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2169, 1247, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2170, 1247, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2835, 2165, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will give context to five types of obstacles presented to new college students: social and recreational; basic lifestyle; digital; personal issues; and academic immortality.<p><p>In this lesson, mentees will:<ul><li>Read an article on common pitfalls and traps for new college students</li><li>Define the five categories of challenges in their own words and list examples</li><li>Create a solution and a sticky way to remember it</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/navigating-obstacles" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2836, 2166, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2837, 2166, 6, 200, NULL, 'https://docs.google.com/presentation/d/1YvkicUdxHRBCQOjzfpg_0yrI_R3Wy5LL9hToQOCDSk4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2838, 2167, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2839, 2168, 6, 100, NULL, 'https://docs.google.com/presentation/d/1L3UPhcRJgcOb7otXqg9jbrpXBs7kNGJESvwC5USjpkw/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2840, 2168, 11, 200, NULL, NULL, 'What do these quotes mean to you? How can knowledge and “knowing” be powerful in college?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2841, 2169, 11, 100, NULL, NULL, 'Your mentor wrote you a letter. They shared the personal, social, or cultural experiences that stood out during their time in college. They also shared the obstacles they ran into and how they addressed them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2842, 2170, 11, 100, NULL, NULL, 'Respond to your mentor’s letter. In your response, be sure to mention which of the five traps are you most concerned about and why.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (611, 2842, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (579, 2841, 610, TRUE, 100, 0);

--12.7.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (388, 5, 136, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Navigating Obstacles');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1248, 388, 2, 1, 2, 100, 'Knowledge is power');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1249, 388, 2, 2, 2, 200, 'Connect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2171, 1248, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2172, 1249, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2173, 1249, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2843, 2171, 6, 100, NULL, 'https://docs.google.com/presentation/d/1L3UPhcRJgcOb7otXqg9jbrpXBs7kNGJESvwC5USjpkw/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2844, 2171, 11, 200, NULL, NULL, 'What do these quotes mean to you? How can knowledge and “knowing” be powerful in college?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2845, 2172, 11, 100, NULL, NULL, 'Your mentor wrote you a letter. They shared the personal, social, or cultural experiences that stood out during their time in college. They also shared the obstacles they ran into and how they addressed them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2846, 2173, 11, 100, NULL, NULL, 'Respond to your mentor’s letter. In your response, be sure to mention which of the five traps are you most concerned about and why.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (612, 2846, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (580, 2845, 610, TRUE, 100, 0);

--12.7.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (389, 4, 136, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Navigating Obstacles');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1250, 389, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1251, 389, 2, 2, 2, 200, 'Support your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2174, 1250, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2175, 1250, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2176, 1251, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2847, 2174, 11, 100, NULL, NULL, 'As the last lesson in this unit, your mentee discussed common challenges for new and first generation college students and brainstormed a list of solutions for them. Read the article below to familiarize yourself with five common pitfalls and traps for new college students.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2848, 2174, 8, 200, NULL, '/new_platform/static/canvas/documents/5_Academic_PItfalls_and_Traps.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2849, 2175, 11, 100, NULL, NULL, 'Your mentee responded to your letter. They also shared which of the five traps they are most concerned with and why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2850, 2176, 11, 100, NULL, NULL, 'It may seem a bit early to be researching specific challenges for first time college students. Especially if your mentee is concerned about getting into college or graduating from high school. If that’s the case, it’s OK.<p><p>It is important for your mentee to be aware of common challenges since the solution is often tied to a behavior or skill that needs to be developed and not a simple action or task. Time management, creating to-do lists, and asking for help are all things you and your mentee can work on to help  them both now and in the future.</p></p>If you don’t know where to start, please read our <a href="https://learn.imentor.org/help/article/link/research-around-non-cognitive-skills-our-curriculum-and-college-success" target="_blank">article</a> on the non-cognitive skills essential for college success.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (581, 2849, 612, TRUE, 100, 0);

--12.8.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (35, 8, 'My College Experience', 'my_college_experience', 'How can I make the most of my college experience?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (35, 4, 35, '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>', '<ul><li>What did you learn about yourself in this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (137, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 35, 1, NULL, 'My College Budget', '/new_platform/static/canvas/images/12.8.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (390, 1, 137, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Budget');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1252, 390, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1253, 390, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1254, 390, 2, 1, 2, 300, 'What is a budget?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1255, 390, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2177, 1252, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2178, 1252, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2179, 1252, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2180, 1253, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2181, 1254, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2182, 1255, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2183, 1255, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2851, 2177, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Money management is a key skill for all college-aged students. First-time college students are susceptible to overspending or being unprepared to pay for necessary college expenses. This lesson introduces mentees to the importance of having and using a budget in college.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define what a budget is, why it is important, and how it can be used in college</li><li>Apply their knowledge of budgeting to a hypothetical situation</li><li>Assess the spending habits of college students and create solutions</li><li>Assess their own spending habits and need for budgeting</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-budget" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2852, 2178, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2853, 2178, 6, 200, NULL, 'https://docs.google.com/presentation/d/16k4nfWeD-nYwI3wIsUT7VJXSWD9Iq2KKrfe5EFJSnAU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2854, 2179, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2855, 2179, 3, 200, NULL, 'https://vimeo.com/151941284', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2856, 2180, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2857, 2181, 11, 100, NULL, NULL, 'As you watch the below video, think about the following questions:<ul><li>What is a budget?</li><li>How do you create a budget?</li><li>Why is using a budget important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2858, 2181, 3, 200, NULL, 'https://vimeo.com/151941284', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2859, 2182, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What are your spending habits like? Do you spend your money wisely (most of the time)?</li><li>Do you see budgeting as valuable now? In college?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2860, 2183, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (613, 2859, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (614, 2860, 100, 0, 2);

--12.8.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (391, 5, 137, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Budget');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1256, 391, 2, 1, 2, 100, 'What is a budget?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1257, 391, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2184, 1256, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2185, 1257, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2186, 1257, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2861, 2184, 11, 100, NULL, NULL, 'As you watch the below video, think about the following questions:<ul><li>What is a budget?</li><li>How do you create a budget?</li><li>Why is using a budget important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2862, 2184, 3, 200, NULL, 'https://vimeo.com/151941284', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2863, 2185, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>What are your spending habits like? Do you spend your money wisely (most of the time)?</li><li>Do you see budgeting as valuable now? In college?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2864, 2186, 11, 100, NULL, NULL, 'Share a personal update with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (615, 2863, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (616, 2864, 100, 0, 2);

--12.8.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (392, 4, 137, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Budget');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1258, 392, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1259, 392, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2187, 1258, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2188, 1258, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2189, 1259, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2865, 2187, 11, 100, NULL, NULL, 'Your mentee has been appropriately focused on how to pay for college. An important part of that process is understanding how to manage their expenses and income.<p><p>This lesson was all about budgeting for your mentee. They explored the what, how, and why of budgeting now and in college.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2866, 2187, 3, 200, NULL, 'https://vimeo.com/151941284', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2867, 2188, 11, 100, NULL, NULL, 'They applied what they learned to a sample budget and scenario and made recommendations about how that person could adjust their spending habits.<p><p>Finally, they reflected on their own spending habits and shared those habits with you. They also shared a personal update.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2868, 2189, 11, 100, NULL, NULL, 'Respond to your mentee.<ul><li>What advice do you have for managing money? This can be either about your experience budgeting in college or how you use budgets today.</li><li>Share a personal update with your mentee.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (617, 2868, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (582, 2867, 615, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (583, 2867, 616, TRUE, 200, 0);

--12.8.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (138, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 35, 2, NULL, 'Expanding My Personal and Professional Network', '/new_platform/static/canvas/images/12.8.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (393, 1, 138, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Expanding My Personal and Professional Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1260, 393, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1261, 393, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1262, 393, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1263, 393, 2, 2, 2, 400, 'Building your network');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2190, 1260, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2191, 1260, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2192, 1261, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2193, 1262, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2194, 1262, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2195, 1263, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2869, 2190, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />While degree attainment should be central to any college experience, it does not have to be the only thing. This lesson engages mentees in thinking about the benefits of personal and social networks that come out of the college experience, as well as strategies for networking in college.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read and discuss an article about networking in college</li><li>Identify and define strategies and tips for networking in college</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/expanding-my-personal-professional-network" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2870, 2191, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2871, 2191, 6, 200, NULL, 'https://docs.google.com/presentation/d/1l-dMMjUNaTchyK_6eNYtNvzxOCuP7H7IXm2ko0Uu0uI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2872, 2192, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2873, 2193, 11, 100, NULL, NULL, 'Your mentor offered some feedback on your spending habits and budgeting advice. They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2874, 2194, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2875, 2195, 8, 100, NULL, '/new_platform/static/canvas/documents/Networking_for_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2876, 2195, 11, 200, NULL, NULL, 'Share the following with your mentor:<ul><li>How can you make the most of your college experience?</li><li>Which networking tip will be the easiest for you? Why?</li><li>Which networking tip will be the hardest for you? Why?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (618, 2874, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (619, 2876, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (584, 2873, 617, TRUE, 100, 0);

--12.8.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (394, 5, 138, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Expanding My Personal and Professional Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1264, 394, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1265, 394, 2, 2, 2, 200, 'Building your network');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2196, 1264, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2197, 1264, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2198, 1265, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2877, 2196, 11, 100, NULL, NULL, 'Your mentor offered some feedback on your spending habits and budgeting advice. They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2878, 2197, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2879, 2198, 8, 100, NULL, '/new_platform/static/canvas/documents/Networking_for_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2880, 2198, 11, 200, NULL, NULL, 'Share the following with your mentor:<ul><li>How can you make the most of your college experience?</li><li>Which networking tip will be the easiest for you? Why?</li><li>Which networking tip will be the hardest for you? Why?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (620, 2878, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (621, 2880, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (585, 2877, 617, TRUE, 100, 0);

--12.8.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (395, 4, 138, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Expanding My Personal and Professional Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1266, 395, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1267, 395, 2, 2, 3, 200, 'Now it’s your turn…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1268, 395, 2, 3, 3, 300, 'Support your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2199, 1266, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2200, 1266, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2201, 1267, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2202, 1268, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2881, 2199, 9, 100, NULL, '/new_platform/static/canvas/images/Fast_and_Far_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2882, 2199, 11, 200, NULL, NULL, 'Your mentee discussed the benefits of networking and discussed ways people build their networks.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2883, 2200, 11, 100, NULL, NULL, 'As part of their discussion, they read the article below and shared which tips they believed would be the easiest and hardest for them to adopt and why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2884, 2200, 8, 200, NULL, '/new_platform/static/canvas/documents/Networking_for_College.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2885, 2201, 11, 100, NULL, NULL, 'Respond to your mentee and share your own experiences networking:<ul><li>What relationships started in college that are still important in your life?</li><li>What advice can you give to your mentee about the importance of networking?</li><li>What tips on networking do you have that were not covered in the article?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2886, 2202, 11, 100, NULL, NULL, 'It is important that your mentee understands the what, why and how of networking. As a mentor, you are uniquely positioned to provide your mentee with opportunities for networking and skill building in safe and low risk ways.<p><p>What are some ways you can provide your mentee with opportunities to network with others and/or build networking skills? If you have an idea for how you might support them in this way, share it with your mentee.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (622, 2885, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (623, 2886, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (586, 2884, 620, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (587, 2884, 621, TRUE, 200, 0);

--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('13i3RMlHPfykWmN9wQookuuDQjGDCGo_yyZxgU4zQeRo', 'Personal Support Network');

--12.8.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (139, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 35, 3, NULL, 'My Support Network', '/new_platform/static/canvas/images/12.8.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (396, 1, 139, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Support Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1269, 396, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1270, 396, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1271, 396, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1272, 396, 2, 2, 3, 400, 'My support network');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1273, 396, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2203, 1269, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2204, 1269, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2205, 1270, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2206, 1271, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2207, 1271, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2208, 1271, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2209, 1272, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2210, 1273, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2887, 2203, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will complete a mind map of their possible support network in college.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify areas where they predict they''ll need support</li><li>Identify the people and places they can turn to for support</li><li>Complete Mind Map</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-support-network" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2888, 2204, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2889, 2204, 6, 200, NULL, 'https://docs.google.com/presentation/d/15iqtaZfrQDIaCnHaYbN_ae2qYuGX2ytRKDrCmtay3eI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2890, 2205, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2891, 2206, 11, 100, NULL, NULL, 'Your mentor shared additional tips and strategies for networking. They also shared about relationships they built in college that are still strong today.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2892, 2207, 11, 100, NULL, NULL, 'Your mentor can be a powerful resource in building both your network and networking skills. We asked your mentor to think of ways they can support in you either or both.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2893, 2208, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2894, 2209, 11, 100, NULL, NULL, 'Have you heard the saying that starts with, “It takes a village”? It’s true in college also. We all need help and people to turn to. Use the document below to start mapping out who or what could be in your personal support network.<p><p>If you don’t know where you are going to college yet, it’s ok. Chances are high that you already know some of the people in your support network, no matter what you do after high school.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2895, 2209, 6, 200, NULL, 'https://docs.google.com/document/d/13i3RMlHPfykWmN9wQookuuDQjGDCGo_yyZxgU4zQeRo/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2896, 2210, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>Looking back, who did you rely on most to help you through high school?</li><li>Looking ahead, what role do you see your mentor playing as part of your support system in college?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (624, 2893, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (625, 2896, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (588, 2891, 622, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (589, 2892, 623, TRUE, 100, 0);

--12.8.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (397, 5, 139, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Support Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1274, 397, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1275, 397, 2, 2, 3, 200, 'My support network');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1276, 397, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2211, 1274, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2212, 1274, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2213, 1274, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2214, 1275, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2215, 1276, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2897, 2211, 11, 100, NULL, NULL, 'Your mentor shared additional tips and strategies for networking. They also shared about relationships they built in college that are still strong today.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2898, 2212, 11, 100, NULL, NULL, 'Your mentor can be a powerful resource in building both your network and networking skills. We asked your mentor to think of ways they can support in you either or both.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2899, 2213, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2900, 2214, 11, 100, NULL, NULL, 'Have you heard the saying that starts with, “It takes a village”? It’s true in college also. We all need help and people to turn to. Use the document below to start mapping out who or what could be in your personal support network.<p><p>If you don’t know where you are going to college yet, it’s ok. Chances are high that you already know some of the people in your support network, no matter what you do after high school.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2901, 2214, 6, 200, NULL, 'https://docs.google.com/document/d/13i3RMlHPfykWmN9wQookuuDQjGDCGo_yyZxgU4zQeRo/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2902, 2215, 11, 100, NULL, NULL, 'Share the following with your mentor:<ul><li>Looking back, who did you rely on most to help you through high school?</li><li>Looking ahead, what role do you see your mentor playing as part of your support system in college?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (626, 2899, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (627, 2902, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (590, 2897, 622, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (591, 2898, 623, TRUE, 100, 0);

--12.8.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (398, 4, 139, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Support Network');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1277, 398, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1278, 398, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2216, 1277, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2217, 1278, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2903, 2216, 11, 100, NULL, NULL, 'As your mentee prepares to transition to life after high school, it is important they know who they can rely on or turn to for support. In this lesson, your mentee used the tool below to map out the people, resources, and offices that might be in their personal support network.<p><p>Review their map below. If there are people or resources missing, please add to it. If you think you can be support in more than one area, list those as well.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2904, 2216, 6, 200, NULL, 'https://docs.google.com/document/d/13i3RMlHPfykWmN9wQookuuDQjGDCGo_yyZxgU4zQeRo/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2905, 2217, 11, 100, NULL, NULL, 'Your mentee responded to your networking tips and ideas. They also looked back on their high school experience and shared about the people they relied in high school.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (592, 2905, 626, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (593, 2905, 627, TRUE, 200, 0);

--10.8.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (140, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 34, 2, NULL, 'Why Does College Matter?', '/new_platform/static/canvas/images/10.8.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (399, 1, 140, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Why Does College Matter?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1279, 399, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1280, 399, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1281, 399, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1282, 399, 2, 2, 3, 400, 'Ways that college matters');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1283, 399, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2218, 1279, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2219, 1279, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2220, 1280, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2221, 1281, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2222, 1281, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2223, 1282, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2224, 1283, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2906, 2218, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will tackle the question, "Why does college matter?" They will do so by reviewing an infographic on the positive impacts of having a degree and considering tangible examples of ways in which these benefits apply to them.<p><p>In this lesson, mentees will:<ul><li>Review an infographic listing the ways having a college degree can positively impact their life.</li><li>List the specific ways and instances when having a college degree matters in each category.</li><li>List the specific ways and instances when not having a college degree matters in each category.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/why-does-college-matter-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2907, 2219, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2908, 2219, 6, 200, NULL, 'https://docs.google.com/presentation/d/1xDCRNA3KcpPoQ-RPxU9UYBWXMZCJSvXo9Su-GVXQTgE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2909, 2220, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2910, 2221, 11, 100, NULL, NULL, 'Your mentor read your poem and shared their thoughts below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2911, 2222, 11, 100, NULL, NULL, 'Your mentor wrote their own “10 in 10” poem. Read your mentor’s poem and share your thoughts about it. Here are some questions to think about as you respond:<ul><li>What stands out to you about the poem?</li><li>What inspires you?</li><li>How similar or different are your poems?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2912, 2222, 6, 200, NULL, 'https://docs.google.com/document/d/1GUHADe0IH6AtuLTriljWRFdOkvF0ZmP4Bhk8Pux7S8U/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2913, 2223, 11, 100, NULL, NULL, 'Going to college and getting a degree is important for more reasons than making $$$. Review the infographic below to explore some of the other ways a college education can positively impact your life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2914, 2223, 9, 200, NULL, '/new_platform/static/canvas/images/College_Degree_Worth_2.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2915, 2224, 11, 100, NULL, NULL, 'So how much does college really matter to you? Based on what you want to do in your life, how important is going to college to you? Share this with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (628, 2912, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (629, 2915, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (594, 2910, 607, TRUE, 100, 0);

--10.8.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (400, 5, 140, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Why Does College Matter?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1284, 400, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1285, 400, 2, 2, 3, 200, 'Ways that college matters');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1286, 400, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2225, 1284, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2226, 1284, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2227, 1285, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2228, 1286, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2916, 2225, 11, 100, NULL, NULL, 'Your mentor read your poem and shared their thoughts below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2917, 2226, 11, 100, NULL, NULL, 'Your mentor wrote their own “10 in 10” poem. Read your mentor’s poem and share your thoughts about it. Here are some questions to think about as you respond:<ul><li>What stands out to you about the poem?</li><li>What inspires you?</li><li>How similar or different are your poems?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2918, 2226, 6, 200, NULL, 'https://docs.google.com/document/d/1GUHADe0IH6AtuLTriljWRFdOkvF0ZmP4Bhk8Pux7S8U/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2919, 2227, 11, 100, NULL, NULL, 'Going to college and getting a degree is important for more reasons than making $$$. Review the infographic below to explore some of the other ways a college education can positively impact your life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2920, 2227, 9, 200, NULL, '/new_platform/static/canvas/images/College_Degree_Worth_2.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2921, 2228, 11, 100, NULL, NULL, 'So how much does college really matter to you? Based on what you want to do in your life, how important is going to college to you? Share this with your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (630, 2918, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (631, 2921, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (595, 2916, 607, TRUE, 100, 0);

--10.8.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (401, 4, 140, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Why Does College Matter?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1287, 401, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1288, 401, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2229, 1287, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2230, 1287, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2231, 1287, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2232, 1288, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2922, 2229, 11, 100, NULL, NULL, 'Why does college matter? It’s easy for us to measure the value of college and a college degree strictly through a monetary lens. However, the positive impact of a college education extends beyond the potential of a higher salary.<p><p>Your mentee reviewed the infographic below to explore some of the ways a college education can positively impact their lives.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2923, 2229, 9, 200, NULL, '/new_platform/static/canvas/images/College_Degree_Worth_2.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2924, 2230, 11, 100, NULL, NULL, 'So how much does college matter to your mentee? We asked your mentee to share how important going to college is to them.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2925, 2231, 11, 100, NULL, NULL, 'Your mentee also read and commented on your poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2926, 2232, 11, 100, NULL, NULL, 'Respond to your mentee. Do you think your mentee has the right idea about college or the value of going to college?<ul><li>If they don’t, what words of advice can you give to your mentee? What personal experiences can you share to help them think about college differently?</li><li>If they do, what words of encouragement can you give to your mentee? What personal experiences can you share to continue to nudge them in that direction?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (632, 2926, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (596, 2924, 631, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (597, 2925, 630, TRUE, 100, 0);

--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1I7GypCEU9nwAFVdydzav89xcEbTh2HyDRAPPMaBPvD4', 'College Self-Assessment');

--10.8.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (141, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 34, 3, NULL, 'My Goals, My Path', '/new_platform/static/canvas/images/10.8.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (402, 1, 141, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Goals, My Path');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1289, 402, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1290, 402, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1291, 402, 2, 1, 2, 300, 'Knowing is half the battle');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1292, 402, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2233, 1289, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2234, 1289, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2235, 1290, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2236, 1291, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2237, 1291, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2238, 1292, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2239, 1292, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2927, 2233, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will use their long term goals and discussions on why college matters from the previous lessons to assess how much they know about their road to college and career success.<p><p>In this lesson, mentees will:<ul><li>Review lessons 10.8.1 and 10.8.2 to connect content across the three lessons.</li><li>Complete a self-assessment of their college knowledge, aspiration, and contextual skills.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-goals-my-path-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2928, 2234, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2929, 2234, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Ln0bo2edk4-VMIPsurTP2A24AMIJIzxSsNFO1xnjwYI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2930, 2235, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2931, 2236, 9, 100, NULL, '/new_platform/static/canvas/images/Knowing_Battle_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2932, 2237, 11, 100, NULL, NULL, 'What do you know about college? What don’t you know about college? Complete the self-assessment below to better understand how you know and don’t know, and what you can do about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2933, 2237, 6, 200, NULL, 'https://docs.google.com/document/d/1I7GypCEU9nwAFVdydzav89xcEbTh2HyDRAPPMaBPvD4/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2934, 2238, 11, 100, NULL, NULL, 'Your mentor responded to your last message about how much college matters to you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2935, 2239, 11, 100, NULL, NULL, 'Respond to your mentor and share a personal update.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (633, 2935, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (598, 2934, 632, TRUE, 100, 0);

--10.8.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (403, 5, 141, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Goals, My Path');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1293, 403, 2, 1, 2, 100, 'Knowing is half the battle');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1294, 403, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2240, 1293, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2241, 1293, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2242, 1294, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2243, 1294, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2936, 2240, 9, 100, NULL, '/new_platform/static/canvas/images/Knowing_Battle_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2937, 2241, 11, 100, NULL, NULL, 'What do you know about college? What don’t you know about college? Complete the self-assessment below to better understand how you know and don’t know, and what you can do about it.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2938, 2241, 6, 200, NULL, 'https://docs.google.com/document/d/1I7GypCEU9nwAFVdydzav89xcEbTh2HyDRAPPMaBPvD4/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2939, 2242, 11, 100, NULL, NULL, 'Your mentor responded to your last message about how much college matters to you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2940, 2243, 11, 100, NULL, NULL, 'Respond to your mentor and share a personal update.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (634, 2940, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (599, 2939, 632, TRUE, 100, 0);

--10.8.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (404, 4, 141, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Goals, My Path');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1295, 404, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1296, 404, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2244, 1295, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2245, 1296, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2246, 1296, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2941, 2244, 11, 100, NULL, NULL, '“Knowing is half the battle”. As you and your mentee prepare to tackle the college process head on, it will be good to know how much your mentee knows or doesn’t know about college and the college process.<p><p>To do so, your mentee completed the self-assessment below.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2942, 2244, 6, 200, NULL, 'https://docs.google.com/document/d/1I7GypCEU9nwAFVdydzav89xcEbTh2HyDRAPPMaBPvD4/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2943, 2245, 11, 100, NULL, NULL, 'After reviewing your mentee’s self-assessment, share some feedback. What did you find encouraging? What can you do to support your mentee in the areas where they rated themselves low?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2944, 2246, 11, 100, NULL, NULL, 'Your mentee shared a personal update. Respond to your mentee and share a personal update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (635, 2943, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (636, 2944, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (600, 2944, 634, TRUE, 100, 0);