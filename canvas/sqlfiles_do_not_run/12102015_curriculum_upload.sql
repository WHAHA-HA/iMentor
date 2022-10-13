--11.6.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (26, 6, 'College Visits', NULL, 'How can I make the most of a college visit?');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (26, 3, 26, '<ul><li>What were the most important takeaways from your visit?</li></ul>', '<ul><li>What were the most important takeaways from your visit?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (111, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 26, 1, NULL, 'Visiting College', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (312, 1, 111, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Visiting College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1014, 312, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1015, 312, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1016, 312, 2, 1, 2, 300, 'Making the most of college visits');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1017, 312, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1816, 1014, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1817, 1014, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1818, 1015, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1819, 1016, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1820, 1016, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1821, 1017, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2392, 1816, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to help mentees either prepare for or debrief a college campus visit.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Prepare: use a college visit checklist to understand and prioritize what they want to see and learn on their upcoming college visit</li><li>Debrief: use a college visit checklist to reflect on and categorize what they saw and learned on their most recent college visit</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/visiting-colleges" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2393, 1817, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2394, 1817, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Mtpa16ND2BSkQpS9qk4g7sd3ETtk0hKyDQYodWmRpMc/embed?', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2395, 1818, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2396, 1819, 11, 100, NULL, NULL, 'Review the following checklist:<ul><li>If you’ve already visited a college, did you get all the information you needed?</li><li>If you are preparing for an upcoming visit, use this list to gather information.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2397, 1819, 8, 200, NULL, '/new_platform/static/canvas/documents/Campus_Visit_Checklist.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2398, 1820, 11, 100, NULL, NULL, 'You can view, save, or print the PDF by following <a href="https://drive.google.com/file/d/0B-7uUglJA5seNTNHY3hVb3RqNlE/view?usp=sharing" target="_blank">this link</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2399, 1821, 11, 100, NULL, NULL, 'Which specific items from the above checklist are most important to you as you are deciding between colleges? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (507, 2399, 100, 0, 2);

--11.6.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (313, 5, 111, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Visiting College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1018, 313, 2, 1, 2, 100, 'Making the most of college visits');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1019, 313, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1822, 1018, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1823, 1018, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1824, 1019, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2400, 1822, 11, 100, NULL, NULL, 'Review the following checklist:<ul><li>If you’ve already visited a college, did you get all the information you needed?</li><li>If you are preparing for an upcoming visit, use this list to gather information.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2401, 1822, 8, 200, NULL, '/new_platform/static/canvas/documents/Campus_Visit_Checklist.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2402, 1823, 11, 100, NULL, NULL, 'You can view, save, or print the PDF by following <a href="https://drive.google.com/file/d/0B-7uUglJA5seNTNHY3hVb3RqNlE/view?usp=sharing" target="_blank">this link</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2403, 1824, 11, 100, NULL, NULL, 'Which specific items from the above checklist are most important to you as you are deciding between colleges? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (508, 2403, 100, 0, 2);

--11.6.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (314, 4, 111, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Visiting College');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1020, 314, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1825, 1020, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1826, 1020, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1827, 1020, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2404, 1825, 11, 100, NULL, NULL, 'Your mentee is preparing for college visits and reviewed the following checklist to make sure they are getting as much as possible out of the experience.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2405, 1825, 8, 200, NULL, '/new_platform/static/canvas/documents/Campus_Visit_Checklist.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2406, 1826, 11, 100, NULL, NULL, 'You can view, save, or print the PDF by following <a href="https://drive.google.com/file/d/0B-7uUglJA5seNTNHY3hVb3RqNlE/view?usp=sharing" target="_blank">this link</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2407, 1827, 11, 100, NULL, NULL, 'Your mentee shared something they learned or are excited to learn.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (492, 2407, 508, TRUE, 100, 0);