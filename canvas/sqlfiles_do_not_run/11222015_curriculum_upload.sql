--10.5.1 Staff Lesson

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (25, 5, 'Digital Citizenship', 'Digital_Citizenship', 'Who is the digital you?<p>Is it who you want it to be?</p>');

INSERT into portfolio_reflection_card (id, grade_id, unit_id, mentor_card_html, mentee_card_html) VALUES (25, 2, 25, '<ul><li>Has this unit influenced your opinion on how you show up online? Why or why not?</li><li>What might you do differently to improve your digital footprint?</li></ul>', '<ul><li>Has this unit influenced your opinion on how you show up online? Why or why not?</li><li>What might you do differently to improve your digital footprint?</li></ul>');

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (105, 2, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 25, 1, NULL, 'Image and Professionalism', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (294, 1, 105, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Image and Professionalism');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (961, 294, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (962, 294, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (963, 294, 2, 1, 3, 300, 'Review the profiles');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (964, 294, 2, 2, 3, 400, 'Define "digital footprint"');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (965, 294, 2, 3, 3, 500, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1713, 961, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1714, 961, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1715, 961, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1716, 962, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1717, 963, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1718, 964, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1719, 965, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1720, 965, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1751, 963, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1752, 963, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2256, 1713, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces pairs to the concept of a digital footprint and its relevance to mentees in high school.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define the concept of a "digital footprint"</li><li>Explore the relationship between professionalism and a digital footprint</li><li>Anticipate the relevance of a "digital footprint" to their lives</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/digital-footprints---1051" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2257, 1714, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2258, 1714, 6, 200, NULL, 'https://docs.google.com/presentation/d/15wGgBGPIMahXTldgW4Rve0FLzi5tz3cI1ko3ZaEwCfQ/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2259, 1715, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2260, 1715, 3, 200, NULL, 'https://vimeo.com/144631027', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2261, 1716, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2262, 1717, 11, 100, NULL, NULL, 'Imagine you are hiring for a new school principal. You’ve already interviewed all candidates, reviewed their resumes, and called their references. Now, you have two candidates who seem equally qualified on paper.<p><p>Review the hypothetical Facebook profiles for these two candidates. Which candidate would you choose and why?</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2263, 1751, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_1_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2264, 1752, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_2_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2265, 1718, 11, 100, NULL, NULL, 'Watch the video. As you watch, consider how you would define the phrase “digital footprint”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2266, 1718, 3, 200, NULL, 'https://vimeo.com/144631027', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2267, 1719, 11, 100, NULL, NULL, '<ul><li>Tell your mentor which candidate you choose during the activity and why?</li><li>If you were giving advice to the candidate you did NOT choose, how would you suggest they change their Facebook profile to leave a better impression?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2268, 1720, 11, 100, NULL, NULL, '<ul><li>Share your definition of a "digital footprint" with your mentor.</li><li>Why is being aware of your “digital footprint” important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2311, 1751, 11, 100, NULL, NULL, 'Candidate 1', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2312, 1752, 11, 100, NULL, NULL, 'Candidate 2', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (475, 2267, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (476, 2268, 100, 0, 2);

--10.5.1 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (295, 5, 105, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Image and Professionalism');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (966, 295, 2, 1, 3, 100, 'Review the profiles');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (967, 295, 2, 2, 3, 200, 'Define "digital footprint"');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (968, 295, 2, 3, 3, 300, 'Share with your mentor');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1721, 966, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1722, 967, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1723, 968, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1724, 968, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1753, 966, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1754, 966, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2269, 1721, 11, 100, NULL, NULL, 'Imagine you are hiring for a new school principal. You’ve already interviewed all candidates, reviewed their resumes, and called their references. Now, you have two candidates who seem equally qualified on paper.<p><p>Review the hypothetical Facebook profiles for these two candidates. Which candidate would you choose and why?</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2270, 1753, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_1_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2271, 1754, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_2_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2272, 1722, 11, 100, NULL, NULL, 'Watch the video. As you watch, consider how you would define the phrase “digital footprint”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2273, 1722, 3, 200, NULL, 'https://vimeo.com/144631027', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2274, 1723, 11, 100, NULL, NULL, '<ul><li>Tell your mentor which candidate you choose during the activity and why?</li><li>If you were giving advice to the candidate you did NOT choose, how would you suggest they change their Facebook profile to leave a better impression?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2275, 1724, 11, 100, NULL, NULL, '<ul><li>Share your definition of a "digital footprint" with your mentor.</li><li>Why is being aware of your “digital footprint” important?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2313, 1753, 11, 100, NULL, NULL, 'Candidate 1', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2314, 1754, 11, 100, NULL, NULL, 'Candidate 2', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (477, 2274, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (478, 2275, 100, 0, 2);

--10.5.1 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (296, 4, 105, '6/26/15 00:00:00', '6/26/15 23:59:59', 'Image and Professionalism');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (969, 296, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (970, 296, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1725, 969, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1726, 969, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1727, 969, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1728, 969, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1729, 969, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1730, 970, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1755, 969, 125);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1756, 969, 150);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2276, 1725, 11, 100, NULL, NULL, 'Your mentee participated in a class activity in which they imagined that they were hiring for a new school principal. Your mentee’s class imagined that they had interviewed all candidates, reviewed their resumes, and called their references. They were left with two candidates who seem equally qualified on paper.<p><p>Your mentee received the following hypothetical Facebook profiles for the two remaining candidates and was asked to work in groups to decide which candidate they would hire and why.</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2277, 1755, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_1_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2278, 1756, 9, 200, NULL, '/new_platform/static/canvas/images/Candidate_2_Facebook.jpg', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2279, 1726, 11, 100, NULL, NULL, 'Your mentee wrote the following to summarize their group’s activity from class.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2280, 1727, 11, 100, NULL, NULL, 'Share examples of how social media has positively or negatively impacted you or people you know.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2281, 1728, 11, 100, NULL, NULL, 'Your mentee watched the following video to introduce the concept of a “digital footprint”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2282, 1728, 3, 200, NULL, 'https://vimeo.com/144631027', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2283, 1729, 11, 100, NULL, NULL, 'Your mentee shared their personal definition of a “digital footprint”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2284, 1730, 11, 100, NULL, NULL, 'For students in high school, being aware of their digital footprint may not be a priority. However, with schools and employers paying an increasing amount of attention to social media sites, it is important that your mentee understands how they are projecting themselves online.<p><p>Share some suggestions with your mentee. How have you or others around you adjusted your own digital footprint? Why did you make those choices? (Some examples of how one might alter their digital footprints include adjusting privacy settings, adding/removing pictures, adding/removing listed interests, making specific social media posts, etc.).</p></p>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2315, 1755, 11, 100, NULL, NULL, 'Candidate 1', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2316, 1756, 11, 100, NULL, NULL, 'Candidate 2', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (479, 2280, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (480, 2284, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (460, 2279, 477, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (461, 2283, 478, TRUE, 100, 0);

--10.5.2 Staff Lesson

INSERT into canvas_curriculum (id, canvas_type, start_datetime, end_datetime, grade_id, unit_id, curriculum_number, member_id, description, featured_image, secondary_description) VALUES (106, 1, '6/26/15 00:00:00', '6/26/15 23:59:59', 2, 25, 2, NULL, 'My Personal Brand', NULL, NULL);

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (297, 1, 106, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Personal Brand');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (971, 297, 2, 1, 2, 100, 'Lesson Overview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (972, 297, 2, 2, 2, 200, 'Mentee Canvas Preview');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (973, 297, 2, 1, 2, 300, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (974, 297, 2, 2, 2, 400, 'Your ideal digital footprint');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1731, 971, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1732, 971, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1733, 971, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1734, 972, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1735, 973, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1736, 973, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1737, 974, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1738, 974, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1739, 974, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2285, 1731, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In this lesson, mentees will consider how their online activity shapes their digital footprint. This lesson will explore the impact that both positive and negative digital footprints can have.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Learn that they have a public presence online called a digital footprint</li><li>Recognize that any information they post online can help or hurt their image and future opportunities, including their chances for college admission or employment</li><li>Consider how to present an authentic and positive image of themselves online</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/my-personal-brand---1052" target="_blank">here</a>.</b>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2286, 1732, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2287, 1732, 6, 200, NULL, 'https://docs.google.com/presentation/d/1v3XI-h0bkX8AuvFkGhWniFQEJs2WPSnRuueKns0dWnY/embed', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2288, 1733, 11, 100, NULL, NULL, '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2289, 1733, 3, 200, NULL, 'https://vimeo.com/144644304', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2290, 1734, 11, 100, NULL, NULL, 'The following Canvas cards are what your class will see during this lesson.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2291, 1735, 11, 100, NULL, NULL, 'Your mentor shared how social media plays a role in their professional life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2292, 1736, 11, 100, NULL, NULL, 'Your mentor also shared some examples about how they have adjusted their own digital footprint. Read them below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2293, 1737, 3, 100, NULL, 'https://vimeo.com/144644304', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2294, 1737, 11, 200, NULL, NULL, 'Now think about the following questions:<ul><li>What were some of the messages that stood out to you from the video? Can you relate to Abbas? Why or why not?</li><li>Abbas says that he thinks colleges would actually "kind of like his Facebook page". What examples does Abbas give about how he has created a positive digital footprint for himself?</li><li>Do you think you should judge someone based on what you find about them online? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2295, 1738, 11, 100, NULL, NULL, 'Tell your mentor how you would describe your “digital footprint” in its current state. What does your social media presence say about you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2296, 1739, 11, 100, NULL, NULL, 'Think about who might look for your digital footprint, both now and in the future. What is the first impression that you want your digital footprint to leave on these people? What changes, if any, would you need to make to project this impression?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (481, 2295, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (482, 2296, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (462, 2291, 479, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (463, 2292, 480, TRUE, 100, 0);

--10.5.2 Mentee Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (298, 5, 106, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Personal Brand');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (975, 298, 2, 1, 2, 100, 'Read your mentor’s response');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (976, 298, 2, 2, 2, 200, 'Your ideal digital footprint');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1740, 975, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1741, 975, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1742, 976, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1743, 976, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1744, 976, 300);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2297, 1740, 11, 100, NULL, NULL, 'Your mentor shared how social media plays a role in their professional life.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2298, 1741, 11, 100, NULL, NULL, 'Your mentor also shared some examples about how they have adjusted their own digital footprint. Read them below.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2299, 1742, 3, 100, NULL, 'https://vimeo.com/144644304', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2300, 1742, 11, 200, NULL, NULL, 'Now think about the following questions:<ul><li>What were some of the messages that stood out to you from the video? Can you relate to Abbas? Why or why not?</li><li>Abbas says that he thinks colleges would actually "kind of like his Facebook page". What examples does Abbas give about how he has created a positive digital footprint for himself?</li><li>Do you think you should judge someone based on what you find about them online? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2301, 1743, 11, 100, NULL, NULL, 'Tell your mentor how you would describe your “digital footprint” in its current state. What does your social media presence say about you?', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2302, 1744, 11, 100, NULL, NULL, 'Think about who might look for your digital footprint, both now and in the future. What is the first impression that you want your digital footprint to leave on these people? What changes, if any, would you need to make to project this impression?', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (483, 2301, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (484, 2302, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (464, 2297, 479, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (465, 2298, 480, TRUE, 100, 0);

--10.5.2 Mentor Lesson

INSERT into canvas_set (id, role, curriculum_id, start_datetime, end_datetime, description) VALUES (299, 4, 106, '6/26/15 00:00:00', '6/26/15 23:59:59', 'My Personal Brand');

INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (977, 299, 2, 1, 2, 100, 'Here’s what your mentee did in class…');
INSERT into canvas_app (id, canvas_set_id, app_type,  n_of_total, total, ordinal, description) VALUES (978, 299, 2, 2, 2, 200, 'Now it’s your turn…');

INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1745, 977, 100);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1746, 977, 200);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1747, 977, 300);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1748, 977, 400);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1749, 977, 500);
INSERT into canvas_widget (id, canvas_app_id, ordinal) VALUES (1750, 978, 100);

INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2303, 1745, 11, 100, NULL, NULL, 'Note: This lesson is about your mentee’s social media use. As a reminder, our policy is that pairs do not connect through social media. If you have questions about this policy, please contact your staff support person.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2304, 1746, 11, 100, NULL, NULL, 'Your mentee watched the following video about how you can shape your digital footprint.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2305, 1746, 3, 200, NULL, 'https://vimeo.com/144644304', NULL, NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2306, 1746, 11, 300, NULL, NULL, 'After watching the video, your mentee’s class discussed the following questions.<ul><li>What were some of the messages that stood out to you from the video? Can you relate to Abbas? Why or why not?</li><li>Abbas says that he thinks colleges would actually "kind of like his Facebook page". What examples does Abbas give about how he has created a positive digital footprint for himself?</li><li>Do you think you should judge someone based on what you find about them online? Why or why not?</li></ul>', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2307, 1747, 11, 100, NULL, NULL, 'Your mentee wrote the following to describe their current “digital footprint”.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2308, 1748, 11, 100, NULL, NULL, 'Then, your mentee thought about who might be searching for their digital footprint, what kind of impression they want to leave, and what changes, if any, they’ll need to make to project that impression.', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2309, 1749, 11, 100, NULL, NULL, 'Respond to your mentee''s description of their digital footprint. If relevant, provide some additional suggestions for how your mentee can enhance their digital footprints (for example, posting an interesting article vs removing unprofessional photos).', NULL);
INSERT into canvas_widget_content (id, widget_id, content_type, ordinal, filename, url, html, plain_text) VALUES (2310, 1750, 11, 100, NULL, NULL, 'Next week, your mentee will be exploring how they can use online communities to promote a positive digital footprint. Describe some ways in which you use your online presence to promote a positive digital footprint for yourself (examples include activity on LinkedIn, posting in intentional discussion groups, sharing photos/videos, etc).', NULL);

INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (485, 2309, 100, 0, 2);
INSERT into canvas_widget_content_response_marker (id, widget_content_id, ordinal, position, response_type) VALUES (486, 2310, 100, 0, 2);

INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (466, 2307, 483, TRUE, 100, 0);
INSERT into canvas_widget_content_marker_reference (id, widget_content_id, other_marker_id, read_only, ordinal, position) VALUES (467, 2308, 484, TRUE, 100, 0);