--11.10.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (125, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 3, 29, 2, NULL, 'Loans', '/new_platform/static/canvas/images/11.10.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (354, 1, 125, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Loans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1152, 354, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1153, 354, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1154, 354, 2, 1, 3, 300, 'What are the different types of loans?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1155, 354, 2, 2, 3, 400, 'Myth vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1156, 354, 2, 3, 3, 500, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2025, 1152, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2026, 1152, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2027, 1152, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2028, 1153, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2029, 1154, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2030, 1155, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2031, 1156, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2032, 1156, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2656, 2025, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to student loans, different loan types, and explores the real tension between loans feeling like an overwhelming debt vs. being a good investment.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define the following terms: loan, interest rate, term</li><li>Understand the difference between federal and private loans</li><li>Discuss tips for understanding the right time to take out loans and being a responsible borrower</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/understanding-loans" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2657, 2026, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2658, 2026, 6, 200, NULL, 'https://docs.google.com/presentation/d/1V5lLJ0uNb3hc33dckC6vy4OAgIiKz0g0A_AeLGwJ7u4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2659, 2027, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2660, 2027, 3, 200, NULL, 'https://vimeo.com/151051463', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2661, 2027, 3, 300, NULL, 'https://vimeo.com/151051464', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2662, 2028, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2663, 2029, 11, 100, NULL, NULL, 'As you watch the video, consider the following:<ul><li>What are the differences between a federal vs. private loan?</li><li>Why does it matter that private loans have higher interest rates?</li><li>What is loan forgiveness?</li><li>Can you only take out a single type of loan?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2664, 2029, 3, 200, NULL, 'https://vimeo.com/151051463', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2665, 2030, 11, 100, NULL, NULL, 'Read the following statements. Tell your mentor if you think they are myths are realities. Be sure to explain why.<ul><li>You will never pay off your student loans.</li><li>Loans aren''t worth the money.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2666, 2031, 11, 100, NULL, NULL, 'Your mentor responded to you from last week and shared a high and low of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2667, 2032, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (566, 2665, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (567, 2667, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (540, 2666, 525, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (541, 2666, 526, TRUE, 200, 0);

--11.10.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (355, 5, 125, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Loans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1157, 355, 2, 1, 3, 100, 'What are the different types of loans?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1158, 355, 2, 2, 3, 200, 'Myth vs Reality');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1159, 355, 2, 3, 3, 300, 'Reconnect with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2033, 1157, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2034, 1158, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2035, 1159, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2036, 1159, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2668, 2033, 11, 100, NULL, NULL, 'As you watch the video, consider the following:<ul><li>What are the differences between a federal vs. private loan?</li><li>Why does it matter that private loans have higher interest rates?</li><li>What is loan forgiveness?</li><li>Can you only take out a single type of loan?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2669, 2033, 3, 200, NULL, 'https://vimeo.com/151051463', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2670, 2034, 11, 100, NULL, NULL, 'Read the following statements. Tell your mentor if you think they are myths are realities. Be sure to explain why.<ul><li>You will never pay off your student loans.</li><li>Loans aren''t worth the money.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2671, 2035, 11, 100, NULL, NULL, 'Your mentor responded to you from last week and shared a high and low of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2672, 2036, 11, 100, NULL, NULL, 'Respond to your mentor.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (568, 2670, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (569, 2672, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (542, 2671, 525, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (543, 2671, 526, TRUE, 200, 0);

--11.10.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (356, 4, 125, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Loans');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1160, 356, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1161, 356, 2, 2, 3, 200, 'Supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1162, 356, 2, 3, 3, 300, 'Reconnect with your mentee');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2037, 1160, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2038, 1161, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2039, 1162, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2040, 1162, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (2041, 1162, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2673, 2037, 11, 100, NULL, NULL, 'As part of the financial aid process for college, your mentee may have to take out loans. In class, your mentee learned the basics about  loans, what they are and how they work. More importantly, your mentee learned about the primary differences between federal and private loans.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2674, 2037, 3, 200, NULL, 'https://vimeo.com/151051463', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2675, 2038, 11, 100, NULL, NULL, 'Many students mistakenly believe that they should avoid taking out loans, even it it means not attending college at all. Here are some tips for how you can support your mentee through this process. Your mentee should understand the following:<ol><li><b>Loans can be a great investment in their own future.</b></li><li><b>If they are going to take out loans, they should think federal aid first.</b> With lower interest rates, multiple repayment plans, and opportunities for loan forgiveness, federal loans are the way to go.</li><li><b>How much they should borrow.</b> There is no one size fits all answer to this. Your mentee should weigh the cost of each of their college options and research the earning potential in their desired field before making a decision.</li><li><b>What it means to borrow responsibly.</b> While there are a variety of circumstances that lead to loan default, many of them can be avoided by understanding the repayment requirements and options.</li></ol><p><p>Check out the resource below to learn more about federal loans.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2676, 2038, 8, 200, NULL, '/new_platform/static/canvas/documents/Federal_Loans.pdf', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2677, 2039, 11, 100, NULL, NULL, 'Your mentee responded to your updates from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2678, 2040, 11, 100, NULL, NULL, 'After learning about loans, your mentee shared whether they thought the following statements were myths or realities.<ul><li>You will never pay off your student loans.</li><li>Loans aren''t worth the money.</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2679, 2041, 11, 100, NULL, NULL, 'Respond to your mentee. What feedback can you provide on their myth vs reality comments? What can you share about your own experience with student loans?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (570, 2679, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (544, 2677, 569, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (545, 2678, 568, TRUE, 100, 0);