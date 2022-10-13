--12.3.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (79, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 16, 2, NULL, 'My College Essay', '/new_platform/static/canvas/images/12.3.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (217, 1, 79, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Essay');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (709, 217, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (710, 217, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (711, 217, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (712, 217, 2, 2, 3, 400, 'Tips for writing a strong college essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (713, 217, 2, 3, 3, 500, 'Your mentor’s college essay');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1279, 709, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1280, 709, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1281, 710, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1282, 711, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1283, 712, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1284, 713, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1285, 713, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1686, 1279, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce tips for writing a successful college essay and give mentees an opportunity to brainstorm on first sentences and ideas if they haven’t already started.<p><p>In this lesson, mentees will:<ul><li>Watch and review a video on tips for writing a strong essay</li><li>Identify, review and evaluate essay prompts</li><li>Brainstorm and write essay starters</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-college-essay" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1687, 1280, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1688, 1280, 6, 200, NULL, 'https://docs.google.com/presentation/d/17K5vWxUJew7cKA0bSt1nuHMQqg6nEOsoF0o8beuf43k/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1689, 1281, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1690, 1282, 11, 100, NULL, NULL, 'Your mentor answered your questions and provided feedback on your areas of strength and growth.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1691, 1283, 11, 100, NULL, NULL, 'Watch the video and consider the following:<ul><li>What are the 5 tips for writing a strong college essay?</li><li>Why are they important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1692, 1283, 3, 200, NULL, 'https://vimeo.com/140458994', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1693, 1284, 11, 100, NULL, NULL, 'Your mentor shared details about their college essay and tips for writing yours. Respond with questions and thoughts about what they shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1694, 1285, 11, 100, NULL, NULL, 'What topic or experience are you interested in writing about? Share your topic or experience and why you selected it.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (368, 1693, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (369, 1694, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (355, 1690, 259, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (356, 1690, 260, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (357, 1693, 261, TRUE, 100, 0);

--12.3.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (218, 5, 79, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Essay');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (714, 218, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (715, 218, 2, 2, 3, 200, 'Tips for writing a strong college essay');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (716, 218, 2, 3, 3, 300, 'Your mentor’s college essay');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1286, 714, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1287, 715, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1288, 716, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1289, 716, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1695, 1286, 11, 100, NULL, NULL, 'Your mentor answered your questions and provided feedback on your areas of strength and growth.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1696, 1287, 11, 100, NULL, NULL, 'Watch the video and consider the following:<ul><li>What are the 5 tips for writing a strong college essay?</li><li>Why are they important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1697, 1287, 3, 200, NULL, 'https://vimeo.com/140458994', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1698, 1288, 11, 100, NULL, NULL, 'Your mentor shared details about their college essay and tips for writing yours. Respond with questions and thoughts about what they shared.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1699, 1289, 11, 100, NULL, NULL, 'What topic or experience are you interested in writing about? Share your topic or experience and why you selected it.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (370, 1698, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (371, 1699, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (358, 1695, 259, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (359, 1695, 260, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (360, 1698, 261, TRUE, 100, 0);

--12.3.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (219, 4, 79, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My College Essay');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (717, 219, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (718, 219, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1290, 717, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1291, 717, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1292, 718, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1293, 718, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1700, 1290, 11, 100, NULL, NULL, 'Your mentee’s class was all about the college essay.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1701, 1290, 3, 200, NULL, 'https://vimeo.com/140458994', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1702, 1291, 11, 100, NULL, NULL, 'Your mentee reviewed sample essay prompts and read essay starters from real college essays to help them brainstorm topics of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1703, 1291, 8, 200, NULL, '/new_platform/static/canvas/documents/EssayStarters.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1704, 1292, 11, 100, NULL, NULL, 'Answer your mentee’s questions and respond to their thoughts.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1705, 1293, 11, 100, NULL, NULL, 'Your mentee shared the topic or experience they’re interested in writing about for their college essay. Respond to your mentee and provide feedback on what they shared.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (372, 1704, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (373, 1705, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (361, 1704, 370, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (362, 1705, 371, TRUE, 100, 0);