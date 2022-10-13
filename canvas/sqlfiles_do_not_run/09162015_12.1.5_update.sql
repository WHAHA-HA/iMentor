--Update the curriculum descriptions and member site restrictions necessary only at the master level

UPDATE canvas_curriculum
SET description = 'Completing My College List', member_id = NULL
WHERE id = 28;

UPDATE canvas_curriculum_copy
SET description = 'Completing My College List'
WHERE parent_id = 28;

--Now update the content of the staff lesson to work for partner programs as well as NYC

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (216, 64, 2, 1, 1, 400, 'Read your mentor’s response');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (355, 216, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (492, 355, 11, 100, NULL, NULL, 'Your mentor responded to your commitment from last week.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (79, 492, 78, TRUE, 100, 0);

--Do the same for the mentee lesson

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (217, 65, 2, 1, 1, 200, 'Read your mentor’s response');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (356, 217, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (493, 356, 11, 100, NULL, NULL, 'Your mentor responded to your commitment from last week.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (80, 493, 78, TRUE, 100, 0);