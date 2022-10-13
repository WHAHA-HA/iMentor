--Reflection Cards

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (1, 2, '<ul><li>What did you learn in this unit?</li><li>Why is building a strong relationship important for this program?</li></ul>', '<ul><li>What did you learn in this unit?</li><li>Why is building a strong relationship important for this program?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (1, 9, '<ul><li>What did you learn about your mentee/mentor in this unit?</li><li>What excites you most about building your relationship?</li><li>What is one thing you''d like to accomplish together by the end of the year?</li></ul>', '<ul><li>What did you learn about your mentee/mentor in this unit?</li><li>What excites you most about building your relationship?</li><li>What is one thing you''d like to accomplish together by the end of the year?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (2, 4, '<ul><li>What did you learn in this unit?</li><li>What can you do differently this year than last year to improve?</li></ul>', '<ul><li>What did you learn in this unit?</li><li>What can you do differently this year than last year to improve?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (2, 10, '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>', '<ul><li>What excited you most in this unit?</li><li>What was most challenging in this unit?</li><li>What is one thing you''d like to improve on for the rest of the year?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (3, 3, '<ul><li>How would rate the strength of your relationship?</li><li>What can you do this year to improve it?</li></ul>', '<ul><li>How would rate the strength of your relationship?</li><li>What can you do this year to improve it?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (3, 11, '<ul><li>What did you learn in this unit?</li><li>What excited you most?</li><li>What challenged you most?</li></ul>', '<ul><li>What did you learn in this unit?</li><li>What excited you most?</li><li>What challenged you most?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (3, 12, '<ul><li>What did you learn in this unit?</li><li>What excited you most?</li><li>What challenged you most?</li></ul>', '<ul><li>What did you learn in this unit?</li><li>What excited you most?</li><li>What challenged you most?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (4, 5, '<ul><li>Reflect on your relationship.</li><li>How much have you grown together?</li><li>What will you need to do this year to ensure that you are both ready for what''s after high school?</li></ul>', '<ul><li>Reflect on your relationship.</li><li>How much have you grown together?</li><li>What will you need to do this year to ensure that you are both ready for what''s after high school?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (4, 13, '<ul><li>Reflect on the college process.</li><li>What have you learned about yourself and your mentee/mentor during this process?</li><li>What has been most challenging about the process?</li></ul>', '<ul><li>Reflect on the college process.</li><li>What have you learned about yourself and your mentee/mentor during this process?</li><li>What has been most challenging about the process?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (3, 1, '<ul><li>"What is the role of a mentor?</li><li>What about this program do you find most exciting?</li></ul>', '<ul><li>"What is the role of a mentor?</li><li>What about this program do you find most exciting?</li></ul>');

INSERT INTO portfolio_reflection_card (grade_id, unit_id, mentor_card_html, mentee_card_html)
VALUES (3, 7, '<ul><li>What is one thing you''d like to improve upon this year?</li><li>Why?</li></ul>', '<ul><li>What is one thing you''d like to improve upon this year?</li><li>Why?</li></ul>');

--Updated Icons

UPDATE canvas_unit_info SET unit_number = 1, description = 'Building Strong Relationships', featured_image = '/new_platform/static/canvas/images/building_relationships_grey.png', secondary_description = 'Who is my mentor or mentee?<p>What can I expect from this program?</p>' WHERE id = 2;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Becoming a Pair', featured_image = '/new_platform/static/canvas/images/becoming_a_pair_grey.png', secondary_description = 'How will we build a strong and healthy relationship?' WHERE id = 9;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Orientation (New Pairs)', featured_image = '/new_platform/static/canvas/images/orientation_grey.png', secondary_description = 'What can I expect from this program?' WHERE id = 1;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Reconnect (Returning Pairs)', featured_image = '/new_platform/static/canvas/images/reconnecting_grey.png', secondary_description = 'How did we do last year?<p>What can do we to be better?</p>' WHERE id = 3;
UPDATE canvas_unit_info SET unit_number = 3, description = 'My Goals, My Path', featured_image = '/new_platform/static/canvas/images/my_goals_my_path_grey.png', secondary_description = 'What are my personal goals?<p>How will I acheive them?</p>' WHERE id = 7;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Building Relationships (New Pairs)', featured_image = '/new_platform/static/canvas/images/building_relationships_grey.png', secondary_description = 'Who is my mentor or mentee?<p>How will we build a strong relationship?</p>' WHERE id = 11;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Completing My College List', featured_image = '/new_platform/static/canvas/images/completing_my_college_list_grey.png', secondary_description = 'What colleges do I intend on applying to?<p>Have I finalized my college list?</p>' WHERE id = 13;
UPDATE canvas_unit_info SET unit_number = 2, description = 'College Ready Pair (Returning Pairs)', featured_image = '/new_platform/static/canvas/images/becoming_a_college_pair_grey.png', secondary_description = 'Are we ready for college?<p>What can we do now to prepare?</p>' WHERE id = 12;