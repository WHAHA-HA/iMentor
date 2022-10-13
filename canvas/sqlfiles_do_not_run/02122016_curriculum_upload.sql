--9.7.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (151, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 36, 3, NULL, 'Social Networking and Media', '/new_platform/static/canvas/images/9.7.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (430, 1, 151, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Networking and Media');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1363, 430, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1364, 430, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1365, 430, 2, 1, 2, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1366, 430, 2, 2, 2, 400, 'Social media for good');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2351, 1363, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2352, 1363, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2353, 1363, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2354, 1364, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2355, 1365, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2356, 1365, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2357, 1366, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2358, 1366, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3069, 2351, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will explore the benefits of using social media to build their networks, provide an outlet for their voices, and bring about needed change.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Identify the various social media tools and apps in use today.</li><li>Explore how others use the combination of social capital skills and social media tools to bring awareness to specific causes.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/social-networking-and-media" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3070, 2352, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3071, 2352, 6, 200, NULL, 'https://docs.google.com/presentation/d/1DM1yuOQuNtcmUf6SkVXHgXJdbU7mFT-JyfyaQ3hxJXc/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3072, 2353, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3073, 2353, 3, 200, NULL, 'https://vimeo.com/153263301', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3074, 2354, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3075, 2355, 11, 100, NULL, NULL, 'Your mentor offered advice on building social networks.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3076, 2356, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>What step can you take now to help build your networks?</li><li>When will you take that step?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3077, 2357, 3, 100, NULL, 'https://vimeo.com/153263301', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3078, 2358, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>If you could start an awareness campaign, what cause would you do it for? Why?</li><li>What from today''s lesson would you use in your campaign?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (663, 3076, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (664, 3078, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (620, 3075, 653, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (621, 3075, 654, TRUE, 200, 0);

--9.7.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (431, 5, 151, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Networking and Media');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1367, 431, 2, 1, 2, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1368, 431, 2, 2, 2, 200, 'Social media for good');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2359, 1367, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2360, 1367, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2361, 1368, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2362, 1368, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3079, 2359, 11, 100, NULL, NULL, 'Your mentor offered advice on building social networks.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3080, 2360, 11, 100, NULL, NULL, 'Respond to your mentor:<ul><li>What step can you take now to help build your networks?</li><li>When will you take that step?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3081, 2361, 3, 100, NULL, 'https://vimeo.com/153263301', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3082, 2362, 11, 100, NULL, NULL, 'Share with your mentor:<ul><li>If you could start an awareness campaign, what cause would you do it for? Why?</li><li>What from today''s lesson would you use in your campaign?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (665, 3080, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (666, 3082, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (622, 3079, 653, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (623, 3079, 654, TRUE, 200, 0);

--9.7.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (432, 4, 151, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Social Networking and Media');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1369, 432, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1370, 432, 2, 2, 2, 200, 'Social media for good');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2363, 1369, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2364, 1369, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2365, 1370, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2366, 1370, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2367, 1370, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3083, 2363, 11, 100, NULL, NULL, 'Based on the advice you offered, your mentee identified a next step to building their network.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3084, 2364, 11, 100, NULL, NULL, 'Respond to your mentee and share a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3085, 2365, 3, 100, NULL, 'https://vimeo.com/153263301', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3086, 2366, 11, 100, NULL, NULL, 'Your mentee also considered how social media can be used for good by discussing viral awareness campaigns.<p><p>They then considered a cause they care about and how they would start a social media awareness campaign.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (3087, 2367, 11, 100, NULL, NULL, 'Respond to your mentee:<ul><li>Share your personal feelings about the cause your mentee selected.</li><li>Share a cause you feel passionately about. Why do you feel this way?</li></ul><p><p><i>Note: Remember this is an opportunity to find similarities and celebrate differences with your mentee. There are no right or wrong answers. This is an opportunity to learn something about each other and build your relationship.</i></p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (667, 3084, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (668, 3087, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (624, 3083, 665, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (625, 3086, 666, TRUE, 100, 0);