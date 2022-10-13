--12.9.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (119, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 27, 2, NULL, 'Making a Choice', '/new_platform/static/canvas/images/12.9.2.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (336, 1, 119, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Making a Choice');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1088, 336, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1089, 336, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1090, 336, 2, 1, 3, 300, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1091, 336, 2, 2, 3, 400, 'Understanding my choices');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1092, 336, 2, 3, 3, 500, 'Share with my mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1935, 1088, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1936, 1088, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1937, 1089, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1938, 1090, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1939, 1091, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1940, 1091, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1941, 1092, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2536, 1935, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will review the "fit" factors that matter most to them and complete a "best fit" template to help them decide which schools best align with their interests and preferences. This lesson will also re-introduce tools like the College Scorecard to help mentees research the schools on their list before making final decisions.<p><p>In this lesson, mentees will:<ul><li>Review and understand a few key college metrics they should use when selecting a college.</li><li>Revisit their fit and match preferences.</li><li>Complete a fit template that displays how aligned schools are in several fit categories.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/making-a-choice" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2537, 1936, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2538, 1936, 6, 200, NULL, 'https://docs.google.com/presentation/d/1Lu7diOQhghOFLVrSForoIKwuLYAN5WWv5XSh9TXE1F4/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2539, 1937, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2540, 1938, 11, 100, NULL, NULL, 'Your mentor responded to your high and low from last week and shared their own. They also shared their experience when selecting a college and how confident they were in making the best choice.<p><p>Read your mentor’s message and respond.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2541, 1939, 11, 100, NULL, NULL, 'Use <a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a> to research the colleges you’ve been accepted to and are seriously interested in attending. Some key items to focus on include:<ul><li>Average cost</li><li>Graduation rate</li><li>Average debt</li><li>Retention rate</li><li>Student body diversity</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2542, 1940, 11, 100, NULL, NULL, 'Use the template below with your mentor to document your research. Which schools are looking like your best “fit”?<p><p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open the template.</p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2544, 1941, 11, 100, NULL, NULL, 'Option 1: If you know what college you plan to attend or what you are going to do after high school, share it with your mentor. Explain why you made that choice and what excites you about what lies ahead.<p><p>Option 2: If you don’t know yet, share the key questions you are thinking through. Which colleges are you deciding between? What factors matter more than the rest?</p></p><i>Remember, you can visit your college list at any time by clicking the menu on the top left of the screen.</i>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (545, 2540, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (546, 2544, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (514, 2540, 513, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (515, 2540, 514, TRUE, 200, 0);

--12.9.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (337, 5, 119, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Making a Choice');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1093, 337, 2, 1, 3, 100, 'Reconnect with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1094, 337, 2, 2, 3, 200, 'Understanding my choices');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1095, 337, 2, 3, 3, 300, 'Share with my mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1942, 1093, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1943, 1094, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1944, 1094, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1945, 1095, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2545, 1942, 11, 100, NULL, NULL, 'Your mentor responded to your high and low from last week and shared their own. They also shared their experience when selecting a college and how confident they were in making the best choice.<p><p>Read your mentor’s message and respond.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2546, 1943, 11, 100, NULL, NULL, 'Use <a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a> to research the colleges you’ve been accepted to and are seriously interested in attending. Some key items to focus on include:<ul><li>Average cost</li><li>Graduation rate</li><li>Average debt</li><li>Retention rate</li><li>Student body diversity</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2547, 1944, 11, 100, NULL, NULL, 'Use the template below with your mentor to document your research. Which schools are looking like your best “fit”?<p><p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open the template.</p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2549, 1945, 11, 100, NULL, NULL, 'Option 1: If you know what college you plan to attend or what you are going to do after high school, share it with your mentor. Explain why you made that choice and what excites you about what lies ahead.<p><p>Option 2: If you don’t know yet, share the key questions you are thinking through. Which colleges are you deciding between? What factors matter more than the rest?</p></p><i>Remember, you can visit your college list at any time by clicking the menu on the top left of the screen.</i>', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (547, 2545, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (548, 2549, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (516, 2545, 513, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (517, 2545, 514, TRUE, 200, 0);

--12.9.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (338, 4, 119, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Making a Choice');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1096, 338, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1097, 338, 2, 2, 3, 200, 'Your role in supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1098, 338, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1946, 1096, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1947, 1097, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1948, 1097, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1949, 1098, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1950, 1098, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2550, 1946, 11, 100, NULL, NULL, 'Your mentee is deciding what to do after high school. To help guide that decision, your mentee revisited the important “fit” factors they used to construct their college list, reviewed important college success metrics, and began filling out a template that the two of you can use together to help decide which college will be their best option.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2551, 1947, 11, 100, NULL, NULL, 'Please review the resource below as a refresher on the critical “fit” factors your mentee should considering as they decide which college to attend.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2552, 1947, 6, 200, NULL, 'https://docs.google.com/presentation/d/1oKgY7eNPzstmaGEyJyY7hysVPyz31M5xhp_tAIhOmvs/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2553, 1948, 11, 100, NULL, NULL, 'Your mentee started to fill out their Best Fit Template to document their research on colleges they’re interested in attending.<p><p>Use the <a href="https://collegescorecard.ed.gov/" target="_blank">College Scorecard</a> and your mentee’s Best Fit Template to help your mentee in their research process.</p></p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open your mentee’s Best Fit Template.<p><p><i>Don’t know what colleges your mentee has been accepted to yet? Check their college list by clicking the menu on the top left of the screen. Or, ask!</i></p></p>', NULL);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2555, 1949, 11, 100, NULL, NULL, 'Your mentee responded to your high and low and commented on your experience selecting colleges. Respond to your mentee.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2556, 1950, 11, 100, NULL, NULL, 'Your mentee had the option of responding to one of the two following prompts:<ul><li>Option 1: If you know what college you plan to attend or what you are going to do after high school, share it with your mentor. Explain why you made that choice and what excites you about what lies ahead.</li><li>Option 2: If you don’t know yet, share the key questions you are thinking through. Which colleges are you deciding between? What factors matter more than the rest?</li></ul><p><p>If your mentee responded to option 1, comment on their plans and share in their excitement.</p></p>If your mentee responded to option 2, share some encouraging words and advice.', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (549, 2555, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (550, 2556, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (518, 2555, 547, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (519, 2556, 548, TRUE, 100, 0);

--12.9.3 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (120, 3, '6/26/15 00:00:00', '6/26/15 23:59:59', 4, 27, 3, NULL, 'Comparing Award Letters', '/new_platform/static/canvas/images/12.9.3.jpg', NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (339, 1, 120, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comparing Award Letters');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1099, 339, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1100, 339, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1101, 339, 2, 1, 4, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1102, 339, 2, 2, 4, 400, 'What happens after the FAFSA?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1103, 339, 2, 3, 4, 500, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1104, 339, 2, 4, 4, 600, 'Continue the Best Fit Template');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1951, 1099, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1952, 1099, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1953, 1099, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1954, 1100, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1955, 1101, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1956, 1101, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1957, 1102, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1958, 1103, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1959, 1103, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1960, 1104, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2557, 1951, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to the components of an award letter, the challenges that come with interpreting an award letter, and the impact an award letter has on college choice. Additionally, this lesson provides mentees with an opportunity to apply and practice these deciphering skills to sample award letters from a college.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Review and understand the components of a financial aid award letter.</li><li>Review sample award letters to accurately identify the net cost of attending that institution.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/comparing-award-letters" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2558, 1952, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2559, 1952, 6, 200, NULL, 'https://docs.google.com/presentation/d/19tv28_ld-8FCi9jupdR78PETFNhAC2qzdEiYhAFQVE0/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2560, 1953, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2561, 1953, 3, 200, NULL, 'https://vimeo.com/149797961', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2562, 1954, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2563, 1955, 11, 100, NULL, NULL, 'Check out the high and low that your mentor shared with you this week!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2564, 1956, 11, 100, NULL, NULL, 'Your mentor also read your explanation about either what college you plan to attend or the options you’re deciding between. Read their response below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2565, 1957, 11, 100, NULL, NULL, 'Watch the video and answer the following questions:<ul><li>What is a SAR, and what information is in it?</li><li>What is a financial aid award letter?</li><li>Will you receive an award letter from every college you apply to?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2566, 1957, 3, 200, NULL, 'https://vimeo.com/149797961', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2567, 1958, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2568, 1959, 11, 100, NULL, NULL, 'Share an update with your mentor about where you are in the financial aid process. If you have any questions about the financial aid process, ask your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2569, 1960, 11, 100, NULL, NULL, 'Continue working on the Best Fit Template that you started last class. Which schools are looking like your best “fit”?<p><p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open the template.</p></p>', NULL);


INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (551, 2567, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (552, 2568, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (520, 2563, 549, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (521, 2564, 550, TRUE, 100, 0);

--12.9.3 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (340, 5, 120, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comparing Award Letters');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1105, 340, 2, 1, 4, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1106, 340, 2, 2, 4, 200, 'What happens after the FAFSA?');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1107, 340, 2, 3, 4, 300, 'Share with your mentor');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1108, 340, 2, 4, 4, 400, 'Continue the Best Fit Template');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1961, 1105, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1962, 1105, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1963, 1106, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1964, 1107, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1965, 1107, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1966, 1108, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2571, 1961, 11, 100, NULL, NULL, 'Check out the high and low that your mentor shared with you this week!', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2572, 1962, 11, 100, NULL, NULL, 'Your mentor also read your explanation about either what college you plan to attend or the options you’re deciding between. Read their response below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2573, 1963, 11, 100, NULL, NULL, 'Watch the video and answer the following questions:<ul><li>What is a SAR, and what information is in it?</li><li>What is a financial aid award letter?</li><li>Will you receive an award letter from every college you apply to?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2574, 1963, 3, 200, NULL, 'https://vimeo.com/149797961', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2575, 1964, 11, 100, NULL, NULL, 'Share one high (an event, experience or moment that was positive) and one low (an event, experience, or moment that was negative) from last week.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2576, 1965, 11, 100, NULL, NULL, 'Share an update with your mentor about where you are in the financial aid process. If you have any questions about the financial aid process, ask your mentor.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2577, 1966, 11, 100, NULL, NULL, 'Continue working on the Best Fit Template that you started last class. Which schools are looking like your best “fit”?<p><p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open the template.</p></p>', NULL);


INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (553, 2575, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (554, 2576, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (522, 2571, 549, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (523, 2572, 550, TRUE, 100, 0);

--12.9.3 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (341, 4, 120, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Comparing Award Letters');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1109, 341, 2, 1, 3, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1110, 341, 2, 2, 3, 200, 'Your role in supporting your mentee');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (1111, 341, 2, 3, 3, 300, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1967, 1109, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1968, 1110, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1969, 1110, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1970, 1111, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1971, 1111, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1972, 1111, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2579, 1967, 11, 100, NULL, NULL, 'Your mentee is learning about financial aid award letters and how to interpret them. Financial aid award letters can be confusing, difficult to decipher, and will look different from different colleges. Your mentee learned about the components of a financial aid award letter and practiced calculating their net cost from various sample award letters.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2580, 1968, 11, 100, NULL, NULL, 'Please watch the video to learn more about the financial aid process after students complete the FAFSA.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2581, 1968, 3, 200, NULL, 'https://vimeo.com/149797961', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2582, 1969, 11, 100, NULL, NULL, 'After watching the video, please review the following infographic to learn about the components of a financial aid award letter.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2583, 1969, 9, 200, NULL, '/new_platform/static/canvas/images/Deciphering_Fin_Aid_Letter.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2584, 1970, 11, 100, NULL, NULL, 'After learning about financial aid award letters during class, your mentee shared the following update about where they are in the financial aid process.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2585, 1971, 11, 100, NULL, NULL, 'Your mentee also read the high and low that you shared, and shared another one of their own.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2586, 1972, 11, 100, NULL, NULL, 'If they had extra time in class, your mentee may have also continued working on the Best Fit Template that they started last week.<p><p>Click <a href="https://docs.google.com/document/d/1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY/edit?usp=sharing" target="_blank">here</a> to open the template.</p></p>', NULL);


INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (524, 2584, 553, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (525, 2585, 554, TRUE, 100, 0);