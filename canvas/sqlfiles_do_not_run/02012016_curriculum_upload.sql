--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw', '10th-Grade Scrapbook');

--10.9.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (38, 9, 'Closing Out', 'closing_out', 'What did we accomplish this year?<p>What are we looking forward to next year?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (38, 2, 38, '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>', '<ul><li>What accomplisments are you most proud of this year?</li><li>How has your relationship grown from the beginning of the year till now?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (148, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 38, 1, NULL, 'End of Year Reflection', '/new_platform/static/canvas/images/10.9.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (421, 1, 148, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1338, 421, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1339, 421, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1340, 421, 2, 1, 2, 300, 'My favorite moments');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1341, 421, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2316, 1338, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2317, 1338, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2318, 1339, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2319, 1340, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2320, 1341, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3030, 2316, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit and lesson, mentees will reflect on their experiences this year and work on a digital scrapbook that highlights their favorite moments, what they want to achieve next year, and close out with a letter to each other. In each of the three weeks, pairs will focus on a single section of the scrapbook.<p><p>In this lesson, mentees will:<ul><li>Reflect on what they learned and experienced this year.</li><li>Complete a mind map capturing their favorite moments of the year.</li><li>Create a poster highlighting 2-3 of these moments.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-reflection-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3031, 2317, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3032, 2317, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Cvrflw0mkm2MyHLDABn54y7kIY77YG_xnKJ4iiEfexU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3033, 2318, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3034, 2319, 11, 100, NULL, NULL, 'During this unit, you’ll be working with your mentor on a three-part digital scrapbook for the year. The first part is creating a poster of your favorite moments from this year. Use images and text to document those moments.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3035, 2320, 11, 100, NULL, NULL, 'Explain the moments that you chose to your mentor. Why did you choose them?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (658, 3035, 100, 0, 2);

--10.9.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (422, 5, 148, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1342, 422, 2, 1, 2, 100, 'My favorite moments');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1343, 422, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2321, 1342, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2322, 1343, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3036, 2321, 11, 100, NULL, NULL, 'During this unit, you’ll be working with your mentor on a three-part digital scrapbook for the year. The first part is creating a poster of your favorite moments from this year. Use images and text to document those moments.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3037, 2322, 11, 100, NULL, NULL, 'Explain the moments that you chose to your mentor. Why did you choose them?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (659, 3037, 100, 0, 2);

--10.9.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (423, 4, 148, '6/26/15 00:00:00', '6/26/15 23:59:59', 'End of Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1344, 423, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1345, 423, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2323, 1344, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2324, 1344, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2325, 1345, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2326, 1345, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3038, 2323, 11, 100, NULL, NULL, 'During this unit, you’ll be working with your mentee on a three-part digital scrapbook for the year. The first part is creating a poster of your favorite moments from this year.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to check out your mentee’s poster.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3039, 2324, 11, 100, NULL, NULL, 'Your mentee also described the moments they highlighted in their poster.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3040, 2325, 11, 100, NULL, NULL, 'Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to create a poster of your favorite memories on the second slide.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3041, 2326, 11, 100, NULL, NULL, 'Lastly, describe your favorite moments of this year to your mentee.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (660, 3041, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (616, 3039, 659, TRUE, 100, 0);