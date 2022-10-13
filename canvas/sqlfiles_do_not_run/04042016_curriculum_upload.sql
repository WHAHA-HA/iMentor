--12.99.2 Staff, Mentee, and Mentor Lesson (for Yassi in NYC as a pilot of Conversations)

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (163, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 41, 2, 1, 'Conversations', '/new_platform/static/canvas/images/Conversations_Lesson_2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (465, 1, 163, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (466, 5, 163, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (467, 4, 163, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1448, 465, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1449, 466, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1450, 467, 2, 1, 1, 100, 'Conversations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2481, 1448, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2482, 1449, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2483, 1450, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3219, 2481, 11, 100, NULL, NULL, 'This week, pairs will be connecting through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. Consider providing a prompt for those pairs who need additional instruction.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3220, 2482, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentor through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. To open Conversations, click the icon at the top right of your screen.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3221, 2483, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentee through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>.<p><p>To open Conversations, click the icon at the top right of your screen. Below is an image of the icon.</p></p><img src="/new_platform/static/canvas/images/Conversations_Icon.png" /><p><p>Have additional questions about Conversations? Click <a href="https://learn.imentor.org/help/article/link/conversations-faqs-for-mentors" target="_blank">here</a>.</p></p>', NULL);

--12.99.3 Staff, Mentee, and Mentor Lesson (for Yassi in NYC as a pilot of Conversations)

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (164, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 41, 3, 1, 'Conversations: Part III', '/new_platform/static/canvas/images/Conversations_Lesson_3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (468, 1, 164, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (469, 5, 164, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (470, 4, 164, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1451, 468, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1452, 469, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1453, 470, 2, 1, 1, 100, 'Conversations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2484, 1451, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2485, 1452, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2486, 1453, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3222, 2484, 11, 100, NULL, NULL, 'This week, pairs will be connecting through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. Consider providing a prompt for those pairs who need additional instruction.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3223, 2485, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentor through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. To open Conversations, click the icon at the top right of your screen.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3224, 2486, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentee through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>.<p><p>To open Conversations, click the icon at the top right of your screen. Below is an image of the icon.</p></p><img src="/new_platform/static/canvas/images/Conversations_Icon.png" /><p><p>Have additional questions about Conversations? Click <a href="https://learn.imentor.org/help/article/link/conversations-faqs-for-mentors" target="_blank">here</a>.</p></p>', NULL);

--12.99.4 Staff, Mentee, and Mentor Lesson (for Yassi in NYC as a pilot of Conversations)

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (165, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 41, 4, 1, 'Conversations: Part IV', '/new_platform/static/canvas/images/Conversations_Lesson_4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (471, 1, 165, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (472, 5, 165, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (473, 4, 165, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1454, 471, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1455, 472, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1456, 473, 2, 1, 1, 100, 'Conversations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2487, 1454, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2488, 1455, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2489, 1456, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3225, 2487, 11, 100, NULL, NULL, 'This week, pairs will be connecting through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. Consider providing a prompt for those pairs who need additional instruction.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3226, 2488, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentor through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. To open Conversations, click the icon at the top right of your screen.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3227, 2489, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentee through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>.<p><p>To open Conversations, click the icon at the top right of your screen. Below is an image of the icon.</p></p><img src="/new_platform/static/canvas/images/Conversations_Icon.png" /><p><p>Have additional questions about Conversations? Click <a href="https://learn.imentor.org/help/article/link/conversations-faqs-for-mentors" target="_blank">here</a>.</p></p>', NULL);