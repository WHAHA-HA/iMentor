--Staff Lesson 12.1.6

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (31, 1, '6/30/15 00:00:00', '6/30/15 23:59:59', 4, 5, 6, NULL, 'Completing My College List Part II');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (73, 1, 31, '6/30/15 00:00:00', '6/30/15 23:59:59', 'Completing My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (218, 73, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (219, 73, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (220, 73, 2, 1, 3, 300, 'Understanding college application lingo');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (221, 73, 2, 2, 3, 400, 'Finalize your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (222, 73, 2, 3, 3, 500, 'Reconnect to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (358, 218, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (359, 218, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (360, 219, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (361, 220, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (362, 221, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (363, 222, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (364, 222, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (495, 358, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore college application terminology. This lesson will also be used to provide mentees with time to complete their college lists.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review their college list and work to complete it.</li><li>Finalize their list on the College List tool.</li><li>Explore and understand college application related terms.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/completing-my-college-list-continued" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (496, 359, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (497, 359, 6, 200, NULL, 'https://docs.google.com/presentation/d/1zuhBkn9Hd3enE1jkb_ZnCjv6mvgWaS9mUQUngD6BPEU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (498, 360, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (499, 361, 11, 100, NULL, NULL, 'There are a variety of terms you’ll need to understand to finish your college lists and applications. The following two websites will help you define unfamiliar terms.<ul><li><a href="https://bigfuture.collegeboard.org/get-in/applying-101/college-admission-glossary" target="_blank">College Board Admission Glossary</a></li><li><a href="http://www.commonapp.org/application-dictionary" target="_blank">Common Application Dictionary</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (500, 362, 11, 100, NULL, NULL, 'Click <a href="/cchklist/list/" target="_blank">here</a> to open your college list.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (501, 363, 11, 100, NULL, NULL, 'Your mentor wrote to you about your college list and shared their own experience with applying to college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (502, 364, 11, 100, NULL, NULL, 'Respond to your mentor and consider the following questions:<ul><li>What piece of advice from your mentor resonates with you?</li><li>How might it be useful as you work through this process?</li><li>Are there any changes to your list you might consider based on this advice?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (92, 502, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (81, 501, 81, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (82, 501, 82, TRUE, 200, 0);

--Mentee Lesson 12.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (74, 5, 31, '6/30/15 00:00:00', '6/30/15 23:59:59', 'Completing My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (223, 74, 2, 1, 3, 100, 'Understanding college application lingo');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (224, 74, 2, 2, 3, 200, 'Finalize your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (225, 74, 2, 3, 3, 300, 'Reconnect to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (365, 223, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (366, 224, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (367, 225, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (368, 225, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (503, 365, 11, 100, NULL, NULL, 'There are a variety of terms you’ll need to understand to finish your college lists and applications. The following two websites will help you define unfamiliar terms.<ul><li><a href="https://bigfuture.collegeboard.org/get-in/applying-101/college-admission-glossary" target="_blank">College Board Admission Glossary</a></li><li><a href="http://www.commonapp.org/application-dictionary" target="_blank">Common Application Dictionary</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (504, 366, 11, 100, NULL, NULL, 'Click <a href="/cchklist/list/" target="_blank">here</a> to open your college list.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (505, 367, 11, 100, NULL, NULL, 'Your mentor wrote to you about your college list and shared their own experience with applying to college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (506, 368, 11, 100, NULL, NULL, 'Respond to your mentor and consider the following questions:<ul><li>What piece of advice from your mentor resonates with you?</li><li>How might it be useful as you work through this process?</li><li>Are there any changes to your list you might consider based on this advice?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (93, 506, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (83, 505, 81, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (84, 505, 82, TRUE, 200, 0);

--Mentor Lesson 12.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (75, 4, 31, '6/30/15 00:00:00', '6/30/15 23:59:59', 'Completing My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (226, 75, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (227, 75, 2, 2, 2, 200, 'Write your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (369, 226, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (370, 226, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (371, 226, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (372, 227, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (507, 369, 11, 100, NULL, NULL, 'Your mentee was introduced to some useful tools to define all the terms they’ll need to know through the college application process. To better support your mentee, please review these terms in the provided links.<ul><li><a href="https://bigfuture.collegeboard.org/get-in/applying-101/college-admission-glossary" target="_blank">College Board Admission Glossary</a></li><li><a href="http://www.commonapp.org/application-dictionary" target="_blank">Common Application Dictionary</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (508, 370, 11, 100, NULL, NULL, 'Your mentee should be finished or near finished with their college list. You can view your mentee’s list <a href="/cchklist/list/" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (509, 371, 11, 100, NULL, NULL, 'Your mentee responded to your experiences and the advice you gave.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (510, 372, 11, 100, NULL, NULL, 'Next week, your mentee will explore their college application timelines. Review your mentee''s <a href="/cchklist/list/" target="_blank">college list</a> and share the following:<ul><li>When do you expect your mentee to be the busiest and most stressed?</li><li>What tips and strategies can you share to help them through that period?</li><li>What tools do you use to keep track of tasks and projects?</li><li>How do you deal with busy and stressful periods?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (94, 510, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (85, 509, 93, TRUE, 100, 0);

--Staff Lesson 12.1.7

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (32, 1, '7/1/15 00:00:00', '7/1/15 23:59:59', 4, 5, 7, NULL, 'Managing My College Application Deadlines');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (76, 1, 32, '7/1/15 00:00:00', '7/1/15 23:59:59', 'Managing My College Application Deadlines');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (228, 76, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (229, 76, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (230, 76, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (231, 76, 2, 2, 4, 400, 'Time Management');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (232, 76, 2, 3, 4, 500, 'College Admissions Options');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (233, 76, 2, 4, 4, 600, 'Apply what you learned to your college list');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (373, 228, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (374, 228, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (375, 229, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (376, 230, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (377, 230, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (378, 231, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (379, 232, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (380, 233, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (511, 373, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In order to track application deadlines, mentees will explore different time management skills, explore different college admissions options, and identify the admissions category and specific deadlines for the colleges on their list.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define time management</li><li>Explore different time management strategies</li><li>Read and review an article about college admissions options</li><li>Identify the admissions option category and deadlines for the colleges on their list</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/managing-college-application-deadlines" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (512, 374, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (513, 374, 6, 200, NULL, 'https://docs.google.com/presentation/d/1W7ftcWnFxC6EaabPSfOzQhVXmfTP31BDJRhrSXrpyh8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (514, 375, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (515, 376, 11, 100, NULL, NULL, 'Your mentor offered advice on staying on track during this process:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (516, 377, 11, 100, NULL, NULL, 'Respond by considering the following:<ul><li>Which time management strategies and tools are you most interested in adopting or improving upon? Why?</li><li>Which strategies are you interested in learning more about?</li><li>Do you already use any of the strategies your mentor shared? How is it going?</li><li>Are their ways your mentor can help you manage your time through the college application process?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (517, 378, 9, 100, NULL, '/new_platform/static/canvas/images/Time_Management_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (518, 378, 11, 200, NULL, NULL, 'Consider the following:<ul><li>Which strategies resonate most with you? Why?</li><li>Which strategies are you already using effectively?</li><li>Which strategy do you think will be the hardest to adopt?</li><li>What strategies do you use that are not in the infographic?</li><li>What tools do you use to help you manage your time?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (519, 379, 8, 100, NULL, '/new_platform/static/canvas/documents/College_Admissions_Options.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (520, 379, 11, 200, NULL, NULL, 'Define the following in your own words:<ul><li>Regular admission</li><li>Rolling admission</li><li>Open admission</li><li>Early decision</li><li>Early action</li><li>Deferred admission</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (521, 380, 11, 100, NULL, NULL, 'Use your <a href="/cchklist/list/" target="_blank">college list</a> to answer some important questions about each of your colleges:<ul><li>What is the admissions category?</li><li>When is the final application deadline?</li><li>Are there additional deadlines for supplementary application materials?</li></ul><p><p>Remember: Use your time management strategies to keep track of these deadlines <a href="/cchklist/progress/" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (95, 516, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (86, 515, 94, TRUE, 100, 0);

--Mentee Lesson 12.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (77, 5, 32, '7/1/15 00:00:00', '7/1/15 23:59:59', 'Managing My College Application Deadlines');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (234, 77, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (235, 77, 2, 2, 4, 200, 'Time Management');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (236, 77, 2, 3, 4, 300, 'College Admissions Options');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (237, 77, 2, 4, 4, 400, 'Apply what you learned to your college list');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (381, 234, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (382, 234, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (383, 235, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (384, 236, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (385, 237, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (522, 381, 11, 100, NULL, NULL, 'Your mentor offered advice on staying on track during this process:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (523, 382, 11, 100, NULL, NULL, 'Respond by considering the following:<ul><li>Which time management strategies and tools are you most interested in adopting or improving upon? Why?</li><li>Which strategies are you interested in learning more about?</li><li>Do you already use any of the strategies your mentor shared? How is it going?</li><li>Are their ways your mentor can help you manage your time through the college application process?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (524, 383, 9, 100, NULL, '/new_platform/static/canvas/images/Time_Management_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (525, 383, 11, 200, NULL, NULL, 'Consider the following:<ul><li>Which strategies resonate most with you? Why?</li><li>Which strategies are you already using effectively?</li><li>Which strategy do you think will be the hardest to adopt?</li><li>What strategies do you use that are not in the infographic?</li><li>What tools do you use to help you manage your time?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (526, 384, 8, 100, NULL, '/new_platform/static/canvas/documents/College_Admissions_Options.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (527, 384, 11, 200, NULL, NULL, 'Define the following in your own words:<ul><li>Regular admission</li><li>Rolling admission</li><li>Open admission</li><li>Early decision</li><li>Early action</li><li>Deferred admission</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (528, 385, 11, 100, NULL, NULL, 'Use your <a href="/cchklist/list/" target="_blank">college list</a> to answer some important questions about each of your colleges:<ul><li>What is the admissions category?</li><li>When is the final application deadline?</li><li>Are there additional deadlines for supplementary application materials?</li></ul><p><p>Remember: Use your time management strategies to keep track of these deadlines <a href="/cchklist/progress/" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (96, 523, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (87, 522, 94, TRUE, 100, 0);

--Mentor Lesson 12.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (78, 4, 32, '7/1/15 00:00:00', '7/1/15 23:59:59', 'Managing My College Application Deadlines');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (238, 78, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (239, 78, 2, 2, 2, 200, 'Write your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (386, 238, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (387, 238, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (388, 238, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (389, 238, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (390, 239, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (529, 386, 11, 100, NULL, NULL, 'Your mentee discussed time management strategies.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (530, 386, 9, 200, NULL, '/new_platform/static/canvas/images/Time_Management_Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (531, 387, 11, 100, NULL, NULL, 'They then read an article about the different types of admission options.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (532, 387, 8, 200, NULL, '/new_platform/static/canvas/documents/College_Admissions_Options.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (533, 388, 11, 100, NULL, NULL, 'They applied that information to their college list to keep track of their deadlines. Take a moment to confirm that they are tracking deadlines on their College Checklist <a href="/cchklist/progress/" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (534, 389, 11, 100, NULL, NULL, 'Finally, they reflected on your advice about time management strategies and responded.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (535, 390, 11, 100, NULL, NULL, 'Write to your mentee and consider the following questions:<ul><li>Did they update their deadlines on the college list? If not, how can you help?</li><li>Answer their questions about time management strategies.</li><li>In what ways can you support your mentee through the college application process?</li><li>What 2-3 SMART goals would you recommend your mentee focus on in the coming weeks and months of the school year?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (97, 535, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (88, 534, 96, TRUE, 100, 0);

--Staff Lesson 12.1.8

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (33, 1, '7/2/15 00:00:00', '7/2/15 23:59:59', 4, 5, 8, NULL, 'Setting 12th Grade SMART Goals');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (79, 1, 33, '7/2/15 00:00:00', '7/2/15 23:59:59', 'Setting 12th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (240, 79, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (241, 79, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (242, 79, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (243, 79, 2, 2, 3, 400, 'Read one of the following articles');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (244, 79, 2, 3, 3, 500, 'Set a SMART Goal');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (391, 240, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (392, 240, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (393, 241, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (394, 242, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (395, 243, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (396, 244, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (397, 244, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (536, 391, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will focus on narrowing down their list of tasks to create SMART goals intended to guide them through the college process successfully.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read and review articles defining the college application and admission timelines</li><li>Define SMART goal setting framework</li><li>Complete SMART goal setting template</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/12th-grade-smart-goals" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (537, 392, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (538, 392, 6, 200, NULL, 'https://docs.google.com/presentation/d/1w5Vk_dhTVEwZk7Zq9GZR9bPNRA99WLOwnogy4vbBWfc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (539, 393, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (540, 394, 11, 100, NULL, NULL, 'Respond to your mentor. Consider the following:<ul><li>Answer any questions they have about your college list.</li><li>How did they suggest supporting you through your college process? What will it take for this to be successful?</li><li>What SMART goals did they recommend you focus on? Do you agree or disagree? Why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (541, 395, 11, 100, NULL, NULL, '<ul><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seRmFuaTBwWDRVU0U/view?usp=sharing" target="_blank">Article 1: My Future</a></li><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seMnRLU1FSZUg5ckU/view?usp=sharing" target="_blank">Article 2: Mapping Your Future</a></li></ul><p><p>After reading the articles, consider what you should focus on in the 1st month and the 1st semester of your senior year.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (542, 396, 11, 100, NULL, NULL, 'Now use your above focus items, mentor recommendations, and prior discussions to create your own SMART goal using the template.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (543, 396, 6, 200, NULL, 'https://docs.google.com/document/d/1n-qea9eLVes9zrqiC6xG-1HwgGTcdbWWaRLoAL0OBic/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (544, 397, 11, 100, NULL, NULL, 'Now share the following with your mentor:<ul><li>Where was their alignment between the goals your mentor recommended and the goal you came up with on your own?</li><li>What are you looking forward to as you tackle this goal?</li><li>What do you anticipate struggling with and how can your mentor help?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (98, 540, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (99, 544, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (89, 540, 97, TRUE, 100, 1);

--Mentee Lesson 12.1.8

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (80, 5, 33, '7/2/15 00:00:00', '7/2/15 23:59:59', 'Setting 12th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (245, 80, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (246, 80, 2, 2, 3, 200, 'Read one of the following articles');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (247, 80, 2, 3, 3, 300, 'Set a SMART Goal');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (398, 245, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (399, 246, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (400, 247, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (401, 247, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (545, 398, 11, 100, NULL, NULL, 'Respond to your mentor. Consider the following:<ul><li>Answer any questions they have about your college list.</li><li>How did they suggest supporting you through your college process? What will it take for this to be successful?</li><li>What SMART goals did they recommend you focus on? Do you agree or disagree? Why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (546, 399, 11, 100, NULL, NULL, '<ul><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seRmFuaTBwWDRVU0U/view?usp=sharing" target="_blank">Article 1: My Future</a></li><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seMnRLU1FSZUg5ckU/view?usp=sharing" target="_blank">Article 2: Mapping Your Future</a></li></ul><p><p>After reading the articles, consider what you should focus on in the 1st month and the 1st semester of your senior year.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (547, 400, 11, 100, NULL, NULL, 'Now use your above focus items, mentor recommendations, and prior discussions to create your own SMART goal using the template.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (548, 400, 6, 200, NULL, 'https://docs.google.com/document/d/1n-qea9eLVes9zrqiC6xG-1HwgGTcdbWWaRLoAL0OBic/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (549, 401, 11, 100, NULL, NULL, 'Now share the following with your mentor:<ul><li>Where was their alignment between the goals your mentor recommended and the goal you came up with on your own?</li><li>What are you looking forward to as you tackle this goal?</li><li>What do you anticipate struggling with and how can your mentor help?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (100, 545, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (101, 549, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (90, 545, 97, TRUE, 100, 1);

--Mentor Lesson 12.1.8

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (81, 4, 33, '7/2/15 00:00:00', '7/2/15 23:59:59', 'Setting 12th Grade SMART Goals');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (248, 81, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (249, 81, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (402, 248, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (403, 248, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (404, 248, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (405, 249, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (550, 402, 11, 100, NULL, NULL, 'Your mentee responded to your questions and recommendations:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (551, 403, 11, 100, NULL, NULL, 'They then read and discussed the following articles and brainstormed focus areas for the first part of this year:<ul><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seRmFuaTBwWDRVU0U/view?usp=sharing" target="_blank">Article 1: My Future</a></li><li><a href="https://drive.google.com/file/d/0B-7uUglJA5seMnRLU1FSZUg5ckU/view?usp=sharing" target="_blank">Article 2: Mapping Your Future</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (552, 404, 11, 100, NULL, NULL, 'Finally, they set a SMART goal and reflected on the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (553, 404, 6, 200, NULL, 'https://docs.google.com/document/d/1n-qea9eLVes9zrqiC6xG-1HwgGTcdbWWaRLoAL0OBic/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (554, 405, 11, 100, NULL, NULL, 'Use your mentee’s SMART goal template and share your notes, questions, and suggestions for each section.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (555, 405, 6, 200, NULL, 'https://docs.google.com/document/d/1n-qea9eLVes9zrqiC6xG-1HwgGTcdbWWaRLoAL0OBic/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (91, 550, 100, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (92, 553, 101, TRUE, 100, 0);

--Staff Lesson 9.1.6

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (34, 1, '7/3/15 00:00:00', '7/3/15 23:59:59', 1, 2, 6, NULL, 'About Me: I Am');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (82, 1, 34, '7/3/15 00:00:00', '7/3/15 23:59:59', 'About Me: I Am');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (250, 82, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (251, 82, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (252, 82, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (253, 82, 2, 2, 3, 400, 'I Am');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (254, 82, 2, 3, 3, 500, 'I Am Poster');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (406, 250, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (407, 250, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (408, 250, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (409, 251, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (410, 252, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (411, 252, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (412, 253, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (413, 254, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (414, 254, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (415, 254, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (556, 406, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson builds on the I Am From poem from last week. This week, pairs will focus on who they are today and create a poster communicating their current identity, context, and goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze their mentor''s poem and examine its meaning</li><li>Select ideas and terms that effectively communicate their current identities and goals</li><li>Create an "I Am" poster that identifies and describes key qualities that they currently exhibit</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/about-me-i-am" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (557, 407, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (558, 407, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Sd2dkYZhV5_LwthmojOwobzZ70g9Mrqf_GzWyDfz3ds/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (559, 408, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (560, 408, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (561, 409, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (562, 410, 11, 100, NULL, NULL, 'Your mentor responded to your I Am From poem and then wrote one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (563, 411, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Answer your mentor’s questions.</li><li>After reading your mentor’s poem, what questions do you have?</li><li>What would you like to learn more about?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (564, 412, 9, 100, NULL, '/new_platform/static/canvas/images/9.1.6_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (565, 412, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the quote mean?</li><li>What is a prologue?</li><li>How does a prologue relate to the rest of the story?</li><li>In what ways can your "I Am From" poem be your prologue?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (566, 413, 11, 100, NULL, NULL, 'Below is a sample “I Am” poster. Check it out so you can make your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (567, 413, 9, 200, NULL, '/new_platform/static/canvas/images/i-am-sample-poster.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (568, 414, 11, 100, NULL, NULL, 'Before you get started, watch this short video to learn how to use Google Drawing.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (569, 414, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (570, 415, 11, 100, NULL, NULL, 'Start your poster by clicking <a href="https://docs.google.com/drawings/d/1JjHVIK8UPisOPbEoiF-fWLTMRaHx_fvWxrAmFTAGjZ8/edit?usp=sharing" target="_blank">here</a>.<p><p>Remember to click “Finish” just below after completing your poster.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (102, 563, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (93, 562, 91, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (94, 562, 85, TRUE, 200, 0);

--Mentor Lesson 9.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (83, 5, 34, '7/3/15 00:00:00', '7/3/15 23:59:59', 'About Me: I Am');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (255, 83, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (256, 83, 2, 2, 3, 200, 'I Am');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (257, 83, 2, 3, 3, 300, 'I Am Poster');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (416, 255, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (417, 255, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (418, 256, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (419, 257, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (420, 257, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (421, 257, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (571, 416, 11, 100, NULL, NULL, 'Your mentor responded to your I Am From poem and then wrote one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (572, 417, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>Answer your mentor’s questions.</li><li>After reading your mentor’s poem, what questions do you have?</li><li>What would you like to learn more about?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (573, 418, 9, 100, NULL, '/new_platform/static/canvas/images/9.1.6_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (574, 418, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What does the quote mean?</li><li>What is a prologue?</li><li>How does a prologue relate to the rest of the story?</li><li>In what ways can your "I Am From" poem be your prologue?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (575, 419, 11, 100, NULL, NULL, 'Below is a sample “I Am” poster. Check it out so you can make your own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (576, 419, 9, 200, NULL, '/new_platform/static/canvas/images/i-am-sample-poster.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (577, 420, 11, 100, NULL, NULL, 'Before you get started, watch this short video to learn how to use Google Drawing.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (578, 420, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (579, 421, 11, 100, NULL, NULL, 'Start your poster by clicking <a href="https://docs.google.com/drawings/d/1JjHVIK8UPisOPbEoiF-fWLTMRaHx_fvWxrAmFTAGjZ8/edit?usp=sharing" target="_blank">here</a>.<p><p>Remember to click “Finish” just below after completing your poster.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (103, 572, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (95, 571, 91, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (96, 571, 85, TRUE, 200, 0);

--Mentor Lesson 9.1.6

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (84, 4, 34, '7/3/15 00:00:00', '7/3/15 23:59:59', 'About Me: I Am');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (258, 84, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (259, 84, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (422, 258, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (423, 258, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (424, 258, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (425, 258, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (426, 259, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (427, 259, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (428, 259, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (580, 422, 11, 100, NULL, NULL, 'Your mentee read your poem, responded to your questions, and asked some of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (581, 423, 11, 100, NULL, NULL, 'Answer any questions your mentee asked.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (582, 424, 11, 100, NULL, NULL, 'They then created an “I Am” poster to share more about who they are today and what they’d like you to know.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (583, 424, 6, 200, NULL, 'https://docs.google.com/drawings/d/1JjHVIK8UPisOPbEoiF-fWLTMRaHx_fvWxrAmFTAGjZ8/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (584, 425, 11, 100, NULL, NULL, 'Share a few thoughts about your mentee’s poster.<ul><li>What resonated with you?</li><li>What did you learn about your mentee?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (585, 426, 11, 100, NULL, NULL, 'You are going to create a poster that illustrates 3-5 “I am” statements to share with your mentee.<p><p>First, brainstorm how you would complete the following sentence starters:<ul><li>I am</li><li>I see</li><li>I feel</li><li>I dream</li><li>I hope</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (586, 427, 11, 100, NULL, NULL, 'Before you get started on your “I Am” poster, watch this short video to learn how to use Google Drawing.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (587, 427, 3, 200, NULL, 'https://vimeo.com/135490195', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (588, 428, 11, 100, NULL, NULL, 'Start your poster by clicking <a href="https://docs.google.com/drawings/d/1dV74vNQldV3esu583f7py_FajgKAusLFL9xB5g8A4PU/edit?usp=sharing" target="_blank">here</a>.<p><p>Remember to click “Finish” just below when you are done with your poster.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (104, 581, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (105, 584, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (97, 580, 103, TRUE, 100, 0);

--Staff Lesson 9.1.7

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (35, 1, '7/4/15 00:00:00', '7/4/15 23:59:59', 1, 2, 7, NULL, 'Finding Similarities and Differences');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (85, 1, 35, '7/4/15 00:00:00', '7/4/15 23:59:59', 'Finding Similarities and Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (260, 85, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (261, 85, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (262, 85, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (263, 85, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (264, 85, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (429, 260, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (430, 260, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (431, 260, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (432, 261, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (433, 262, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (434, 263, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (435, 264, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (436, 264, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (589, 429, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will apply the lessons from the parable to identify and celebrate both similarities and differences between them and their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze a story to determine how cultural worldview, assumptions, and communication errors impact our interactions with other people.</li><li>Apply this information to their new relationships with their mentor.</li><li>Identify and celebrate similarities and differences between them and their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/new-pairs-finding-similarities-and-celebrating-differences-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (590, 430, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (591, 430, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jh4n-LOgLY2L2QZ7wojrBfQ5ADhiNLpUWLmw0JuCMmA/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (592, 431, 11, 100, NULL, NULL, 'If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (593, 431, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (594, 432, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (595, 433, 11, 100, NULL, NULL, 'Your mentor continued the discussion about both of your “I Am From” poems and wrote to you about your “I Am” poster.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (596, 434, 3, 100, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (597, 434, 11, 200, NULL, NULL, 'After watching the video, Hodja and The Foreigner, answer the following questions:<ul><li>​What was the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem in the story? Find evidence that supports that as the problem.</li><li>What assumptions was the Hodja making? The foreigner?</li><li>What assumptions was the entourage making? The townspeople?</li><li>What was the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (598, 435, 11, 100, NULL, NULL, 'Here is your mentor’s “I Am poster” and “I Am From” poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (599, 435, 6, 200, NULL, 'https://docs.google.com/drawings/d/1dV74vNQldV3esu583f7py_FajgKAusLFL9xB5g8A4PU/edit', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (600, 436, 11, 100, NULL, NULL, 'After reviewing their poem and poster, share the following:<ul><li>What are some key similarities you have with your mentor? Differences?</li><li>How do you think your similarities and differences can work to strengthen your relationship?</li><li>What questions do you have for your mentor?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (106, 600, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (98, 595, 104, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (99, 595, 105, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (100, 599, 85, TRUE, 100, 0);

--Mentee Lesson 9.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (86, 5, 35, '7/4/15 00:00:00', '7/4/15 23:59:59', 'Finding Similarities and Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (265, 86, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (266, 86, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (267, 86, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (437, 265, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (438, 266, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (439, 267, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (440, 267, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (601, 437, 11, 100, NULL, NULL, 'Your mentor continued the discussion about both of your “I Am From” poems and wrote to you about your “I Am” poster.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (602, 438, 3, 100, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (603, 438, 11, 200, NULL, NULL, 'After watching the video, Hodja and The Foreigner, answer the following questions:<ul><li>​What was the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem in the story? Find evidence that supports that as the problem.</li><li>What assumptions was the Hodja making? The foreigner?</li><li>What assumptions was the entourage making? The townspeople?</li><li>What was the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (604, 439, 11, 100, NULL, NULL, 'Here is your mentor’s “I Am poster” and “I Am From” poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (605, 439, 6, 200, NULL, 'https://docs.google.com/drawings/d/1dV74vNQldV3esu583f7py_FajgKAusLFL9xB5g8A4PU/edit', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (606, 440, 11, 100, NULL, NULL, 'After reviewing their poem and poster, share the following:<ul><li>What are some key similarities you have with your mentor? Differences?</li><li>How do you think your similarities and differences can work to strengthen your relationship?</li><li>What questions do you have for your mentor?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (107, 606, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (101, 601, 104, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (102, 601, 105, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (103, 605, 85, TRUE, 100, 0);

--Mentor Lesson 9.1.7

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (87, 4, 35, '7/4/15 00:00:00', '7/4/15 23:59:59', 'Finding Similarities and Differences');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (268, 87, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (269, 87, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (441, 268, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (442, 268, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (443, 269, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (444, 269, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (607, 441, 11, 100, NULL, NULL, 'Your mentee watched the video, Hodja and The Foreigner.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (608, 441, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (609, 442, 11, 100, NULL, NULL, 'They then discussed the following questions:<ul><li>What was the purpose of this story?</li><li>How does point of view impact the story?</li><li>What was the problem in the story?</li><li>What assumptions was the Hodja making? The foreigner?</li><li>What assumptions was the entourage making? The townspeople?</li><li>What was the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (610, 443, 11, 100, NULL, NULL, 'Your mentee reviewed your “I Am” poster and “I Am From” poem. They used your key similarities and differences to share how they might strengthen your relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (611, 444, 11, 100, NULL, NULL, 'Respond to your mentee and answer the following questions:<ul><li>What resonated with you from the video? How might the lessons from the video apply to your relationship with your mentee?</li><li>What stood out to in your mentee’s response?</li><li>What are key similarities and differences between you and your mentee that you’d like to highlight? How might they strengthen your relationship?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (108, 611, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (104, 610, 107, TRUE, 100, 0);