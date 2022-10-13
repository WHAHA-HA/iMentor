--Mentee Lesson 13.1.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (51, 5, 20, '6/19/15 00:00:00', '6/19/15 23:59:59', 'Academic Progress');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (147, 51, 2, 1, 4, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (148, 51, 2, 2, 4, 200, 'Read this month’s objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (149, 51, 2, 3, 4, 300, 'Create a study plan');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (150, 51, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (239, 147, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (240, 148, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (241, 149, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (242, 149, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (243, 150, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (244, 150, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (340, 239, 11, 100, NULL, NULL, 'Welcome to your first lesson in the college program! To start, watch this video of iMentor pairs in college.<p><p>As you watch, consider the following:<ul><li>How do academic expectations differ between high school and college?</li><li>What habits or actions allowed the mentees in this video to succeed?</li><li>How do you want your mentor to support your academics this year?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (341, 239, 2, 200, NULL, 'https://www.youtube.com/watch?v=PEu5Sj-BiQQ', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (342, 240, 11, 100, NULL, NULL, 'Every month, our curriculum will focus on one important difference between high school and college. This month, our focus is on “academic progress”. Below are our objectives, and you can learn more about this topic <a href="https://learn.imentor.org/help/article/link/topic-overview-academic-progress" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (343, 240, 6, 200, NULL, 'https://docs.google.com/presentation/d/12NvNdXO3GXthUBY4Cuk9-ATEUPZIPhpN4aVWf51xA7A/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (344, 241, 11, 100, NULL, NULL, 'Read <a href="https://learn.imentor.org/help/article/link/creating-a-college-study-plan" target="_blank">this</a> article about creating a study plan in college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (345, 242, 11, 100, NULL, NULL, 'Follow the instructions in the article above to create a study plan using the template below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (346, 242, 6, 200, NULL, 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit#gid=0', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (347, 243, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that you should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (348, 243, 6, 200, NULL, 'https://docs.google.com/presentation/d/1zuZRzG3yidioxRQ7CmE-A-pte2VIvCiAd0vP8m5VDiI/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (349, 244, 11, 100, NULL, NULL, 'Schedule some time with your mentor to work on the things on your Pair To Do List now.', NULL);

--Mentor Lesson 13.1.1

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (52, 4, 20, '6/19/15 00:00:00', '6/19/15 23:59:59', 'Academic Progress');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (151, 52, 2, 1, 4, 100, 'Watch the video');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (152, 52, 2, 2, 4, 200, 'Read this month’s objectives');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (153, 52, 2, 3, 4, 300, 'Create a study plan');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (154, 52, 2, 4, 4, 400, 'Review your Pair To Do List');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (245, 151, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (246, 152, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (247, 153, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (248, 153, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (249, 153, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (250, 154, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (251, 154, 200);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (350, 245, 11, 100, NULL, NULL, 'Welcome to your first lesson in the college program! To start, watch the following video of iMentor pairs in college.<p><p>As you watch, recall the following about your own college experience:<ul><li>How did academic expectations change between high school and college?</li><li>What habits or actions allowed you to succeed in your new college environment?</li><li>How can you support your mentee’s academic progress this year?</li></ul></p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (351, 245, 2, 200, NULL, 'https://www.youtube.com/watch?v=PEu5Sj-BiQQ', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (352, 246, 11, 100, NULL, NULL, 'Every month, our curriculum will focus on one important difference between high school and college. This month, our focus is on “academic progress”. Below are our objectives, and you can learn more about this topic <a href="https://learn.imentor.org/help/article/link/topic-overview-academic-progress" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (353, 246, 6, 200, NULL, 'https://docs.google.com/presentation/d/12NvNdXO3GXthUBY4Cuk9-ATEUPZIPhpN4aVWf51xA7A/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (354, 247, 11, 100, NULL, NULL, 'Your mentee was asked to read <a href="https://learn.imentor.org/help/article/link/creating-a-college-study-plan" target="_blank">this</a> article about what a study plan is and how to create one. Then, your mentee was asked to follow the instructions in the article to create their own study plan.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (355, 248, 11, 100, NULL, NULL, 'Begin by reading <a href="https://learn.imentor.org/help/article/link/creating-a-college-study-plan" target="_blank">this same article</a> that your mentee read. Then, read <a href="http://www.campusexplorer.com/college-advice-tips/0BE2FE0B/Setting-Up-Your-College-Class-Schedule/" target="_blank">this second article</a> about common pitfalls with class scheduling in college.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (356, 249, 11, 100, NULL, NULL, 'Use what you read in the articles or recalled about your own experience to review your mentee’s study plan and offer comments. You can leave feedback directly in the spreadsheet or discuss separately with your mentee.<p><p>If your mentee has not done this yet, tell them to get started!</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (357, 249, 6, 200, NULL, 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit#gid=0', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (358, 250, 11, 100, NULL, NULL, 'Review your Pair To Do List. These are things that your mentee should do to stay on track this month.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (359, 250, 6, 200, NULL, 'https://docs.google.com/presentation/d/1zuZRzG3yidioxRQ7CmE-A-pte2VIvCiAd0vP8m5VDiI/embed?start=false&loop=false&delayms=3000', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (360, 251, 11, 100, NULL, NULL, 'Schedule some time to work on these things with your mentee. This should include at least one in-person meeting plus any combination of additional meetings, phone calls, texts, etc. <a href="https://learn.imentor.org/help/article/link/pair-to-do-list-for-topic-1" target="_blank">Here</a> are some suggestions for in-person meetings this month.', NULL);