--9.4.4 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (104, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 21, 4, NULL, 'Staying on Track', '/new_platform/static/canvas/images/9.4.4.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (291, 1, 104, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Staying on Track');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (951, 291, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (952, 291, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (953, 291, 2, 1, 3, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (954, 291, 2, 2, 3, 400, 'Staying on track');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (955, 291, 2, 3, 3, 500, 'Share an update');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1699, 951, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1700, 951, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1701, 952, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1702, 953, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1703, 954, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1704, 955, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1705, 955, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2241, 1699, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages pairs in understanding what it means to stay on track to graduate from high school.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Understand the graduation requirements at their high school</li><li>Know what opportunities their school provides to stay on track toward these requirements</li><li>Reflect on their personal progress toward high school graduation requirements</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-staying-on-track" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2242, 1700, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2243, 1700, 6, 200, NULL, 'https://docs.google.com/presentation/d/1JXH3W7A-RiYiqgGyDI5QRB6hTBUC_jr2BbjebY9k5Co/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2244, 1701, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2245, 1702, 11, 100, NULL, NULL, 'Your mentor shared some thoughts about the PSA you created last week. Check it out!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2246, 1703, 11, 100, NULL, NULL, 'Tell your mentor how you are doing in school. What challenges are you experiencing or do you think you might experience on your path to high school graduation?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2247, 1704, 11, 100, NULL, NULL, 'Your mentor also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2248, 1705, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (471, 2246, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (472, 2248, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (454, 2245, 461, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (455, 2247, 462, TRUE, 100, 0);

--9.4.4 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (292, 5, 104, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Staying on Track');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (956, 292, 2, 1, 3, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (957, 292, 2, 2, 3, 200, 'Staying on track');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (958, 292, 2, 3, 3, 300, 'Share an update');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1706, 956, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1707, 957, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1708, 958, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1709, 958, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2249, 1706, 11, 100, NULL, NULL, 'Your mentor shared some thoughts about the PSA you created last week. Check it out!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2250, 1707, 11, 100, NULL, NULL, 'Tell your mentor how you are doing in school. What challenges are you experiencing or do you think you might experience on your path to high school graduation?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2251, 1708, 11, 100, NULL, NULL, 'Your mentor also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2252, 1709, 11, 100, NULL, NULL, 'Respond to your mentor and share an update of your own.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (473, 2250, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (474, 2252, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (456, 2249, 461, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (457, 2251, 462, TRUE, 100, 0);

--9.4.4 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (293, 4, 104, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Staying on Track');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (959, 293, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (960, 293, 2, 2, 2, 200, 'Read your mentee’s reflection');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1710, 959, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1711, 959, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1712, 960, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2253, 1710, 11, 100, NULL, NULL, 'Your mentee read and responded to your comments on their PSA and personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2254, 1711, 11, 100, NULL, NULL, 'Then, your mentee learned about city-wide and school-specific high school graduation requirements.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2255, 1712, 11, 100, NULL, NULL, 'Your mentee shared how they are doing academically. They also shared some challenges they are currently experiencing or think they will experience on their road to high school graduation.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (458, 2253, 474, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (459, 2255, 473, TRUE, 100, 0);