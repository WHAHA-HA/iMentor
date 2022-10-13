--10.5.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (109, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 25, 3, NULL, 'Online Communities', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (306, 1, 109, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Online Communities');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (999, 306, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1000, 306, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1001, 306, 2, 1, 2, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1002, 306, 2, 2, 2, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1793, 999, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1794, 999, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1795, 1000, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1796, 1001, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1797, 1002, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1798, 1002, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2362, 1793, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore the qualities of online communities and consider how their interactions in these communities can help them promote a positive digital footprint.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Observe and analyze the factors that foster positive online community</li><li>Identify characteristics of websites that excel at creating a positive online community</li><li>Demonstrate understanding of how to build a positive community online</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/online-networking---1053" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2363, 1794, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2364, 1794, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Y0JDf5ODNT9lpkDRFIl-efmQRTarNgy7qyRTQsIGjDU/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2365, 1795, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2366, 1796, 11, 100, NULL, NULL, 'Your mentor responded to your description of your digital footprint. Your mentor also shared about how they shape their own digital footprint.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2367, 1797, 11, 100, NULL, NULL, 'Tell your mentor about a time when you or someone you know networked online.<ul><li>What website did they use to network?</li><li>What specifically did they do?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2368, 1798, 11, 100, NULL, NULL, 'Tell your mentor some ways that you could use your digital footprint to network online.<ul><li>For example, if you are interested in artistic opportunities, how could you use online communities like YouTube, Twitter, and Instagram?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (501, 2367, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (502, 2368, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (481, 2366, 485, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (482, 2366, 486, TRUE, 200, 0);

--10.5.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (307, 5, 109, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Online Communities');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1003, 307, 2, 1, 2, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1004, 307, 2, 2, 2, 200, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1799, 1003, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1800, 1004, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1801, 1004, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2369, 1799, 11, 100, NULL, NULL, 'Your mentor responded to your description of your digital footprint. Your mentor also shared about how they shape their own digital footprint.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2370, 1800, 11, 100, NULL, NULL, 'Tell your mentor about a time when you or someone you know networked online.<ul><li>What website did they use to network?</li><li>What specifically did they do?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2371, 1801, 11, 100, NULL, NULL, 'Tell your mentor some ways that you could use your digital footprint to network online.<ul><li>For example, if you are interested in artistic opportunities, how could you use online communities like YouTube, Twitter, and Instagram?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (503, 2370, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (504, 2371, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (483, 2369, 485, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (484, 2369, 486, TRUE, 200, 0);

--10.5.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (308, 4, 109, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Online Communities');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1005, 308, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1006, 308, 2, 2, 2, 200, 'Read your mentee’s reflections');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1802, 1005, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1803, 1006, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1804, 1006, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2372, 1802, 11, 100, NULL, NULL, 'Your mentee learned the concept of networking by discussing the quote, statistics, and definition in the slides below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2373, 1802, 6, 200, NULL, 'https://docs.google.com/presentation/d/1a0q56AaNZfM3GlSU-Vq8LON2IhbGu_HnRxZjb8ALND0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2374, 1802, 11, 300, NULL, NULL, 'Then, your mentee discussed how their digital footprints can help them network online.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2375, 1803, 11, 100, NULL, NULL, 'Your mentee thought about examples of online networking. They wrote you about a time when they or someone they know networked online.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2376, 1804, 11, 100, NULL, NULL, 'Then, your mentee reflected on their own digital footprint. They wrote you the following about how they think they can use their digital footprint to network online.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (485, 2375, 503, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (486, 2376, 504, TRUE, 100, 0);