--11.9.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (77, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 18, 2, NULL, 'Avoiding Sticker Shock', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (211, 1, 77, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Avoiding Sticker Shock');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (687, 211, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (688, 211, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (689, 211, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (690, 211, 2, 2, 3, 400, 'Sticker vs Net Price');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (691, 211, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1241, 687, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1242, 687, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1243, 687, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1244, 688, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1245, 689, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1246, 689, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1247, 689, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1248, 690, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1249, 690, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1250, 691, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1632, 1241, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson is designed to minimize the impact of “sticker shock” associated with college costs.<p><p>In this lesson, mentees will:<ul><li>Watch and review a video on sticker price vs net price for colleges</li><li>Create their own definitions of sticker vs net price</li><li>Research and calculate the difference between the sticker and net prices for specific colleges (optional)</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/avoiding-sticker-shock" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1633, 1242, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1634, 1242, 6, 200, NULL, 'https://docs.google.com/presentation/d/1VXb3sZMOrHXAdIIP7iq09nBYDGCumF7S0mV5FEBk0Fo/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1635, 1243, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1636, 1243, 3, 200, NULL, 'https://vimeo.com/142881106', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1637, 1244, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1638, 1245, 11, 100, NULL, NULL, 'Read your mentor’s tips about paying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1639, 1246, 11, 100, NULL, NULL, 'They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1640, 1247, 11, 100, NULL, NULL, 'Respond to your mentor and share a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1641, 1248, 11, 100, NULL, NULL, 'While watching the video, consider the following:<ul><li>What is the sticker price for a college?</li><li>What is the net price for a college?</li><li>How are they different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1642, 1248, 3, 200, NULL, 'https://vimeo.com/142881106', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1643, 1249, 11, 100, NULL, NULL, 'Review the infographic below. What does this infographic tell you about the trend and relationship between sticker and net price over time?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1644, 1249, 9, 200, NULL, '/new_platform/static/canvas/images/College_Sticker_Net_Price.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1645, 1250, 11, 100, NULL, NULL, 'Share something you learned in class today.<ul><li>How did today’s lesson on sticker vs net price change the way you feel about paying for college?</li><li>Does this new information impact your <a href="/cchklist/list/" target="_blank">college list</a>? How so?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (361, 1640, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (362, 1645, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (346, 1638, 290, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (347, 1639, 291, TRUE, 100, 0);

--11.9.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (212, 5, 77, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Avoiding Sticker Shock');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (692, 212, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (693, 212, 2, 2, 3, 200, 'Sticker vs Net Price');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (694, 212, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1251, 692, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1252, 692, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1253, 692, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1254, 693, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1255, 693, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1256, 694, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1646, 1251, 11, 100, NULL, NULL, 'Read your mentor’s tips about paying for college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1647, 1252, 11, 100, NULL, NULL, 'They also shared a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1648, 1253, 11, 100, NULL, NULL, 'Respond to your mentor and share a personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1649, 1254, 11, 100, NULL, NULL, 'While watching the video, consider the following:<ul><li>What is the sticker price for a college?</li><li>What is the net price for a college?</li><li>How are they different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1650, 1254, 3, 200, NULL, 'https://vimeo.com/142881106', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1651, 1255, 11, 100, NULL, NULL, 'Review the infographic below. What does this infographic tell you about the trend and relationship between sticker and net price over time?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1652, 1255, 9, 200, NULL, '/new_platform/static/canvas/images/College_Sticker_Net_Price.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1653, 1256, 11, 100, NULL, NULL, 'Share something you learned in class today.<ul><li>How did today’s lesson on sticker vs net price change the way you feel about paying for college?</li><li>Does this new information impact your <a href="/cchklist/list/" target="_blank">college list</a>? How so?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (363, 1648, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (364, 1653, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (348, 1646, 290, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (349, 1647, 291, TRUE, 100, 0);

--11.9.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (213, 4, 77, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Avoiding Sticker Shock');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (695, 213, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (696, 213, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1257, 695, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1258, 695, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1259, 696, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1260, 696, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1654, 1257, 11, 100, NULL, NULL, 'Your mentee watched the following video to understand the difference between a college’s sticker vs net price.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1655, 1257, 3, 200, NULL, 'https://vimeo.com/142881106', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1656, 1258, 11, 100, NULL, NULL, 'They reviewed the following infographic and discussed the relationship between sticker vs net price over time.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1657, 1258, 9, 200, NULL, '/new_platform/static/canvas/images/College_Sticker_Net_Price.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1658, 1259, 11, 100, NULL, NULL, 'Read your mentee’s response and personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1659, 1260, 11, 100, NULL, NULL, 'Too often, high school students will use a college’s sticker price, not net price, to determine if they should apply. What advice can you give to your mentee on using both to shape their list of colleges?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (365, 1659, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (350, 1658, 363, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (351, 1658, 364, TRUE, 200, 0);

--11.9.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (78, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 18, 3, NULL, 'Scholarships and Grants', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (214, 1, 78, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Scholarships and Grants');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (697, 214, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (698, 214, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (699, 214, 2, 1, 4, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (700, 214, 2, 2, 4, 400, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (701, 214, 2, 3, 4, 500, 'My Scholarship Search');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (702, 214, 2, 4, 4, 600, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1261, 697, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1262, 697, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1263, 697, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1264, 698, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1265, 699, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1266, 700, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1267, 701, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1268, 702, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1269, 702, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1660, 1261, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to grants and scholarships, explains the difference between them, and provides mentees with an opportunity to explore specific grant and scholarship opportunities they might be eligible for.<p><p>In this lesson, mentees will:<ul><li>Define “grant” and “scholarship” and understand the difference</li><li>Review common grants</li><li>Research potential scholarship opportunities</li><li>Start a list by using My Scholarships Google Doc</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/scholarships-and-grants" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1661, 1262, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1662, 1262, 6, 200, NULL, 'https://docs.google.com/presentation/d/1TTlz8qIMjZDSQuckibq6ZPgOMxpehBKO-TWbMSY-trs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1663, 1263, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1664, 1263, 3, 200, NULL, 'https://vimeo.com/142919534', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1665, 1264, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1666, 1265, 11, 100, NULL, NULL, 'Your mentor shared some advice on using a college’s sticker vs net price to shape your college list.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1667, 1266, 11, 100, NULL, NULL, 'As you watch the video, think about the following:<ul><li>What is a grant?</li><li>What is a scholarship?</li><li>How are they similar? Different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1668, 1266, 3, 200, NULL, 'https://vimeo.com/142919534', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1669, 1267, 11, 100, NULL, NULL, 'Fast Web is a scholarship search engine you can use to start your own scholarship search. Find at least one scholarship that you are eligible for and would be interested in applying to.<p><p>Visit <a href="http://www.fastweb.com/" target="_blank">Fast Web</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1670, 1268, 11, 100, NULL, NULL, 'Use the document below to share your scholarship results with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1671, 1268, 6, 200, NULL, 'https://docs.google.com/document/d/1gR1c_bG_uXGBdZc4oEpvpUhGD-SOEeOHUv3Nv_-I6fM/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1672, 1269, 11, 100, NULL, NULL, 'Remember: your mentor can help you find scholarships, too. What does your mentor need to know about you to find you additional scholarships.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (366, 1672, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (352, 1666, 365, TRUE, 100, 0);

--11.9.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (215, 5, 78, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Scholarships and Grants');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (703, 215, 2, 1, 4, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (704, 215, 2, 2, 4, 200, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (705, 215, 2, 3, 4, 300, 'My Scholarship Search');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (706, 215, 2, 4, 4, 400, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1270, 703, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1271, 704, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1272, 705, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1273, 706, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1274, 706, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1673, 1270, 11, 100, NULL, NULL, 'Your mentor shared some advice on using a college’s sticker vs net price to shape your college list.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1674, 1271, 11, 100, NULL, NULL, 'As you watch the video, think about the following:<ul><li>What is a grant?</li><li>What is a scholarship?</li><li>How are they similar? Different?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1675, 1271, 3, 200, NULL, 'https://vimeo.com/142919534', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1676, 1272, 11, 100, NULL, NULL, 'Fast Web is a scholarship search engine you can use to start your own scholarship search. Find at least one scholarship that you are eligible for and would be interested in applying to.<p><p>Visit <a href="http://www.fastweb.com/" target="_blank">Fast Web</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1677, 1273, 11, 100, NULL, NULL, 'Use the document below to share your scholarship results with your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1678, 1273, 6, 200, NULL, 'https://docs.google.com/document/d/1gR1c_bG_uXGBdZc4oEpvpUhGD-SOEeOHUv3Nv_-I6fM/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1679, 1274, 11, 100, NULL, NULL, 'Remember: your mentor can help you find scholarships, too. What does your mentor need to know about you to find you additional scholarships.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (367, 1679, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (353, 1673, 365, TRUE, 100, 0);

--11.9.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (216, 4, 78, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Scholarships and Grants');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (707, 216, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (708, 216, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1275, 707, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1276, 707, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1277, 708, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1278, 708, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1680, 1275, 11, 100, NULL, NULL, 'Your mentee watched a video and discussed the definitions of grants and scholarships.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1681, 1275, 3, 200, NULL, 'https://vimeo.com/142919534', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1682, 1276, 11, 100, NULL, NULL, 'Your mentee is likely eligible for one or more of the federal grants listed in <a href="https://drive.google.com/file/d/0B-7uUglJA5seR291NlF3eU9aUG8/view" target="_blank">Federal Student Grant Programs document</a>. Please review the document and familiarize yourself with each, but specifically the Pell Grant.<p><p>Have additional questions? Visit <a href="https://studentaid.ed.gov/sa/" target="_blank">StudentAid.gov</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1683, 1277, 11, 100, NULL, NULL, 'You can help your mentee in their scholarship search. Here is some additional information that your mentee shared, which might aid in the process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1684, 1278, 11, 100, NULL, NULL, '<a href="http://www.fastweb.com/" target="_blank">Fast Web</a> is a scholarship search engine your mentee used to start a list below.<p><p>Use the information they provided to help them expand their list!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1685, 1278, 6, 200, NULL, 'https://docs.google.com/document/d/1gR1c_bG_uXGBdZc4oEpvpUhGD-SOEeOHUv3Nv_-I6fM/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (354, 1683, 367, TRUE, 100, 0);