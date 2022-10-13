--11.5.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (108, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 23, 3, NULL, 'Types of Colleges Part II: Public vs Private', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (303, 1, 108, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges Part II: Public vs Private');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (991, 303, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (992, 303, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (993, 303, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (994, 303, 2, 2, 2, 400, 'Should you choose a public or private college?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1780, 991, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1781, 991, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1782, 992, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1783, 993, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1784, 993, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1785, 994, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2345, 1780, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will build on the prior week and engage mentees in exploring the differences between public and private colleges.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Read an article explaining the primary differences between public and private colleges</li><li>Use a Venn Diagram to chart their differences and similarities</li><li>Use their diagram to review and highlight the factors that matter most to them when considering what schools to apply to</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/types-of-colleges-part2" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2346, 1781, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2347, 1781, 6, 200, NULL, 'https://docs.google.com/presentation/d/130rPhjOS2vQAS-bPJyDV39yBrGuvAjmhnWnISFAHPTs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2348, 1782, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2349, 1783, 11, 100, NULL, NULL, 'Your mentor responded to your college preferences and shared some of their own experiences.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2350, 1784, 11, 100, NULL, NULL, '<ul><li>Thank your mentor for their feedback.</li><li>Tell your mentor what about their college experiences stood out to you? Why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2351, 1785, 8, 100, NULL, '/new_platform/static/canvas/documents/Public_vs_Private.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2352, 1785, 11, 200, NULL, NULL, '"The winner is whichever school you decide to go to." Share the following with your mentor:<ul><li>What qualities of a public or private college/university matter most to you? Why?</li><li>Will you apply to both public and private colleges and universities? Why or why not?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (495, 2350, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (496, 2352, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (475, 2349, 493, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (476, 2349, 494, TRUE, 200, 0);

--11.5.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (304, 5, 108, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges Part II: Public vs Private');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (995, 304, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (996, 304, 2, 2, 2, 200, 'Should you choose a public or private college?');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1786, 995, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1787, 995, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1788, 996, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2353, 1786, 11, 100, NULL, NULL, 'Your mentor responded to your college preferences and shared some of their own experiences.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2354, 1787, 11, 100, NULL, NULL, '<ul><li>Thank your mentor for their feedback.</li><li>Tell your mentor what about their college experiences stood out to you? Why?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2355, 1788, 8, 100, NULL, '/new_platform/static/canvas/documents/Public_vs_Private.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2356, 1788, 11, 200, NULL, NULL, '"The winner is whichever school you decide to go to." Share the following with your mentor:<ul><li>What qualities of a public or private college/university matter most to you? Why?</li><li>Will you apply to both public and private colleges and universities? Why or why not?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (497, 2354, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (498, 2356, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (477, 2353, 493, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (478, 2353, 494, TRUE, 200, 0);

--11.5.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (305, 4, 108, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Types of Colleges Part II: Public vs Private');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (997, 305, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (998, 305, 2, 2, 2, 200, 'Connect with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1789, 997, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1790, 998, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1791, 998, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1792, 998, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2357, 1789, 11, 100, NULL, NULL, 'Your mentee learned about public and private colleges. They read and discussed the following article.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2358, 1789, 8, 200, NULL, '/new_platform/static/canvas/documents/Public_vs_Private.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2359, 1790, 11, 100, NULL, NULL, 'Your mentee shared the following:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2360, 1791, 11, 100, NULL, NULL, 'Does your mentee’s message about what matters most align with what you know about them? Respond to your mentee by sharing the following:<ul><li>What might they be overlooking? What else could they consider when thinking about what matters about a college?</li><li>What factors mattered most to you when applying to college?</li><li>Did you apply to both public and private colleges? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2361, 1792, 11, 100, NULL, NULL, 'Next week, your mentee will be learning about different college degree types. What degree(s) do you have and why? How did you decide which degree(s) to pursue?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (499, 2360, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (500, 2361, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (479, 2359, 497, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (480, 2359, 498, TRUE, 200, 0);