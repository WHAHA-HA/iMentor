--Update previous lessons

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.10.2.jpg'
WHERE id = 162;

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.10.3.jpg'
WHERE id = 166;

--12.10.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (167, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 40, 4, NULL, 'End of Year Celebration', '/new_platform/static/canvas/images/12.10.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (477, 1, 167, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Celebration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1462, 477, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1463, 477, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1464, 477, 2, 1, 1, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2499, 1462, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2500, 1462, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2501, 1463, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2502, 1464, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2503, 1464, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3238, 2499, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will reflect on and celebrate their experience with iMentor during high school and the relationships they have built with their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Reflect on and celebrate their experiences in the high school program</li><li>Create a thank you card for their mentors</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3239, 2500, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3240, 2500, 6, 200, NULL, 'https://docs.google.com/presentation/d/1agOChqrJfv56TvHmIu41ScuT4_JxSFBj04DCBIym6Es/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3241, 2501, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3242, 2502, 11, 100, NULL, NULL, 'Your mentor responded to you from last week and offered their own suggestions for how you can be successful.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3243, 2503, 11, 100, NULL, NULL, 'Use Conversations to share any reflections and thank your mentor for their support.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (658, 3242, 701, TRUE, 100, 0);

--12.10.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (478, 5, 167, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Celebration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1465, 478, 2, 1, 1, 100, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2504, 1465, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2505, 1465, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3244, 2504, 11, 100, NULL, NULL, 'Your mentor responded to you from last week and offered their own suggestions for how you can be successful.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3245, 2505, 11, 100, NULL, NULL, 'Use Conversations to share any reflections and thank your mentor for their support.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (659, 3244, 701, TRUE, 100, 0);

--12.10.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (479, 4, 167, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Celebration');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1466, 479, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1467, 479, 2, 2, 2, 200, 'And one last thing');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2506, 1466, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2507, 1467, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3246, 2506, 11, 100, NULL, NULL, 'Your mentee looked back over the year and reflected on their highlights. Please use <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a> to connect with your mentee.<p><p>To open Conversations, click the icon at the top right of your screen. Below is an image of the icon.</p></p><img src="/new_platform/static/canvas/images/Conversations_Icon.png" /><p><p>Have additional questions about Conversations? Click <a href="https://learn.imentor.org/help/article/link/conversations-faqs-for-mentors" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3247, 2507, 9, 100, NULL, '/new_platform/static/canvas/images/Thank_You_Card.jpg', NULL, NULL);