--12.3.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (80, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 16, 3, NULL, 'Letters of Recommendation', '/new_platform/static/canvas/images/12.3.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (220, 1, 80, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Letters of Recommendation');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (719, 220, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (720, 220, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (721, 220, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (722, 220, 2, 2, 3, 400, 'Letters of recommendation');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (723, 220, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1294, 719, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1295, 719, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1296, 720, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1297, 721, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1298, 722, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1299, 723, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1300, 723, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1706, 1294, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces letters of recommendation. Mentees will review tips on how to secure great letters, and discuss who to ask and when.<p><p>In this lesson, mentees will:<ul><li>Identify and define the purpose of letters of recommendation</li><li>Review a student self-assessment used by counselors to help them write letters of recommendation</li><li>Generate a list of teachers, counselors and other staff as potential recommenders</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/letters-of-rec" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1707, 1295, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1708, 1295, 6, 200, NULL, 'https://docs.google.com/presentation/d/1UWJqLXRoeR0z-Okclb77VK2CX69MzkXzcA1RxAT4Dbw/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1709, 1296, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1710, 1297, 11, 100, NULL, NULL, 'Your mentor answered your questions about their college essay. They also provided feedback on your essay topic.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1711, 1298, 11, 100, NULL, NULL, 'Read the student self-assessment form.<ul><li>How can you use this tool to help you obtain better letters of recommendation?</li><li>Based on what might be included in your recommendation, who are the best 2-3 people for you to ask?</li></ul><p><p>The online version of the self-assessment is available <a href="https://drive.google.com/file/d/0B-7uUglJA5seTmljb2JQZlZlb3M/view" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1712, 1299, 11, 100, NULL, NULL, 'Who is on your short list of possible recommenders? Share this list with your mentor and explain why each person could be a strong recommender.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1713, 1300, 11, 100, NULL, NULL, 'The online version of the How to Get a Great Letter of Recommendation is available <a href="https://drive.google.com/file/d/0B-7uUglJA5seLWtlUUI1V1JFeVU/view?usp=sharing" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (374, 1712, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (363, 1710, 372, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (364, 1710, 373, TRUE, 200, 0);

--12.3.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (221, 5, 80, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Letters of Recommendation');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (724, 221, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (725, 221, 2, 2, 3, 200, 'Letters of recommendation');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (726, 221, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1301, 724, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1302, 725, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1303, 726, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1304, 726, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1714, 1301, 11, 100, NULL, NULL, 'Your mentor answered your questions about their college essay. They also provided feedback on your essay topic.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1715, 1302, 11, 100, NULL, NULL, 'Read the student self-assessment form.<ul><li>How can you use this tool to help you obtain better letters of recommendation?</li><li>Based on what might be included in your recommendation, who are the best 2-3 people for you to ask?</li></ul><p><p>The online version of the self-assessment is available <a href="https://drive.google.com/file/d/0B-7uUglJA5seTmljb2JQZlZlb3M/view" target="_blank">here</a>.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1716, 1303, 11, 100, NULL, NULL, 'Who is on your short list of possible recommenders? Share this list with your mentor and explain why each person could be a strong recommender.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1717, 1304, 11, 100, NULL, NULL, 'The online version of the How to Get a Great Letter of Recommendation is available <a href="https://drive.google.com/file/d/0B-7uUglJA5seLWtlUUI1V1JFeVU/view?usp=sharing" target="_blank">here</a>.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (375, 1716, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (365, 1714, 372, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (366, 1714, 373, TRUE, 200, 0);

--12.3.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (222, 4, 80, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Letters of Recommendation');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (727, 222, 2, 1, 1, 100, 'Here’s what your mentee did in class…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1305, 727, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1306, 727, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1307, 727, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1718, 1305, 11, 100, NULL, NULL, 'Your mentee reviewed the purpose of letters of recommendation as part of the college process. They reviewed a <a href="https://drive.google.com/file/d/0B-7uUglJA5seTmljb2JQZlZlb3M/view" target="_blank">self-assessment worksheet</a> to explore and understand the types of topics that their recommenders might include in their letters.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1719, 1306, 11, 100, NULL, NULL, 'Your mentee shared their list of possible recommenders and their reasons why.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1720, 1307, 11, 100, NULL, NULL, 'Obtaining strong letters of recommendation is an important part of the college application process. It will also be a recurring skill that mentees will call upon as they apply for graduate school and jobs in the future. Please use the resource below to support your mentee in the process of obtaining strong letters.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1721, 1307, 8, 200, NULL, '/new_platform/static/canvas/documents/Great_Letter_of_Recommendation.pdf', NULL, NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (367, 1719, 375, TRUE, 100, 0);

--12.4.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (81, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 15, 3, NULL, 'Reflecting on the Process', '/new_platform/static/canvas/images/12.4.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (223, 1, 81, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflecting on the Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (728, 223, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (729, 223, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (730, 223, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (731, 223, 2, 2, 3, 400, 'Famous Failures');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (732, 223, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1308, 728, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1309, 728, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1310, 729, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1311, 730, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1312, 730, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1313, 731, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1314, 732, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1373, 728, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1722, 1308, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson engages mentees in a review of growth vs fixed mindsets and how it applies to the college application process.<p><p>At the end of this lesson, mentees will:<ul><li>Reflect on their success and challenges</li><li>Identify areas where they can build on success and improve upon failures</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/reflecting-on-the-process" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1723, 1309, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1724, 1309, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Dc14hua-dPKEExLHuYVDfHf4wcqyVULPf23uGQcuue0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1725, 1310, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1726, 1311, 11, 100, NULL, NULL, 'Read your mentor’s message and personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1727, 1312, 11, 100, NULL, NULL, 'Read your mentor’s comments on <a href="https://docs.google.com/document/d/1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg/edit?usp=sharing" target="_blank">your essay</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1728, 1313, 11, 100, NULL, NULL, 'Watch the video.<ul><li>How does fixed mindset appear in the video?</li><li>How does growth mindset appear in the video?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1729, 1313, 3, 200, NULL, 'https://vimeo.com/140923487', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1730, 1314, 11, 100, NULL, NULL, 'Reflect on your year so far and share the following with your mentor:<ul><li>What accomplishment are you most proud of so far this year? Why?</li><li>What has been the biggest challenge this year? Why?</li><li>What can you do to address this challenge?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1809, 1373, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1810, 1373, 3, 200, NULL, 'https://vimeo.com/140923487', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (376, 1730, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (368, 1726, 306, TRUE, 100, 0);

--12.4.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (224, 5, 81, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflecting on the Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (733, 224, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (734, 224, 2, 2, 3, 200, 'Famous Failures');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (735, 224, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1315, 733, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1316, 733, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1317, 734, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1318, 735, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1731, 1315, 11, 100, NULL, NULL, 'Read your mentor’s message and personal update.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1732, 1316, 11, 100, NULL, NULL, 'Read your mentor’s comments on <a href="https://docs.google.com/document/d/1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg/edit?usp=sharing" target="_blank">your essay</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1733, 1317, 11, 100, NULL, NULL, 'Watch the video.<ul><li>How does fixed mindset appear in the video?</li><li>How does growth mindset appear in the video?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1734, 1317, 3, 200, NULL, 'https://vimeo.com/140923487', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1735, 1318, 11, 100, NULL, NULL, 'Reflect on your year so far and share the following with your mentor:<ul><li>What accomplishment are you most proud of so far this year? Why?</li><li>What has been the biggest challenge this year? Why?</li><li>What can you do to address this challenge?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (377, 1735, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (369, 1731, 306, TRUE, 100, 0);

--12.4.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (225, 4, 81, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Reflecting on the Process');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (736, 225, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (737, 225, 2, 2, 2, 200, 'Write your reflection');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1319, 736, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1320, 736, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1321, 737, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1736, 1319, 11, 100, NULL, NULL, 'Your mentee reviewed growth vs fixed mindsets and reflected on their progress so far this year. If you need a refresher, please review the infographic below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1737, 1319, 9, 200, NULL, '/new_platform/static/canvas/images/Growth-vs-Fixed-Mindset-Infographic.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1738, 1320, 11, 100, NULL, NULL, 'Your mentee also watched the video, <i>Famous Failures</i>, and discussed the role of  growth and fixed mindsets in the examples.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1739, 1320, 3, 200, NULL, 'https://vimeo.com/140923487', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1740, 1321, 11, 100, NULL, NULL, 'Read your mentee’s message and reflection.', NULL);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (370, 1740, 377, TRUE, 100, 0);

--10.4.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (20, 4, 'Leadership   ', 'Leadership', 'What is leadership?<p>How do I lead?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (20, 2, 20, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (82, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 20, 1, NULL, 'Mid-Year Reflection', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (226, 1, 82, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Mid-Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (738, 226, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (739, 226, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (740, 226, 2, 1, 2, 300, 'How we learn');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (741, 226, 2, 2, 2, 400, 'Writing a reflection');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1322, 738, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1323, 738, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1324, 739, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1325, 740, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1326, 741, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1327, 741, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1741, 1322, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces the importance of reflection as a part of the growth and learning process. Mentees will think back to what they''ve comprehensively learned in the prior unit and write a reflection in the Portfolio.<p><p>In this lesson, mentees will:<ul><li>Read an article to define "reflection", identify its role and significance in the learning process, and discuss different methods of reflecting</li><li>Identify and discuss its role in the program and their relationship with their mentor</li><li>Reflect on the prior unit</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/reflection-10" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1742, 1323, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1743, 1323, 6, 200, NULL, 'https://docs.google.com/presentation/d/1nTRXcY_doNTtgkg4TunEcies4mS_QKazUMuoEzphTAI/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1744, 1324, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1745, 1325, 9, 100, NULL, '/new_platform/static/canvas/images/Reflecting_On_Experience.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1746, 1325, 11, 200, NULL, NULL, 'Share the following with your mentor:<ul><li>What does this quote mean to you?</li><li>Why do you think reflecting is important?</li><li>How can you and your mentor use reflection to grow and deepen your relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1747, 1326, 11, 100, NULL, NULL, 'If you need a refresher on what Portfolio is and how you should use it, please watch the video below:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1748, 1326, 3, 200, NULL, 'https://vimeo.com/142313752', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1749, 1327, 11, 100, NULL, NULL, 'Now that you’ve shared the importance of reflecting with your mentor, let’s write an actual reflection.<ul><li>Click “Finish” below to complete the lesson.</li><li>Go to Portfolio.</li><li>Click into your current unit.</li><li>Read your mentor’s reflection.</li><li>Write your own reflection.</li></ul><p><p>Note: You can access Portfolio through the menu at the top left of your screen.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (378, 1746, 100, 0, 2);

--10.4.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (227, 5, 82, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Mid-Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (742, 227, 2, 1, 2, 100, 'How we learn');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (743, 227, 2, 2, 2, 200, 'Writing a reflection');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1328, 742, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1329, 743, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1330, 743, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1750, 1328, 9, 100, NULL, '/new_platform/static/canvas/images/Reflecting_On_Experience.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1751, 1328, 11, 200, NULL, NULL, 'Share the following with your mentor:<ul><li>What does this quote mean to you?</li><li>Why do you think reflecting is important?</li><li>How can you and your mentor use reflection to grow and deepen your relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1752, 1329, 11, 100, NULL, NULL, 'If you need a refresher on what Portfolio is and how you should use it, please watch the video below:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1753, 1329, 3, 200, NULL, 'https://vimeo.com/142313752', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1754, 1330, 11, 100, NULL, NULL, 'Now that you’ve shared the importance of reflecting with your mentor, let’s write an actual reflection.<ul><li>Click “Finish” below to complete the lesson.</li><li>Go to Portfolio.</li><li>Click into your current unit.</li><li>Read your mentor’s reflection.</li><li>Write your own reflection.</li></ul><p><p>Note: You can access Portfolio through the menu at the top left of your screen.</p></p>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (379, 1751, 100, 0, 2);

--10.4.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (228, 4, 82, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Mid-Year Reflection');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (744, 228, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (745, 228, 2, 2, 2, 200, 'Reflection in your relationship');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1331, 744, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1332, 744, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1333, 745, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1334, 745, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1755, 1331, 11, 100, NULL, NULL, 'This lesson is all about reflection: what it is, why it is important, and what role it can play in your relationship. Learn more about reflection and the iMentor curriculum <a href="https://learn.imentor.org/help/article/link/reflection-and-the-imentor-curriculum" target="_blank">here</a>.<p><p>Your mentee discussed the role of reflection in learning before writing write a reflection on the previous unit in Portfolio.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1756, 1332, 11, 100, NULL, NULL, 'If you haven’t already, go to Portfolio and read your mentee’s reflection before moving on with the rest of this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1757, 1333, 9, 100, NULL, '/new_platform/static/canvas/images/Reflecting_On_Experience.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1758, 1333, 11, 200, NULL, NULL, 'Your mentee discussed the quote above and shared the following with you:<ul><li>What does this quote mean?</li><li>Why do you think reflecting is important?</li><li>How can reflection be used to grow and deepen your relationship?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1759, 1334, 11, 100, NULL, NULL, 'Respond to your mentee.<ul><li>How would you define reflection?</li><li>What role do you see it playing in your relationship moving forward?</li></ul>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (380, 1759, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (371, 1758, 379, TRUE, 100, 0);

--10.3.5 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (83, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 5, NULL, 'Create Solutions: Be a Risk Taker', '/new_platform/static/canvas/images/10.3.5.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (229, 1, 83, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Create Solutions: Be a Risk Taker');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (746, 229, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (747, 229, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (748, 229, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (749, 229, 2, 2, 3, 400, 'Make the image better');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (750, 229, 2, 3, 3, 500, 'Brainstorm solutions');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1335, 746, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1336, 746, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1337, 747, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1338, 748, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1339, 749, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1340, 750, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1341, 750, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1342, 750, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1760, 1335, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees brainstorm a list of potential solutions that might address their selected problem.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Learn how to identify various possible solutions to the same problem</li><li>Identify 2-3 viable solutions to the problems they selected</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/create-solutions" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1761, 1336, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1762, 1336, 6, 200, NULL, 'https://docs.google.com/presentation/d/14HFzELdo9rEb2CP7qp8MOuG8nXrsr8BYz11nWrlThus/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1763, 1337, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1764, 1338, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the argument that you developed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1765, 1339, 9, 100, NULL, '/new_platform/static/canvas/images/Toothbrush.png', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1766, 1339, 11, 200, NULL, NULL, 'Reflect on the following questions.<ul><li>How could you improve this item? Think big!</li><li>What problem does your improvement solve?</li><li>What is a different solution to the same problem?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1767, 1340, 11, 100, NULL, NULL, 'Think back to the problem statement that you wrote. Make a list of all the possible solutions you can imagine. Here are some questions to get you started.<ul><li>What is a realistic, relatively easy solution to this problem?</li><li>What is a more creative solution to this problem? Use your imagination!</li><li>What kinds of new technology or tools would need to be invented to support your solution?</li><li>Why doesn''t this solution already exist?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1768, 1341, 11, 100, NULL, NULL, 'Describe, in as much detail as possible, 2-3 realistic solutions to the problem that you chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1769, 1342, 11, 100, NULL, NULL, 'Tell your mentor how they can help you strengthen or choose from these possible solutions.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (381, 1768, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (382, 1769, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (372, 1764, 332, TRUE, 100, 0);

--10.3.5 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (230, 5, 83, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Create Solutions: Be a Risk Taker');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (751, 230, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (752, 230, 2, 2, 3, 200, 'Make the image better');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (753, 230, 2, 3, 3, 300, 'Brainstorm solutions');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1343, 751, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1344, 752, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1345, 753, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1346, 753, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1347, 753, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1770, 1343, 11, 100, NULL, NULL, 'Read your mentor’s feedback on the argument that you developed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1771, 1344, 9, 100, NULL, '/new_platform/static/canvas/images/Toothbrush.png', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1772, 1344, 11, 200, NULL, NULL, 'Reflect on the following questions.<ul><li>How could you improve this item? Think big!</li><li>What problem does your improvement solve?</li><li>What is a different solution to the same problem?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1773, 1345, 11, 100, NULL, NULL, 'Think back to the problem statement that you wrote. Make a list of all the possible solutions you can imagine. Here are some questions to get you started.<ul><li>What is a realistic, relatively easy solution to this problem?</li><li>What is a more creative solution to this problem? Use your imagination!</li><li>What kinds of new technology or tools would need to be invented to support your solution?</li><li>Why doesn''t this solution already exist?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1774, 1346, 11, 100, NULL, NULL, 'Describe, in as much detail as possible, 2-3 realistic solutions to the problem that you chose.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1775, 1347, 11, 100, NULL, NULL, 'Tell your mentor how they can help you strengthen or choose from these possible solutions.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (383, 1774, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (384, 1775, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (373, 1770, 332, TRUE, 100, 0);

--10.3.5 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (231, 4, 83, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Create Solutions: Be a Risk Taker');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (754, 231, 2, 1, 2, 100, 'Make the image better');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (755, 231, 2, 2, 2, 200, 'Brainstorm solutions');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1348, 754, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1349, 755, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1350, 755, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1351, 755, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1776, 1348, 9, 100, NULL, '/new_platform/static/canvas/images/Toothbrush.png', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1777, 1348, 11, 200, NULL, NULL, 'Your mentee practiced the skill of brainstorming multiple solutions to a problem by considering the following questions about this image.<ul><li>How could you improve this item? Think big!</li><li>What problem does your improvement solve?</li><li>What is a different solution to the same problem?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1778, 1349, 11, 100, NULL, NULL, 'Your mentee applied this skill by brainstorming 2-3 solutions to the problem they’ve been working on. They used the following questions to guide their thinking.<ul><li>What is a realistic, relatively easy solution to this problem?</li><li>What is a more creative solution to this problem? Use your imagination!</li><li>What kinds of new technology or tools would need to be invented to support your solution?</li><li>Why doesn''t this solution already exist?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1779, 1350, 11, 100, NULL, NULL, 'They asked for your feedback and support in the following ways.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1780, 1351, 11, 100, NULL, NULL, 'Provide some feedback to help your mentee strengthen or narrow down the solutions they brainstormed. Be sure to address the specific ways in which they asked for your support.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (385, 1780, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (374, 1778, 383, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (375, 1779, 384, TRUE, 100, 0);

--10.3.6 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (84, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 8, 6, NULL, 'Synthesize and Decide: Which Solution is Best?', '/new_platform/static/canvas/images/10.3.6.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (232, 1, 84, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Synthesize and Decide: Which Solution is Best?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (756, 232, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (757, 232, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (758, 232, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (759, 232, 2, 2, 3, 400, 'Assess the options');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (760, 232, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1352, 756, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1353, 756, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1354, 757, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1355, 758, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1356, 758, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1357, 758, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1358, 759, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1359, 759, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1360, 760, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1781, 1352, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will introduce the use of different assessments and criteria to determine which solutions would work best. Mentees will use assessment criteria to select the strongest solution to their selected problems and predict where this solution might run into challenges.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Generate a set of assessment criteria to apply to their selected problems</li><li>Use their assessment criteria to select the strongest solution</li><li>Predict and acknowledge challenges that might exist with their chosen solution</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/critical-thinking-synthesize-and-decide" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1782, 1353, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1783, 1353, 6, 200, NULL, 'https://docs.google.com/presentation/d/14l7u69PPrXwq2owBp9hdA3yMTWlotXNBVj0-NBotlO4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1784, 1354, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1785, 1355, 11, 100, NULL, NULL, 'Your mentor provided feedback on the 2-3 solutions that you created.<p><p>As a reminder, here are the solutions you wrote:</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1786, 1356, 11, 100, NULL, NULL, 'Here is your mentor’s feedback:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1787, 1357, 11, 100, NULL, NULL, 'Use that feedback to strengthen any of the solutions you proposed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1788, 1358, 9, 100, NULL, '/new_platform/static/canvas/images/cost-benefit.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1789, 1358, 11, 200, NULL, NULL, 'A “cost-benefit analysis” is one way to assess a list of options.<p><p>In a “cost-benefit analysis”, you sum up all of the pros and cons across certain values that matter to you.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1790, 1359, 11, 100, NULL, NULL, 'Use the chart below to complete a “cost-benefit analysis” of 2 potential solutions to your problem.<p><p>Follow these steps to get started:<ul><li>Consider 3-5 qualities of the best solution. Write them in the left column of the chart.</li><li>Write your potential solutions across the top of the chart.</li><li>On a scale of 1-5, rate how well each solution meets each quality.</li><li>Total up the scores for your possible solutions. Which one scores highest?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1791, 1359, 6, 200, NULL, 'https://docs.google.com/document/d/1Uk6E9OCX_OefYD9sFPHFrqHUZVFyOO6urMmcm-tdfg0/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1792, 1360, 11, 100, NULL, NULL, 'Based on your analysis, which is the best solution to your problem and why? Convince your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (386, 1787, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (387, 1792, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (376, 1785, 383, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (377, 1786, 385, TRUE, 100, 0);

--10.3.6 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (233, 5, 84, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Synthesize and Decide: Which Solution is Best?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (761, 233, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (762, 233, 2, 2, 3, 200, 'Assess the options');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (763, 233, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1361, 761, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1362, 761, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1363, 761, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1364, 762, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1365, 762, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1366, 763, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1793, 1361, 11, 100, NULL, NULL, 'Your mentor provided feedback on the 2-3 solutions that you created.<p><p>As a reminder, here are the solutions you wrote:</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1794, 1362, 11, 100, NULL, NULL, 'Here is your mentor’s feedback:', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1795, 1363, 11, 100, NULL, NULL, 'Use that feedback to strengthen any of the solutions you proposed.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1796, 1364, 9, 100, NULL, '/new_platform/static/canvas/images/cost-benefit.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1797, 1364, 11, 200, NULL, NULL, 'A “cost-benefit analysis” is one way to assess a list of options.<p><p>In a “cost-benefit analysis”, you sum up all of the pros and cons across certain values that matter to you.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1798, 1365, 11, 100, NULL, NULL, 'Use the chart below to complete a “cost-benefit analysis” of 2 potential solutions to your problem.<p><p>Follow these steps to get started:<ul><li>Consider 3-5 qualities of the best solution. Write them in the left column of the chart.</li><li>Write your potential solutions across the top of the chart.</li><li>On a scale of 1-5, rate how well each solution meets each quality.</li><li>Total up the scores for your possible solutions. Which one scores highest?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1799, 1365, 6, 200, NULL, 'https://docs.google.com/document/d/1Uk6E9OCX_OefYD9sFPHFrqHUZVFyOO6urMmcm-tdfg0/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1800, 1366, 11, 100, NULL, NULL, 'Based on your analysis, which is the best solution to your problem and why? Convince your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (388, 1795, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (389, 1800, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (378, 1793, 383, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (379, 1794, 385, TRUE, 100, 0);

--10.3.6 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (234, 4, 84, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Synthesize and Decide: Which Solution is Best?');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (764, 234, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (765, 234, 2, 2, 3, 200, 'Assessing your options');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (766, 234, 2, 3, 3, 300, 'Share your personal experience');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1367, 764, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1368, 764, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1369, 765, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1370, 765, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1371, 765, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1372, 766, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1801, 1367, 11, 100, NULL, NULL, 'Your mentee used your feedback to improve their solutions.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1802, 1368, 11, 100, NULL, NULL, 'Then, your mentee participated in an activity that introduced them to the idea of using a cost-benefit analysis to assess a list of options.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1803, 1368, 9, 200, NULL, '/new_platform/static/canvas/images/cost-benefit.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1804, 1369, 11, 100, NULL, NULL, 'Your mentee made a cost-benefit chart to evaluate two potential solutions to the problem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1805, 1369, 6, 200, NULL, 'https://docs.google.com/document/d/1Uk6E9OCX_OefYD9sFPHFrqHUZVFyOO6urMmcm-tdfg0/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1806, 1370, 11, 100, NULL, NULL, 'They used this analysis to choose the best solution and wrote the following to try to convince you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1807, 1371, 11, 100, NULL, NULL, 'Was your mentee’s argument convincing? Provide feedback on their solution and process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (1808, 1372, 11, 100, NULL, NULL, 'What strategies do you use in your work or personal life to choose from a list of viable options? How have they helped you?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (390, 1807, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (391, 1808, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (380, 1801, 388, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (381, 1806, 389, TRUE, 100, 0);