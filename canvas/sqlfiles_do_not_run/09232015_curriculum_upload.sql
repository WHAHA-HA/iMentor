--Staff Lesson 11.1.5 NP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (37, 1, '7/6/15 00:00:00', '7/6/15 23:59:59', 3, 1, 5, NULL, 'About Me');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (91, 1, 37, '7/6/15 00:00:00', '7/6/15 23:59:59', 'About Me');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (280, 91, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (281, 91, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (282, 91, 2, 1, 2, 300, 'Read the poem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (283, 91, 2, 2, 2, 400, 'I Am From poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (464, 280, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (465, 280, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (466, 281, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (467, 282, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (468, 283, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (640, 464, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is the entry point for the mentee/mentor relationship. This lesson helps prepare both mentees and mentors to communicate appropriate personal information about themselves as they enter into their relationship.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze a poem and examine its meaning</li><li>Select ideas and terms that effectively communicate their own personal context</li><li>Create an "I AM FROM" that identifies and describes where they came from</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/np-building-relationships-about-me" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (641, 465, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (642, 465, 6, 200, NULL, 'https://docs.google.com/presentation/d/1H6PKGHLNJfwM8mDrIDTN8DA1pyY8dIpVAqDi52pojGY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (643, 466, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (644, 467, 9, 100, NULL, '/new_platform/static/canvas/images/the-rose-poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (645, 467, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What do you think this poem means?</li><li>What does the rose represent?</li><li>What does the concrete represent?</li><li>Does this image/poem resonate? Why or why not?</li><li>What does this poem say about where the author is "from"?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (646, 468, 11, 100, NULL, NULL, 'Consider each of the following to create your poem.<ul><li>words that describe your home, family, community</li><li>things you love about your country, neighborhood, community, family, self</li><li>people that have had a strong influence in your life</li><li>powerful experiences you had at an early age</li><li>things you learned the hard way</li></ul><p><p>Now write your own poem. Start each line with “I am from…”</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (114, 646, 100, 0, 2);

--Mentee Lesson 11.1.5 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (92, 5, 37, '7/6/15 00:00:00', '7/6/15 23:59:59', 'About Me');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (284, 92, 2, 1, 2, 100, 'Read the poem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (285, 92, 2, 2, 2, 200, 'I Am From poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (469, 284, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (470, 285, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (647, 469, 9, 100, NULL, '/new_platform/static/canvas/images/the-rose-poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (648, 469, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What do you think this poem means?</li><li>What does the rose represent?</li><li>What does the concrete represent?</li><li>Does this image/poem resonate? Why or why not?</li><li>What does this poem say about where the author is "from"?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (649, 470, 11, 100, NULL, NULL, 'Consider each of the following to create your poem.<ul><li>words that describe your home, family, community</li><li>things you love about your country, neighborhood, community, family, self</li><li>people that have had a strong influence in your life</li><li>powerful experiences you had at an early age</li><li>things you learned the hard way</li></ul><p><p>Now write your own poem. Start each line with “I am from…”</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (115, 649, 100, 0, 2);

--Mentor Lesson 11.1.5 NP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (93, 4, 37, '7/6/15 00:00:00', '7/6/15 23:59:59', 'About Me');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (286, 93, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (287, 93, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (471, 286, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (472, 286, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (473, 286, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (474, 287, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (650, 471, 11, 100, NULL, NULL, 'Your mentee’s class started the day by discussing the following poem:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (651, 471, 9, 200, NULL, '/new_platform/static/canvas/images/the-rose-poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (652, 472, 11, 100, NULL, NULL, 'They then discussed the components of a quality introduction, explored the parts of their identity they’d like to share with you, and wrote an I Am From poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (653, 473, 11, 100, NULL, NULL, 'Share a few thoughts about your mentee’s poem. What resonated with you? What would you like to learn more about? What are the similarities and differences you share?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (654, 474, 11, 100, NULL, NULL, 'Write your own I AM From poem to share with your mentee. Consider any of the following to get started:<ul><li>words that describe your home, family, community</li><li>things you love about your country, neighborhood, community, family, self</li><li>people that have had a strong influence in your life</li><li>powerful experiences you had at an early age</li><li>things you learned the hard way</li></ul><p><p>Start each line of your poem with “I am from…”</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (116, 653, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (117, 654, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (109, 652, 115, TRUE, 200, 0);