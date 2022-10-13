--9.4.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (21, 4, 'Grit and Resilience', 'grit_resilience', 'What is grit?<p>How can you use it to overcome challenges in high school?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (21, 1, 21, '<ul><li>What did you learn about yourself during this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>', '<ul><li>What did you learn about yourself during this unit?</li><li>What did you learn about your mentee/mentor?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (89, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 1, 21, 1, NULL, 'Bouncing Back and Pushing Through', '/new_platform/static/canvas/images/9.4.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (247, 1, 89, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Bouncing Back and Pushing Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (807, 247, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (808, 247, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (809, 247, 2, 1, 3, 300, 'Define resilience and grit');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (810, 247, 2, 2, 3, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (811, 247, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1437, 807, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1438, 807, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1439, 807, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1440, 808, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1441, 809, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1442, 809, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1443, 810, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1444, 811, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1445, 811, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1897, 1437, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the concepts of resilience and grit. It will explore and normalize failure as a part of the learning process.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Understand the concepts of resiliency and grit</li><li>Identify attitudes, and behaviors associated with resilience</li><li>Apply an understanding of resiliency to a personal example</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-high-school-bouncing-back-and-pushing-through" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1898, 1438, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1899, 1438, 6, 200, NULL, 'https://docs.google.com/presentation/d/1HBo0yfWCEWjsafnKeduOLjxqYFunLA3ushUELjGPD0Y/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1900, 1439, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1901, 1439, 3, 200, NULL, 'https://vimeo.com/141065517', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1902, 1440, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1903, 1441, 9, 100, NULL, '/new_platform/static/canvas/images/Game_Lose_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1904, 1441, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Do you agree with the quote?</li><li>What does it mean to you? What does it mean to “play” in this context?</li><li>Is losing bad? If you lose, what could you gain?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1905, 1442, 11, 100, NULL, NULL, 'Read the definitions of resiliency and grit.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1906, 1442, 9, 200, NULL, '/new_platform/static/canvas/images/Resilience_Grit_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1907, 1443, 11, 100, NULL, NULL, 'As you watch, think about the following:<ul><li>What is Audri trying to accomplish? What is the outcome?</li><li>How does Audri handle failure? What allows him to handle failure in this way?</li><li>How does failure help Audri succeed? What actions does he take when he fails?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1908, 1443, 3, 200, NULL, 'https://vimeo.com/141065517', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1909, 1444, 11, 100, NULL, NULL, 'How does Audri demonstrate resilience and grit in the video? What attitudes and behaviors did he use to practice resilience?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1910, 1445, 11, 100, NULL, NULL, 'Can failure help you succeed? Why or why not?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (413, 1909, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (414, 1910, 100, 0, 2);

--9.4.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (248, 5, 89, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Bouncing Back and Pushing Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (812, 248, 2, 1, 3, 100, 'Define resilience and grit');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (813, 248, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (814, 248, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1446, 812, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1447, 812, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1448, 813, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1449, 814, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1450, 814, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1911, 1446, 9, 100, NULL, '/new_platform/static/canvas/images/Game_Lose_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1912, 1446, 11, 200, NULL, NULL, 'Think about the following:<ul><li>Do you agree with the quote?</li><li>What does it mean to you? What does it mean to “play” in this context?</li><li>Is losing bad? If you lose, what could you gain?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1913, 1447, 11, 100, NULL, NULL, 'Read the definitions of resiliency and grit.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1914, 1447, 9, 200, NULL, '/new_platform/static/canvas/images/Resilience_Grit_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1915, 1448, 11, 100, NULL, NULL, 'As you watch, think about the following:<ul><li>What is Audri trying to accomplish? What is the outcome?</li><li>How does Audri handle failure? What allows him to handle failure in this way?</li><li>How does failure help Audri succeed? What actions does he take when he fails?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1916, 1448, 3, 200, NULL, 'https://vimeo.com/141065517', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1917, 1449, 11, 100, NULL, NULL, 'How does Audri demonstrate resilience and grit in the video? What attitudes and behaviors did he use to practice resilience?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1918, 1450, 11, 100, NULL, NULL, 'Can failure help you succeed? Why or why not?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (415, 1917, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (416, 1918, 100, 0, 2);

--9.4.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (249, 4, 89, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Bouncing Back and Pushing Through');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (815, 249, 2, 1, 3, 100, 'Define resilience and grit');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (816, 249, 2, 2, 3, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (817, 249, 2, 3, 3, 300, 'Share with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1451, 815, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1452, 816, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1453, 816, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1454, 817, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1455, 817, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1456, 817, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1919, 1451, 11, 100, NULL, NULL, 'Your mentee discussed the following definitions of resilience and grit.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1920, 1451, 9, 200, NULL, '/new_platform/static/canvas/images/Resilience_Grit_Definitions.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1921, 1452, 11, 100, NULL, NULL, 'Your mentee watched the following video during class. Watch this video as well, so you can include examples in your reflection later.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1922, 1452, 3, 200, NULL, 'https://vimeo.com/141065517', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1923, 1453, 11, 100, NULL, NULL, 'Your mentee wrote the following to describe how Audri demonstrates resilience and grit in the video.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1924, 1454, 11, 100, NULL, NULL, 'Your mentee answered the question, “Can failure help you succeed? Why or why not?” Their response is below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1925, 1455, 11, 100, NULL, NULL, 'Build on your mentee’s response and share your thoughts on the question, “Can failure help you succeed? Why or why not?”', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1926, 1456, 11, 100, NULL, NULL, 'Offer your mentee an example of how you demonstrate resilience and grit in your personal or work life.<p><p>Be sure to include specific attitudes and actions that facilitate resilience, since your mentee will be asked to identify these when they read your response.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (417, 1925, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (418, 1926, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (404, 1923, 415, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (405, 1924, 416, TRUE, 100, 0);