--My Files Update

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1uyQSr_jMSk0kp8dED-tiOAbx2Imd4OlBCzPOnNYRZ3c', 'Mentee Thank You Card');

--9.8.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (159, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 39, 3, NULL, 'Thank You', '/new_platform/static/canvas/images/9.8.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (453, 1, 159, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1423, 453, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1424, 453, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1425, 453, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1426, 453, 2, 2, 2, 400, 'Thank your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2445, 1423, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2446, 1423, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2447, 1424, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2448, 1425, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2449, 1425, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2450, 1426, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3175, 2445, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In the final lesson, mentees will write a thank you card to their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Appreciate each other and staff member.</li><li>Create a thank you card to their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/thank-you-9" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3176, 2446, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3177, 2446, 6, 200, NULL, 'https://docs.google.com/presentation/d/1hP8ZzATNCujAwYGJzDpESkDADrK3FwooJxK_oXUbBHo/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3178, 2447, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3179, 2448, 11, 100, NULL, NULL, 'Your mentor shared their summer plans with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3180, 2449, 11, 100, NULL, NULL, 'They also wanted to share the following thank you card.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3181, 2449, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/drawings/d/1UvlJUgUc1DnoO90Xnf42l89jhlQcOsT-WhnidkqvB94/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3182, 2450, 11, 100, NULL, NULL, 'Make a thank you card for your mentor. Be creative. You can use words, images, and shapes to express yourself.<p><p>Open your thank you card template <a href="https://docs.google.com/a/imentor.org/drawings/d/1uyQSr_jMSk0kp8dED-tiOAbx2Imd4OlBCzPOnNYRZ3c/edit?usp=sharing" target="_blank">here</a>.</p></p>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (649, 3179, 690, TRUE, 100, 0);

--9.8.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (454, 5, 159, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1427, 454, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1428, 454, 2, 2, 2, 200, 'Thank your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2451, 1427, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2452, 1427, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2453, 1428, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3183, 2451, 11, 100, NULL, NULL, 'Your mentor shared their summer plans with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3184, 2452, 11, 100, NULL, NULL, 'They also wanted to share the following thank you card.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3185, 2452, 6, 200, NULL, 'https://docs.google.com/a/imentor.org/drawings/d/1UvlJUgUc1DnoO90Xnf42l89jhlQcOsT-WhnidkqvB94/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3186, 2453, 11, 100, NULL, NULL, 'Make a thank you card for your mentor. Be creative. You can use words, images, and shapes to express yourself.<p><p>Open your thank you card template <a href="https://docs.google.com/a/imentor.org/drawings/d/1uyQSr_jMSk0kp8dED-tiOAbx2Imd4OlBCzPOnNYRZ3c/edit?usp=sharing" target="_blank">here</a>.</p></p>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (650, 3183, 690, TRUE, 100, 0);

--9.8.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (455, 4, 159, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1429, 455, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1430, 455, 2, 2, 2, 200, 'And one last thing');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2454, 1429, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2455, 1430, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3187, 2454, 6, 100, NULL, 'https://docs.google.com/a/imentor.org/drawings/d/1uyQSr_jMSk0kp8dED-tiOAbx2Imd4OlBCzPOnNYRZ3c/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3188, 2455, 9, 100, NULL, '/new_platform/static/canvas/images/Thank_You_Card.jpg', NULL, NULL);