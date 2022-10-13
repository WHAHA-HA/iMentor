--9.5.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (33, 5, 'Self-Advocacy', NULL, 'What is self-advocacy?<p><p>How can I advocate for myself in high school?</p></p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (33, 1, 33, '<ul><li>How would you rate your ability to advocate for yourself? Why?</li><li>What can you do to improve your self-advocacy skills?</li></ul>', '<ul><li>How would you rate your ability to advocate for yourself? Why?</li><li>What can you do to improve your self-advocacy skills?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (130, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 33, 1, NULL, 'What is Self-Advocacy?', '/new_platform/static/canvas/images/9.5.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (369, 1, 130, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is Self-Advocacy?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1200, 369, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1201, 369, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1202, 369, 2, 1, 2, 300, 'What is self-advocacy?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1203, 369, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2096, 1200, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2097, 1200, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2098, 1201, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2099, 1202, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2100, 1203, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2101, 1203, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2751, 2096, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the concept and importance of self-advocacy to mentees.<p><p>In this lesson, mentees will:<ul><li>Assess their own current help-seeking behavior</li><li>Understand and articulate the concept of self-advocacy</li><li>Reflect on specific examples and consequences for not asking for help when needed</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/what-is-self-advocacy---951" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2752, 2097, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2753, 2097, 6, 200, NULL, 'https://docs.google.com/presentation/d/1tarCdKGEExFITC-jR8t0Rj6rWkRGwAvZjLeD7FxaSkQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2754, 2098, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2755, 2099, 9, 100, NULL, '/new_platform/static/canvas/images/Self-Advocacy_Definition.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2756, 2100, 11, 100, NULL, NULL, 'How would you define “self-advocacy” in your own words? What does it mean to advocate for yourself?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2757, 2101, 11, 100, NULL, NULL, 'Share a time when you needed help but didn''t ask for it.<ul><li>Why didn’t you ask for help?</li><li>What happened?</li><li>What did you learn about yourself?</li><li>Is there anything you need help with now? Ask your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (589, 2756, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (590, 2757, 100, 0, 2);

--9.5.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (370, 5, 130, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is Self-Advocacy?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1204, 370, 2, 1, 2, 100, 'What is self-advocacy?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1205, 370, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2102, 1204, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2103, 1205, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2104, 1205, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2758, 2102, 9, 100, NULL, '/new_platform/static/canvas/images/Self-Advocacy_Definition.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2759, 2103, 11, 100, NULL, NULL, 'How would you define “self-advocacy” in your own words? What does it mean to advocate for yourself?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2760, 2104, 11, 100, NULL, NULL, 'Share a time when you needed help but didn''t ask for it.<ul><li>Why didn’t you ask for help?</li><li>What happened?</li><li>What did you learn about yourself?</li><li>Is there anything you need help with now? Ask your mentor.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (591, 2759, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (592, 2760, 100, 0, 2);

--9.5.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (371, 4, 130, '6/26/15 00:00:00', '6/26/15 23:59:59', 'What is Self-Advocacy?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1206, 371, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1207, 371, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2105, 1206, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2106, 1206, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2107, 1207, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2108, 1207, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2761, 2105, 11, 100, NULL, NULL, 'Your mentee started a new unit on Self-Advocacy. As one of our core non-cognitive skills, self-advocacy and help-seeking will be critical to your mentee’s success in high school and college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2762, 2106, 11, 100, NULL, NULL, 'Read the following article to learn more about self-advocacy, the importance and role of help-seeking in school, and ways you might encourage your mentee to build this skill.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2763, 2106, 8, 200, NULL, '/new_platform/static/canvas/documents/Asking_For_Help.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2764, 2107, 11, 100, NULL, NULL, 'Your mentee shared the following with you:<ul><li>Their own definition of self-advocacy</li><li>What advocating for oneself means to them</li><li>An experience where they needed help, but didn’t ask for it, and what they learned from it.</li><li>Anything they need help with now.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2765, 2108, 11, 100, NULL, NULL, 'Respond to your mentee and share the following:<ul><li>Share feedback on their definition of self-advocacy. What do you like about it? What resonates with you?</li><li>Share an experience where you needed help and didn’t ask for it. What happened? What did you learn from that experience?</li><li>Share a tip for how your mentee might speak up and advocate for themselves.</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (593, 2765, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (561, 2764, 591, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (562, 2764, 592, TRUE, 200, 0);

--9.5.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (131, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 33, 2, NULL, 'How Do I Learn?', '/new_platform/static/canvas/images/9.5.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (372, 1, 131, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1208, 372, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1209, 372, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1210, 372, 2, 1, 2, 300, 'What’s my learning style?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1211, 372, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2109, 1208, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2110, 1208, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2111, 1209, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2112, 1210, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2113, 1211, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2114, 1211, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2766, 2109, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will encourage students to reflect on their individual learning preferences and how to advocate for a learning experience that accommodates those preferences.<p><p>In this lesson, mentees will:<ul><li>Assess their current learning environment and reflect on ways to improve it</li><li>Identify their own learning preferences and connect it to more individualized strategies for self-advocacy</li><li>Think critically about themselves and the critical components of an effective learning environment</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/how-do-i-learn---952" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2767, 2110, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2768, 2110, 6, 200, NULL, 'https://docs.google.com/presentation/d/18nFnbKZsQ1-ztTNuEllSmvYOJf6V9HDxQ_gxpMzff04/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2769, 2111, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2770, 2112, 11, 100, NULL, NULL, 'Take the Learning Style Quiz below. when you complete the quiz, read the results and think about the following questions:<ul><li>What is your dominant learning style?</li><li>Do you agree with the results of the quiz?</li></ul><p><p><a href="http://www.educationplanner.org/students/self-assessments/learning-styles-quiz.shtml" target="_blank">Learning Style Quiz</a></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2771, 2113, 11, 100, NULL, NULL, 'Your mentor shared an experience where they needed help, but didn’t ask for it. They also shared some tips on how you might advocate for yourself.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2772, 2114, 11, 100, NULL, NULL, 'Share your quiz results with your mentor.<ul><li>What is your dominant learning style?</li><li>Do you agree with the quiz results? Why or why not?</li><li>Did you learn anything new or interesting about yourself?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (594, 2772, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (563, 2771, 593, TRUE, 100, 0);

--9.5.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (373, 5, 131, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1212, 373, 2, 1, 2, 100, 'What’s my learning style?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1213, 373, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2115, 1212, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2116, 1213, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2117, 1213, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2773, 2115, 11, 100, NULL, NULL, 'Take the Learning Style Quiz below. when you complete the quiz, read the results and think about the following questions:<ul><li>What is your dominant learning style?</li><li>Do you agree with the results of the quiz?</li></ul><p><p><a href="http://www.educationplanner.org/students/self-assessments/learning-styles-quiz.shtml" target="_blank">Learning Style Quiz</a></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2774, 2116, 11, 100, NULL, NULL, 'Your mentor shared an experience where they needed help, but didn’t ask for it. They also shared some tips on how you might advocate for yourself.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2775, 2117, 11, 100, NULL, NULL, 'Share your quiz results with your mentor.<ul><li>What is your dominant learning style?</li><li>Do you agree with the quiz results? Why or why not?</li><li>Did you learn anything new or interesting about yourself?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (595, 2775, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (564, 2774, 593, TRUE, 100, 0);

--9.5.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (374, 4, 131, '6/26/15 00:00:00', '6/26/15 23:59:59', 'How Do I Learn?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1214, 374, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1215, 374, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2118, 1214, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2119, 1215, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2120, 1215, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2776, 2118, 11, 100, NULL, NULL, 'A key part of building self-advocacy skills in your mentee is helping them to understand what they might advocate for. In this lesson, they evaluated their learning environment, identified one area for improvement, and created a recommendation for addressing that area. Example: From not being able to see the board from their assigned seat to asking for their seat to be moved.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2777, 2119, 11, 100, NULL, NULL, 'Your mentee took a quiz to identify their dominant working style and shared that information with you. Respond to your mentee and share your feedback. Do the results feel accurate to you based on what you know about your mentee?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2778, 2120, 11, 100, NULL, NULL, 'Take the <a href="http://www.educationplanner.org/students/self-assessments/learning-styles-quiz.shtml" target="_blank">Learning Style Quiz</a>.<p><p>Share your results with your mentee.<ul><li>How are your results similar or different?</li><li>Do you agree with your results?</li><li>Did you learn anything new or interesting about yourself?</li></ul></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (596, 2777, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (597, 2778, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (565, 2777, 595, TRUE, 100, 0);