--Staff Lesson 9.1.5

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (29, 1, '6/28/15 00:00:00', '6/28/15 23:59:59', 1, 2, 5, NULL, 'About Me: I Am From');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (67, 1, 29, '6/28/15 00:00:00', '6/28/15 23:59:59', 'About Me: I Am From');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (200, 67, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (201, 67, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (202, 67, 2, 1, 2, 300, 'Read the poem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (203, 67, 2, 2, 2, 400, 'Write your own “I Am From” poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (327, 200, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (328, 200, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (329, 201, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (330, 202, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (331, 203, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (455, 327, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is the entry point for the mentee/mentor relationship. This lesson helps prepare both mentees and mentors to communicate appropriate personal information about themselves as they enter into their relationship.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze a poem and examine its meaning</li><li>Select ideas and terms that effectively communicate their own personal context</li><li>Create an "I Am From" poem that identifies and describes where they came from</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/about-me-i-am-from" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (456, 328, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (457, 328, 6, 200, NULL, 'https://docs.google.com/presentation/d/1y__eLwyo1oGZ-173ToSXFF2RX07eUsgA_4zU9oJtKgk/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (458, 329, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (459, 330, 9, 100, NULL, '/new_platform/static/canvas/images/Student_I_Am_From_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (460, 330, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What "I am from" lines resonate with you? Why?</li><li>What values and/or qualities about the author are evident in the poem?</li><li>How many different types of "places" does the the author communicate?</li><li>What is the overall message that the author is trying to convey about where they are from?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (461, 331, 11, 100, NULL, NULL, 'Remember:<ul><li>start every line with “I am from”</li><li>prioritize quality, not quantity</li><li>interpreting "from" is personal; there are no wrong answers</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (83, 461, 100, 0, 2);

--Mentee Lesson 9.1.5

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (68, 5, 29, '6/28/15 00:00:00', '6/28/15 23:59:59', 'About Me: I Am From');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (204, 68, 2, 1, 2, 100, 'Read the poem');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (205, 68, 2, 2, 2, 200, 'Write your own “I Am From” poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (332, 204, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (333, 205, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (462, 332, 9, 100, NULL, '/new_platform/static/canvas/images/Student_I_Am_From_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (463, 332, 11, 200, NULL, NULL, 'Consider the following:<ul><li>What "I am from" lines resonate with you? Why?</li><li>What values and/or qualities about the author are evident in the poem?</li><li>How many different types of "places" does the the author communicate?</li><li>What is the overall message that the author is trying to convey about where they are from?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (464, 333, 11, 100, NULL, NULL, 'Remember:<ul><li>start every line with “I am from”</li><li>prioritize quality, not quantity</li><li>interpreting "from" is personal; there are no wrong answers</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (84, 464, 100, 0, 2);

--Mentor Lesson 9.1.5

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (69, 4, 29, '6/28/15 00:00:00', '6/28/15 23:59:59', 'About Me: I Am From');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (206, 69, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (207, 69, 2, 2, 2, 200, 'Write your own “I Am From” poem');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (334, 206, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (335, 206, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (336, 207, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (337, 207, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (465, 334, 11, 100, NULL, NULL, 'They started by analyzing an “I Am From” poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (466, 334, 9, 200, NULL, '/new_platform/static/canvas/images/Student_I_Am_From_Poem.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (467, 335, 11, 100, NULL, NULL, 'Then they wrote their own “I Am From” poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (468, 336, 11, 100, NULL, NULL, 'To get started, consider all the ways to define where you come from:<ul><li>words that describe your home, family, community</li><li>things you love about your country, neighborhood, community, family, self</li><li>people that have had a strong influence in your life</li><li>powerful experiences you had at an early age</li><li>things you learned the hard way</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (469, 337, 11, 100, NULL, NULL, 'Remember:<ul><li>start every line with “I am from”</li><li>prioritize quality, not quantity</li><li>interpreting "from" is personal; there are no wrong answers</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (85, 469, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (74, 467, 84, TRUE, 100, 0);

--Staff Lesson 11.1.5 RP

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (30, 1, '6/29/15 00:00:00', '6/29/15 23:59:59', 3, 3, 5, NULL, 'Teamwork Makes the Dreamwork');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (70, 1, 30, '6/29/15 00:00:00', '6/29/15 23:59:59', 'Teamwork Makes the Dreamwork');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (208, 70, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (209, 70, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (210, 70, 2, 1, 2, 300, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (211, 70, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (338, 208, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (339, 208, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (340, 208, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (341, 209, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (342, 210, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (343, 211, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (344, 211, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (470, 338, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson asks mentees to analyze a story and connect it to their mentoring relationship.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Analyze a story to determine how differences can be used to positively impact learning and relationships</li><li>Apply this information to the relationship with their mentor</li><li>Create a list of tools to strengthen their relationship</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/rp-building-relationships-teamwork" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (471, 339, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (472, 339, 6, 200, NULL, 'https://docs.google.com/presentation/d/1XVcQlh5wgen-07_ixho-6U0MX-nDoyyOEYmcgC5W-wA/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (473, 340, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (474, 340, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (475, 341, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (476, 342, 3, 100, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (477, 342, 11, 200, NULL, NULL, 'Consider the following:<ul><li>​What was the purpose of this story?</li><li>What was the problem in the story? Find evidence that supports this.</li><li>What assumptions was the Hodja making?</li><li>What assumptions was the foreigner making?</li><li>What was the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (478, 343, 11, 100, NULL, NULL, 'Share the following with your mentor:​<ul><li>​One lesson from the parable that resonated with you most</li><li>How you think the lesson of the parable applies to your relationship?</li><li>What tool and/or strategy you can use to improve communication with your mentor?</li><li>What specific steps you can take to better support each other this year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (479, 344, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (86, 478, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (87, 479, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (75, 479, 54, TRUE, 100, 0);

--Mentee Lesson 11.1.5 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (71, 5, 30, '6/29/15 00:00:00', '6/29/15 23:59:59', 'Teamwork Makes the Dreamwork');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (212, 71, 2, 1, 2, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (213, 71, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (345, 212, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (346, 213, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (347, 213, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (480, 345, 3, 100, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (481, 345, 11, 200, NULL, NULL, 'Consider the following:<ul><li>​What was the purpose of this story?</li><li>What was the problem in the story? Find evidence that supports this.</li><li>What assumptions was the Hodja making?</li><li>What assumptions was the foreigner making?</li><li>What was the story trying to teach us?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (482, 346, 11, 100, NULL, NULL, 'Share the following with your mentor:​<ul><li>​One lesson from the parable that resonated with you most</li><li>How you think the lesson of the parable applies to your relationship?</li><li>What tool and/or strategy you can use to improve communication with your mentor?</li><li>What specific steps you can take to better support each other this year?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (483, 347, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (88, 482, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (89, 483, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (76, 483, 54, TRUE, 100, 0);

--Mentor Lesson 11.1.5 RP

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (72, 4, 30, '6/29/15 00:00:00', '6/29/15 23:59:59', 'Teamwork Makes the Dreamwork');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (214, 72, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (215, 72, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (348, 214, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (349, 214, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (350, 215, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (351, 215, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (354, 215, 150);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (484, 348, 11, 100, NULL, NULL, 'They watched the following parable video:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (485, 348, 3, 200, NULL, 'https://vimeo.com/135679633', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (486, 349, 11, 100, NULL, NULL, 'They discussed the parable’s purpose, the impact of assumptions on relationships, and lessons that resonated with them most.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (487, 350, 11, 100, NULL, NULL, 'Here is your mentee’s response to the parable.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (488, 351, 11, 100, NULL, NULL, 'Respond to your mentee and consider the following:<ul><li>How did your mentee respond to the parable and what lesson resonated with them most? How is that similar or different than your reaction?</li><li>How can you apply the lesson of the parable to your relationship? What specific steps you can take to better support each other this year?</li><li>Be sure to answer any questions your mentee asks.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (491, 354, 11, 100, NULL, NULL, 'Here is your mentee’s response from last time.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (90, 488, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (77, 487, 88, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (78, 491, 89, TRUE, 100, 0);

--Update the unit description for 9.1.x

UPDATE canvas_unit_info
SET description = 'Orientation and Building Relationships'
WHERE id = 2;