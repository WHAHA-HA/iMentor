--12.99.1 Staff, Mentee, and Mentor Lesson (for Yassi in NYC as a pilot of Conversations)

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (41, 99, 'Conversations', 'conversations', 'We''ll use Conversations to connect.');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (41, 4, 41, '<ul><li>This unit is all about free Conversations, so there is no reflection.</li><li>Enjoy!</li></ul>', '<ul><li>This unit is all about Conversations, so there is no reflection.</li><li>Enjoy!</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (161, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 41, 1, 1, 'Conversations', '/new_platform/static/canvas/images/Conversations_Lesson_1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (459, 1, 161, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (460, 5, 161, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (461, 4, 161, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Conversations');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1439, 459, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1440, 460, 2, 1, 1, 100, 'Conversations');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1441, 461, 2, 1, 1, 100, 'Conversations');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2468, 1439, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2469, 1440, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2470, 1441, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3205, 2468, 11, 100, NULL, NULL, 'This week, pairs will be connecting through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. Consider providing a prompt for those pairs who need additional instruction.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3206, 2469, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentor through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>. To open Conversations, click the icon at the top right of your screen.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3207, 2470, 11, 100, NULL, NULL, 'This week, you will be connecting with your mentee through <a href="https://learn.imentor.org/help/article/link/welcome-to-conversations" target="_blank">Conversations</a>.<p><p>To open Conversations, click the icon at the top right of your screen. Below is an image of the icon.</p></p><img src="/new_platform/static/canvas/images/Conversations_Icon.png" /><p><p>Have additional questions about Conversations? Click <a href="https://learn.imentor.org/help/article/link/conversations-faqs-for-mentors" target="_blank">here</a>.</p></p>', NULL);