--Add Google document titles

INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1QdexS6gU1j6VoqaBBwyjRLePd24MChL4pqDeEbxKMbM', 'Mentee 10 in 10');
INSERT INTO canvas_doc_title_mapping (orig_doc_id, doc_title) VALUES ('1GUHADe0IH6AtuLTriljWRFdOkvF0ZmP4Bhk8Pux7S8U', 'Mentor 10 in 10');

--Unit icon updates

UPDATE canvas_unit_info
SET featured_image = 'self_advocacy'
WHERE id = 33;

UPDATE canvas_unit_info
SET featured_image = 'college_vs_high_school'
WHERE id = 32;

UPDATE canvas_unit_info
SET featured_image = 'my_college_aspirations'
WHERE id = 34;

--10.8.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (34, 8, 'My College Aspirations', NULL, 'Why does college matter?<p>What is my path to college success?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (34, 2, 34, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How can you improve through the rest of the college application process?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>How can you improve through the rest of the college application process?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (134, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 34, 1, NULL, 'In 10 Years...', '/new_platform/static/canvas/images/10.8.1.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (381, 1, 134, '6/26/15 00:00:00', '6/26/15 23:59:59', 'In 10 Years...');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1230, 381, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1231, 381, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1232, 381, 2, 1, 1, 300, 'In 10 years');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2143, 1230, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2144, 1230, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2145, 1231, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2146, 1232, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2147, 1232, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2148, 1232, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2806, 2143, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees map out where they see themselves in 10 years.<p><p>In this lesson, mentees will:<ul><li>Complete a mind map that requires mentees to identify and document where they want to be and what they want to have accomplished 10 years from now.</li><li>Complete an "In 10 years, I Am" poem to share with their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/in-10-years" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2807, 2144, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2808, 2144, 6, 200, NULL, 'https://docs.google.com/presentation/d/1vMJf36egTdb0DDOxxKvFIQnjtEK3tOiLcKH1XL0kK40/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2809, 2145, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2810, 2146, 9, 100, NULL, '/new_platform/static/canvas/images/Believe_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2811, 2147, 11, 100, NULL, NULL, 'Look ahead to 10 years from now. Where are you? What are you doing? What have you accomplished?<p><p>Share your thoughts with your mentor by writing your “10 in 10” poem using the template below.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2812, 2147, 6, 200, NULL, 'https://docs.google.com/document/d/1QdexS6gU1j6VoqaBBwyjRLePd24MChL4pqDeEbxKMbM/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2813, 2148, 11, 100, NULL, NULL, 'Review the 10 items in your poem. Tell your mentor which 1-2 things are the most important to you on your list? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (605, 2813, 100, 0, 2);

--10.8.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (382, 5, 134, '6/26/15 00:00:00', '6/26/15 23:59:59', 'In 10 Years...');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1233, 382, 2, 1, 1, 100, 'In 10 years');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2149, 1233, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2150, 1233, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2151, 1233, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2814, 2149, 9, 100, NULL, '/new_platform/static/canvas/images/Believe_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2815, 2150, 11, 100, NULL, NULL, 'Look ahead to 10 years from now. Where are you? What are you doing? What have you accomplished?<p><p>Share your thoughts with your mentor by writing your “10 in 10” poem using the template below.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2816, 2150, 6, 200, NULL, 'https://docs.google.com/document/d/1QdexS6gU1j6VoqaBBwyjRLePd24MChL4pqDeEbxKMbM/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2817, 2151, 11, 100, NULL, NULL, 'Review the 10 items in your poem. Tell your mentor which 1-2 things are the most important to you on your list? Why?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (606, 2817, 100, 0, 2);

--10.8.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (383, 4, 134, '6/26/15 00:00:00', '6/26/15 23:59:59', 'In 10 Years...');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1234, 383, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1235, 383, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2152, 1234, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2153, 1235, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2154, 1235, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2818, 2152, 9, 100, NULL, '/new_platform/static/canvas/images/Believe_Quote.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2819, 2152, 11, 100, NULL, NULL, 'Aspirations are important to success because people cannot achieve what they don’t dream. In this lesson, your mentee started the process of documenting their aspirations by looking ahead 10 years and reflecting on where they see themselves. They created a “10 in 10” poem (10 things in 10 years) and shared their most important items with you.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2820, 2152, 6, 200, NULL, 'https://docs.google.com/document/d/1QdexS6gU1j6VoqaBBwyjRLePd24MChL4pqDeEbxKMbM/edit?usp=sharing', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2821, 2153, 11, 100, NULL, NULL, 'Respond to your mentee’s poem and reflection. Here are some questions to get you started:<ul><li>What stood out to you about where they see themselves in 10 years?</li><li>What inspires you about what they shared?</li><li>What words of encouragement can you provide?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2822, 2154, 11, 100, NULL, NULL, 'Complete your own 10 in 10 poem.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2823, 2154, 6, 200, NULL, 'https://docs.google.com/document/d/1GUHADe0IH6AtuLTriljWRFdOkvF0ZmP4Bhk8Pux7S8U/edit?usp=sharing', NULL, NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (607, 2821, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (575, 2820, 606, TRUE, 100, 0);