--Update the staff lesson of 10.9.1

UPDATE canvas_widget_content
SET html = '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit and lesson, mentees will reflect on their experiences this year and work on a digital scrapbook that highlights their favorite moments, what they want to achieve next year, and close out with a thank you card to each other. In each of the three weeks, pairs will focus on a single section of the scrapbook.<p><p>In this lesson, mentees will:<ul><li>Reflect on what they learned and experienced this year.</li><li>Complete a mind map capturing their favorite moments of the year.</li><li>Create a poster highlighting 2-3 of these moments.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-reflection-10" target="_blank">here</a>.</b>'
WHERE id = 3030;

UPDATE canvas_widget_content_copy
SET html = '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit and lesson, mentees will reflect on their experiences this year and work on a digital scrapbook that highlights their favorite moments, what they want to achieve next year, and close out with a thank you card to each other. In each of the three weeks, pairs will focus on a single section of the scrapbook.<p><p>In this lesson, mentees will:<ul><li>Reflect on what they learned and experienced this year.</li><li>Complete a mind map capturing their favorite moments of the year.</li><li>Create a poster highlighting 2-3 of these moments.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/end-of-year-reflection-10" target="_blank">here</a>.</b>'
WHERE parent_id = 3030;

--10.9.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (149, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 38, 2, NULL, 'My Mission', '/new_platform/static/canvas/images/10.9.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (424, 1, 149, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Mission');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1346, 424, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1347, 424, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1348, 424, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1349, 424, 2, 2, 3, 400, 'My mission statement');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1350, 424, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2327, 1346, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2328, 1346, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2329, 1347, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2330, 1348, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2331, 1349, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2332, 1349, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2333, 1350, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3042, 2327, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit and lesson, mentees will reflect on their experiences this year and work on a digital scrapbook that highlights their favorite moments, what they want to achieve next year, and close out with a thank you card to each other. In each of the three weeks, pairs will focus on a single section of the scrapbook.<p><p>In this lesson, mentees will:<ul><li>Reflect on the values and goals that drive them to succeed.</li><li>Create a mission statement that captures their mission, core values and priorities.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-mission" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3043, 2328, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3044, 2328, 6, 200, NULL, 'https://docs.google.com/presentation/d/1lkGiPjAJek42xkThQWI5CtfAULL8Sqgn8l0JzTWs35U/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3045, 2329, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3046, 2330, 11, 100, NULL, NULL, 'Check out your mentor’s poster of their favorite moments from this year <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> and the reason why they chose those moments below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3047, 2331, 3, 100, NULL, 'https://vimeo.com/152999721', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3048, 2332, 11, 100, NULL, NULL, 'Continue your work on your digital scrapbook by crafting a personal mission statement.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook and continue to slide 3.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3049, 2333, 11, 100, NULL, NULL, 'Tell your mentor about your values and goals and how they contributed to the mission statement you created.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (661, 3049, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (617, 3046, 660, TRUE, 100, 0);

--10.9.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (425, 5, 149, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Mission');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1351, 425, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1352, 425, 2, 2, 3, 200, 'My mission statement');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1353, 425, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2334, 1351, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2335, 1352, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2336, 1352, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2337, 1353, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3050, 2334, 11, 100, NULL, NULL, 'Check out your mentor’s poster of their favorite moments from this year <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> and the reason why they chose those moments below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3051, 2335, 3, 100, NULL, 'https://vimeo.com/152999721', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3052, 2336, 11, 100, NULL, NULL, 'Continue your work on your digital scrapbook by crafting a personal mission statement.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook and continue to slide 3.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3053, 2337, 11, 100, NULL, NULL, 'Tell your mentor about your values and goals and how they contributed to the mission statement you created.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (662, 3053, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (618, 3050, 660, TRUE, 100, 0);

--10.9.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (426, 4, 149, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Mission');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1354, 426, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1355, 426, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2338, 1354, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2339, 1354, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2340, 1354, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2341, 1355, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3054, 2338, 11, 100, NULL, NULL, 'As Part II of the scrapbook, your mentee learned about writing a personal mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3055, 2338, 3, 200, NULL, 'https://vimeo.com/152999721', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3056, 2339, 11, 100, NULL, NULL, 'Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to check out your mentee’s personal mission statement on slide 3.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3057, 2340, 11, 100, NULL, NULL, 'Your mentee also described how their goals and values shaped their mission statement.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3058, 2341, 11, 100, NULL, NULL, 'As the final part of your scrapbook, create a Thank You card for your mentee.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to create your digital Thank You on slide 4.</p></p>', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (619, 3057, 662, TRUE, 100, 0);

--10.9.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (150, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 38, 3, NULL, 'Thank You', '/new_platform/static/canvas/images/10.9.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (427, 1, 150, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1356, 427, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1357, 427, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1358, 427, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1359, 427, 2, 2, 2, 400, 'Thank your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2342, 1356, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2343, 1356, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2344, 1357, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2345, 1358, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2346, 1359, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3059, 2342, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this unit and lesson, mentees will reflect on their experiences this year and work on a digital scrapbook that highlights their favorite moments, what they want to achieve next year, and close out with a thank you card to each other. In each of the three weeks, pairs will focus on a single section of the scrapbook.<p><p>In this lesson, mentees will:<ul><li>Reflect on their relationships with their mentors this past year.</li><li>Appreciate each other and staff member.</li><li>Create a thank you card to their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/thank-you-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3060, 2343, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3061, 2343, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Y-oskvYtBkl6jpCUbn3wlRgSJvYdoJ36GpwpJ0Pl6kg/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3062, 2344, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3063, 2345, 11, 100, NULL, NULL, 'Your mentor created a Thank You card for you! Check it out <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3064, 2346, 11, 100, NULL, NULL, 'Now it’s your turn! Create a Thank You card for your mentor.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook and continue to slide 5 to get started.</p></p>', NULL);

--10.9.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (428, 5, 150, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1360, 428, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1361, 428, 2, 2, 2, 200, 'Thank your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2347, 1360, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2348, 1361, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3065, 2347, 11, 100, NULL, NULL, 'Your mentor created a Thank You card for you! Check it out <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3066, 2348, 11, 100, NULL, NULL, 'Now it’s your turn! Create a Thank You card for your mentor.<p><p>Click <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a> to open your digital scrapbook and continue to slide 5 to get started.</p></p>', NULL);

--10.9.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (429, 4, 150, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Thank You');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1362, 429, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2349, 1362, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2350, 1362, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3067, 2349, 11, 100, NULL, NULL, 'Your mentee received the digital Thank You card that you created.<p><p>Then, your mentee created a digital Thank You card for you in return! Check it out <a href="https://docs.google.com/presentation/d/1umGK_HSHnhkMXP73Ny2zMEpQ2sOk5jFTQjRWjImqorw/edit?usp=sharing" target="_blank">here</a>!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3068, 2350, 9, 100, NULL, '/new_platform/static/canvas/images/Thank_You_Card.jpg', NULL, NULL);