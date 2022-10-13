--11.8.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (123, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 28, 4, NULL, 'My College List', '/new_platform/static/canvas/images/11.8.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (348, 1, 123, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1132, 348, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1133, 348, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1134, 348, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1135, 348, 2, 2, 3, 400, 'Your College List Research Template');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1136, 348, 2, 3, 3, 500, 'Updating Your College List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2002, 1132, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2003, 1132, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2004, 1133, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2005, 1134, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2006, 1135, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2007, 1136, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2627, 2002, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will be introduced to the process of building a college list and the college list tool on our platform. After understanding the tool and process, mentees will begin researching colleges to add to their list.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify and define the purpose and role of a college list.</li><li>Review and define all college fit categories, academic profile, and personal preference.</li><li>Begin to research colleges that may go on their list.</li><li>Add at least 3 colleges to their college lists.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-list" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2628, 2003, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2629, 2003, 6, 200, NULL, 'https://docs.google.com/presentation/d/1eYBHN8Wbq3Sa46a20BoB8-99tNWnqVbvPHPMvBNoB_Y/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2630, 2004, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2631, 2005, 11, 100, NULL, NULL, 'Your mentor shared feedback on your College Fit Checklist and comments.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2632, 2006, 11, 100, NULL, NULL, 'Use the following websites and your College List Research Template to find colleges that align to your preferences.<ul><li><a href="https://bigfuture.collegeboard.org/college-search" target="_blank">BigFuture</a></li><li><a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2633, 2006, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1u8F99YCvOV8QpMFhn-1aT4Oc-MREagO_VN0WDLUoYIs/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2634, 2007, 11, 100, NULL, NULL, 'Once you’ve decided to apply to a school, add the college to your college list. Your college list tool is available by clicking the menu on the top left of the screen.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (535, 2631, 562, TRUE, 100, 0);

--11.8.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (349, 5, 123, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1137, 349, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1138, 349, 2, 2, 3, 200, 'Your College List Research Template');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1139, 349, 2, 3, 3, 300, 'Updating Your College List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2008, 1137, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2009, 1138, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2010, 1139, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2635, 2008, 11, 100, NULL, NULL, 'Your mentor shared feedback on your College Fit Checklist and comments.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2636, 2009, 11, 100, NULL, NULL, 'Use the following websites and your College List Research Template to find colleges that align to your preferences.<ul><li><a href="https://bigfuture.collegeboard.org/college-search" target="_blank">BigFuture</a></li><li><a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a></li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2637, 2009, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1u8F99YCvOV8QpMFhn-1aT4Oc-MREagO_VN0WDLUoYIs/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2638, 2010, 11, 100, NULL, NULL, 'Once you’ve decided to apply to a school, add the college to your college list. Your college list tool is available by clicking the menu on the top left of the screen.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (536, 2635, 562, TRUE, 100, 0);

--11.8.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (350, 4, 123, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1140, 350, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1141, 350, 2, 2, 3, 200, 'Support your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1142, 350, 2, 3, 3, 300, 'Share with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2011, 1140, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2012, 1141, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2013, 1142, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2639, 2011, 11, 100, NULL, NULL, 'Your mentee started to research colleges that they’re interested in applying to next year. Over the next several weeks in class (and months leading up to their senior year), your mentee will be researching colleges, confirming their alignment to their fit preferences, and adding schools they intend on applying to their list.<p><p>Review their research and progress below.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2640, 2011, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/1u8F99YCvOV8QpMFhn-1aT4Oc-MREagO_VN0WDLUoYIs/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2641, 2012, 11, 100, NULL, NULL, 'One size does not fit all when it comes to colleges. It is important that your mentee build a list of schools that align with their fit preferences and optimize their chances for admittance and success. Here are 3 ways you can help.<ol><li>Your mentee will build their college list using our college list tool. It’s designed to be a collaborative tool for you, your mentee and staff member to build the best list possible. Familiarize yourself with this tool and check back frequently. If you’ve seen your mentee’s progress stall, talk about it. Open the <a href="/cchklist/list/" target="_blank">college list tool</a>. <i>Note: This tool is also always available using the menu at the top left of the screen.</i></li><li>Help your mentee research schools. You can use websites like <a href="https://bigfuture.collegeboard.org/college-search" target="_blank">BigFuture</a> and <a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a> to determine if schools align with your mentee’s fit preferences. The research template in Section 1 is a tool to help you understand and document what things you should be looking for when helping with research.</li><li>Help your mentee stay on task and complete their list on time. It’s easy to work on a college list once or twice and not think about it again until senior year.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2642, 2013, 11, 100, NULL, NULL, 'This is a big step for your mentee! Review their progress, provide feedback, and offer encouragement during this important step of the process. As you respond, think about the following:<ul><li>Do the colleges they’ve selected align with the preferences you’ve identified and discussed?</li><li>Did they choose at least three colleges? If not, how can you help?</li><li>Are there other colleges you think might be a good fit for them? If so, share them.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (563, 2642, 100, 0, 2);

--11.8.5 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (124, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 28, 5, NULL, 'My College List Part II', '/new_platform/static/canvas/images/11.8.5.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (351, 1, 124, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1143, 351, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1144, 351, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1145, 351, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1146, 351, 2, 2, 3, 400, 'Continuing your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1147, 351, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2014, 1143, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2015, 1143, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2016, 1144, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2017, 1145, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2018, 1146, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2019, 1147, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2643, 2014, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will continue to research schools and build their college lists.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Continue to research colleges that may go on their list</li><li>Complete an initial draft of their list with at least 7-10 colleges on it</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-list-part-2" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2644, 2015, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2645, 2015, 6, 200, NULL, 'https://docs.google.com/presentation/d/1RV9OJXr2yE0gVB-g0k8Ay4UDx7CG3R4NRMArOPXQFiE/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2646, 2016, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2647, 2017, 11, 100, NULL, NULL, 'Your mentor shared feedback on the colleges you researched during class.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2648, 2018, 11, 100, NULL, NULL, 'As you continue working on your college list, remember the following websites are available to help you research:<ul><li><a href="https://bigfuture.collegeboard.org/college-search" target="_blank">BigFuture</a></li><li><a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a></li></ul><p><p>You can also refer back to your College Fit Checklist and College List Research Template by accessing <a href="/portfolio/#/resources/" target="_blank">My Files</a> in Portfolio.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2649, 2019, 11, 100, NULL, NULL, '<ul><li>Overall, how are you feeling about the process of building a college list?</li><li>Share a personal update.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (564, 2649, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (537, 2647, 563, TRUE, 100, 0);

--11.8.5 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (352, 5, 124, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1148, 352, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1149, 352, 2, 2, 3, 200, 'Continuing your college list');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1150, 352, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2020, 1148, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2021, 1149, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2022, 1150, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2650, 2020, 11, 100, NULL, NULL, 'Your mentor shared feedback on the colleges you researched during class.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2651, 2021, 11, 100, NULL, NULL, 'As you continue working on your college list, remember the following websites are available to help you research:<ul><li><a href="https://bigfuture.collegeboard.org/college-search" target="_blank">BigFuture</a></li><li><a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a></li></ul><p><p>You can also refer back to your College Fit Checklist and College List Research Template by accessing <a href="/portfolio/#/resources/" target="_blank">My Files</a> in Portfolio.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2652, 2022, 11, 100, NULL, NULL, '<ul><li>Overall, how are you feeling about the process of building a college list?</li><li>Share a personal update.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (565, 2652, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (538, 2650, 563, TRUE, 100, 0);

--11.8.5 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (353, 4, 124, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College List Part II');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1151, 353, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2023, 1151, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2024, 1151, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2653, 2023, 11, 100, NULL, NULL, 'Your mentee continued to build their college list. Although this is the final lesson in this unit, this work will be ongoing as they continue to research colleges and refine their lists.<p><p>You can always access the list through the menu at the top left of the screen. Keep the conversation going until you both feel you’ve created a well balanced list.</p></p>As you work with your mentee to refine their list, check out the following resource:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2654, 2023, 6, 200, NULL, 'https://docs.google.com/presentation/d/1oKgY7eNPzstmaGEyJyY7hysVPyz31M5xhp_tAIhOmvs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2655, 2024, 11, 100, NULL, NULL, 'Your mentee also shared their overall feelings about the college list process.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (539, 2655, 565, TRUE, 100, 0);