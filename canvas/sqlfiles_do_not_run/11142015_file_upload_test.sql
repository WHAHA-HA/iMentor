--Mentee and Mentor File Upload Test

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (96, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 2, 999, 197, 'Upload Card Tests', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (268, 4, 96, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Upload Card Tests');
INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (269, 5, 96, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Upload Card Tests');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (871, 268, 2, 1, 1, 100, 'Upload your favorite file');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (872, 269, 2, 1, 1, 100, 'Review your mentor''s favorite file');


INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1563, 871, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1564, 872, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1654, 871, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1655, 871, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1656, 872, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1657, 872, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1658, 872, 400);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2065, 1563, 11, 100, NULL, NULL, 'Below you will upload your favorite file, eg a picture of a baby or a puppy.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2066, 1564, 11, 100, NULL, NULL, 'Your mentor uploaded their favorite file below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2181, 1654, 11, 100, NULL, NULL, 'Upload your next favorite file, which may be a kitten or a picture of a sunset.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2182, 1655, 11, 100, NULL, NULL, 'Check out your mentee''s two favorite files below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2183, 1656, 11, 100, NULL, NULL, 'Now it''s your turn to upload a file.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2184, 1657, 11, 100, NULL, NULL, 'How about you upload one more for your mentor?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2185, 1658, 11, 100, NULL, NULL, 'Below is another file from your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (451, 2065, 100, 0, 7);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (468, 2181, 100, 0, 7);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (469, 2183, 100, 0, 7);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (470, 2184, 100, 0, 7);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (428, 2066, 451, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (451, 2182, 469, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (452, 2182, 470, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (453, 2185, 468, TRUE, 100, 0);