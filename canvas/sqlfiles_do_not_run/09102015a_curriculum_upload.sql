--Staff Lesson 12.1.4

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description) VALUES (27, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 5, 4, NULL, 'Becoming a College Ready PPPAIR');

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (61, 1, 27, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Becoming a College Ready PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (183, 61, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (184, 61, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (185, 61, 2, 1, 3, 300, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (186, 61, 2, 2, 3, 400, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (187, 61, 2, 3, 3, 500, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (302, 183, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (303, 183, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (304, 184, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (305, 185, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (306, 186, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (307, 187, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (425, 302, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />Addressing differences in opinion can be difficult, especially when a person feels strongly about a topic or when it’s emotionally charged. This lesson provides a framework within which pairs can work towards keeping their communication frequent and productive. It can also help pairs to develop the tools to address diverse cultural differences.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and analyze an article</li><li>Define social contract</li><li>Differentiate between the two types of culture: visible and deep</li><li>Apply the PPPAIR social contract framework to their mentee/mentor relationship</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/becoming-a-pppair-12" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (426, 303, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (427, 303, 6, 200, NULL, 'https://docs.google.com/presentation/d/1i6PKYWaULUDCROiTopAeNOlT5U02Ak6Bcg2qL8940N0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (428, 304, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (429, 305, 11, 100, NULL, NULL, 'PPPAIR is the social contract between a mentor and a mentee.<p><p>Share with your mentor:<ul><li>How can using PPPAIR strengthen your relationship?</li><li>What commitment can you make this year that follows the PPPAIR framework?</li><li>How will you hold each other accountable?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (430, 306, 11, 100, NULL, NULL, 'Your mentor responded to your self-assessment.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (431, 307, 11, 100, NULL, NULL, '<ul><li>How does your mentor''s response compare to your assessment?</li><li>Where do you and your mentor agree or disagree? Why?</li><li>How can you use ongoing feedback to strengthen your relationship and accomplish your goals?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (74, 429, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (75, 431, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (47, 430, 61, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (48, 430, 67, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (49, 430, 62, TRUE, 300, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (50, 430, 68, TRUE, 400, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (51, 430, 63, TRUE, 500, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (52, 430, 69, TRUE, 600, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (53, 430, 64, TRUE, 700, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (54, 430, 70, TRUE, 800, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (55, 430, 65, TRUE, 900, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (56, 430, 71, TRUE, 1000, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (57, 430, 66, TRUE, 1100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (58, 430, 72, TRUE, 1200, 0);

--Mentee Lesson 12.1.4

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (62, 5, 27, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Becoming a College Ready PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (188, 62, 2, 1, 3, 100, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (189, 62, 2, 2, 3, 200, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (190, 62, 2, 3, 3, 300, 'Respond to your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (308, 188, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (309, 189, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (310, 190, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (432, 308, 11, 100, NULL, NULL, 'PPPAIR is the social contract between a mentor and a mentee.<p><p>Share with your mentor:<ul><li>How can using PPPAIR strengthen your relationship?</li><li>What commitment can you make this year that follows the PPPAIR framework?</li><li>How will you hold each other accountable?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (433, 309, 11, 100, NULL, NULL, 'Your mentor responded to your self-assessment.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (434, 310, 11, 100, NULL, NULL, '<ul><li>How does your mentor''s response compare to your assessment?</li><li>Where do you and your mentor agree or disagree? Why?</li><li>How can you use ongoing feedback to strengthen your relationship and accomplish your goals?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (76, 432, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (77, 434, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (59, 433, 61, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (60, 433, 67, TRUE, 200, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (61, 433, 62, TRUE, 300, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (62, 433, 68, TRUE, 400, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (63, 433, 63, TRUE, 500, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (64, 433, 69, TRUE, 600, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (65, 433, 64, TRUE, 700, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (66, 433, 70, TRUE, 800, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (67, 433, 65, TRUE, 900, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (68, 433, 71, TRUE, 1000, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (69, 433, 66, TRUE, 1100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (70, 433, 72, TRUE, 1200, 0);

--Mentor Lesson 12.1.4

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (63, 4, 27, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Becoming a College Ready PPPAIR');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (191, 63, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (192, 63, 2, 2, 2, 200, 'Make a commitment');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (311, 191, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (312, 191, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (313, 192, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (314, 192, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (315, 192, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (435, 311, 11, 100, NULL, NULL, 'Today in class, your mentee learned about social contracts.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (436, 311, 9, 200, NULL, '/new_platform/static/canvas/images/Social_Contract_Poster.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (437, 312, 11, 100, NULL, NULL, 'In this lesson, your mentee explored the PPPAIR framework and how it can be used to support your relationship. Click through the following slideshow to learn the components of PPPAIR.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (438, 312, 6, 200, NULL, 'https://docs.google.com/presentation/d/1jlcWtNKq0lHI4gf6LKivd6TIyRwA3dGX67QvxUNl8Ys/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (439, 313, 11, 100, NULL, NULL, 'Your mentee compared your self-assessment to their own and responded.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (440, 314, 11, 100, NULL, NULL, 'Your mentee shared how the two of you could use the PPPAIR framework to strengthen your relationship.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (441, 315, 11, 100, NULL, NULL, 'Respond to your mentee. Read their commitment and then make one of your own. Consider the following:<ul><li>How can using PPPAIR strengthen your relationship?</li><li>What commitment can you make this year that follows the PPPAIR framework?</li><li>How will you hold each other accountable?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (78, 441, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (71, 439, 77, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (72, 440, 76, TRUE, 100, 0);