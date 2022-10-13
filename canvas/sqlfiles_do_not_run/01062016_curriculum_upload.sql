--11.8.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (122, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 28, 3, NULL, 'My College Fit: Checklist', '/new_platform/static/canvas/images/11.8.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (345, 1, 122, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Checklist');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1120, 345, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1121, 345, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1122, 345, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1123, 345, 2, 3, 4, 400, 'Now it’s your turn…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1124, 345, 2, 3, 4, 500, 'Comparing your checklists');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1130, 345, 2, 2, 4, 350, 'Your mentor’s College Fit Checklist');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1987, 1120, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1988, 1120, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1989, 1121, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1990, 1122, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1991, 1130, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1992, 1123, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1993, 1124, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2606, 1987, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will provide mentees with an opportunity to summarize their thoughts and preferences on the various college fit categories and document those preferences using a checklist to be shared with their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review a sample college fit checklist and discuss how each of the items did or did not impact the individual''s college experience.</li><li>Complete a college fit checklist where they''ll identify preferences they have, explain which categories matter most to them and why, and ask questions about categories for which they are undecided.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/college-fit-checklist" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2607, 1988, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2608, 1988, 6, 200, NULL, 'https://docs.google.com/presentation/d/14wP1_0tmCHWOxOOCf0zd5QGPpvIR6j0X2V17EMn1gS8/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2609, 1989, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2610, 1990, 11, 100, NULL, NULL, 'Your mentor responded to your college preferences.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2611, 1991, 11, 100, NULL, NULL, 'Your mentor also created a College Fit Checklist, which highlights their preferences that guided their college selection process.<p><p>Review their checklist to help you create your own.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2612, 1991, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/12DSH12ssE57i94c8kvrU3iPqx6nrkYEBwazaVJV2amU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2613, 1992, 11, 100, NULL, NULL, '<ol><li>Write in your preference, if you have one, for each category.</li><li>Rate your strength of preference in each category on a scale from 1 to 5 (1 = no preference, 5 = strong preference).</li><li>Explain why you chose that rating.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2614, 1992, 6, 200, NULL, 'https://docs.google.com/document/d/1Hc2zIXwTIDBJcp1bVHR5dmy0G8oNKKxCgJToHxrL5Hw/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2615, 1993, 11, 100, NULL, NULL, 'Compare your checklist with your mentor’s and tell them the following:<ul><li>How are your preferences similar?</li><li>How are they different?</li><li>What questions do you have about your mentor’s college fit preferences? Is there anything you’d like to learn more about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (560, 2615, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (532, 2610, 559, TRUE, 100, 0);

--11.8.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (346, 5, 122, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Checklist');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1125, 346, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1126, 346, 2, 3, 4, 200, 'Now it’s your turn…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1127, 346, 2, 3, 4, 300, 'Comparing your checklists');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1131, 346, 2, 2, 4, 150, 'Your mentor’s College Fit Checklist');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1994, 1125, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1995, 1131, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1996, 1126, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1997, 1127, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2616, 1994, 11, 100, NULL, NULL, 'Your mentor responded to your college preferences.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2617, 1995, 11, 100, NULL, NULL, 'Your mentor also created a College Fit Checklist, which highlights their preferences that guided their college selection process.<p><p>Review their checklist to help you create your own.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2618, 1995, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/document/d/12DSH12ssE57i94c8kvrU3iPqx6nrkYEBwazaVJV2amU/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2619, 1996, 11, 100, NULL, NULL, '<ol><li>Write in your preference, if you have one, for each category.</li><li>Rate your strength of preference in each category on a scale from 1 to 5 (1 = no preference, 5 = strong preference).</li><li>Explain why you chose that rating.</li></ol>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2620, 1996, 6, 200, NULL, 'https://docs.google.com/document/d/1Hc2zIXwTIDBJcp1bVHR5dmy0G8oNKKxCgJToHxrL5Hw/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2621, 1997, 11, 100, NULL, NULL, 'Compare your checklist with your mentor’s and tell them the following:<ul><li>How are your preferences similar?</li><li>How are they different?</li><li>What questions do you have about your mentor’s college fit preferences? Is there anything you’d like to learn more about?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (561, 2621, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (533, 2616, 559, TRUE, 100, 0);

--11.8.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (347, 4, 122, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Fit: Checklist');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1128, 347, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1129, 347, 2, 2, 2, 200, 'Your mentee’s college list');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1998, 1128, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1999, 1128, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2000, 1128, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2001, 1129, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2622, 1998, 11, 100, NULL, NULL, 'Your mentee reviewed your College Fit Checklist, discussed it in class, and created their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2623, 1998, 6, 200, NULL, 'https://docs.google.com/document/d/1Hc2zIXwTIDBJcp1bVHR5dmy0G8oNKKxCgJToHxrL5Hw/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2624, 1999, 11, 100, NULL, NULL, 'Your mentee compared your checklist with theirs and shared the following with you:<ul><li>How are your preferences similar?</li><li>How are they different?</li><li>What questions do you have about your mentor’s college fit preferences? Is there anything you’d like to learn more about?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2625, 2000, 11, 100, NULL, NULL, 'Share your comments about your mentee’s College Fit Checklist and answer any questions they asked.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2626, 2001, 11, 100, NULL, NULL, 'Next week, your mentee will begin building their college list, a process that will help them decide which schools they will ultimately apply to. It’ll be your role as a mentor to help your mentee build a balanced list that aligns with their college fit preferences.<p><p>To aid in this process, you and your mentee will be using the <a href="/cchklist/list/" target="_blank">college list tool</a> on the platform. Unlike similar tools on other websites, our tool is a collaborative one designed to provide you, their mentor, an opportunity to view, comment on, question, and confirm that the colleges on their list are in fact good fits. Your staff member will also be viewing the tool and will help answer any questions you and your mentee might have.</p></p>Review <a href="https://learn.imentor.org/help/article/link/navigating-the-college-checklist---page-1" target="_blank">this resource</a> to learn more about the college list tool.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (562, 2625, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (534, 2624, 561, TRUE, 100, 0);