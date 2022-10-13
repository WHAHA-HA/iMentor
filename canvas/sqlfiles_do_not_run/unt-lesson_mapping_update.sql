--Master Units

INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (9, 2, 'Becoming a Pair', NULL, 'How will we build a strong and healthy relationship?');
INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (10, 2, 'Setting Goals', '/new_platform/static/canvas/images/setting_goals_grey.png', 'What do we want to accomplish this year?<p>How are we going to do it?</p>');
INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (11, 2, 'Building Relationships (New Pairs)', NULL, 'Who is my mentor or mentee?<p>How will we build a strong relationship?</p>');
INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (12, 2, 'College Ready Pair (Returning Pairs)', NULL, 'Are we ready for college?<p>What can we do now to prepare?</p>');
INSERT into canvas_unit_info (id, unit_number, description, featured_image, secondary_description) VALUES (13, 2, 'Completing My College List', NULL, 'What colleges do I intend on applying to?<p>Have I finalized my college list?</p>');

UPDATE canvas_unit_info SET unit_number = 1, description = 'Orientation (New Pairs)', featured_image = NULL, secondary_description = 'What can I expect from this program?' WHERE id = 1;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Building Strong Relationships', featured_image = NULL, secondary_description = 'Who is my mentor or mentee?<p>What can I expect from this program?</p>' WHERE id = 2;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Reconnect (Returning Pairs)', featured_image = '/new_platform/static/canvas/images/reconnecting_grey.png', secondary_description = 'How did we do last year?<p>What can do we to be better?</p>' WHERE id = 3;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Reconnect', featured_image = '/new_platform/static/canvas/images/reconnecting_grey.png', secondary_description = 'How did we do last year?<p>How can we be better?</p>' WHERE id = 4;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Reconnect', featured_image = '/new_platform/static/canvas/images/reconnecting_grey.png', secondary_description = 'Are we college ready?<p>What can we do to prepare?</p>' WHERE id = 5;
UPDATE canvas_unit_info SET unit_number = 1, description = 'Academic Progress', featured_image = NULL, secondary_description = NULL WHERE id = 6;
UPDATE canvas_unit_info SET unit_number = 3, description = 'My Goals, My Path', featured_image = NULL, secondary_description = 'What are my personal goals?<p>How will I acheive them?</p>' WHERE id = 7;
UPDATE canvas_unit_info SET unit_number = 3, description = 'Critical Thinking', featured_image = '/new_platform/static/canvas/images/critical_thinking_grey.png', secondary_description = 'What is critical thinking?<p>Why is it important to think critically?</p>' WHERE id = 8;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Becoming a Pair', featured_image = NULL, secondary_description = 'How will we build a strong and healthy relationship?' WHERE id = 9;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Setting Goals', featured_image = '/new_platform/static/canvas/images/setting_goals_grey.png', secondary_description = 'What do we want to accomplish this year?<p>How are we going to do it?</p>' WHERE id = 10;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Building Relationships (New Pairs)', featured_image = NULL, secondary_description = 'Who is my mentor or mentee?<p>How will we build a strong relationship?</p>' WHERE id = 11;
UPDATE canvas_unit_info SET unit_number = 2, description = 'College Ready Pair (Returning Pairs)', featured_image = NULL, secondary_description = 'Are we ready for college?<p>What can we do now to prepare?</p>' WHERE id = 12;
UPDATE canvas_unit_info SET unit_number = 2, description = 'Completing My College List', featured_image = NULL, secondary_description = 'What colleges do I intend on applying to?<p>Have I finalized my college list?</p>' WHERE id = 13;

--Master Lessons

UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 2, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/9.1.1.jpg', secondary_description = NULL WHERE id = 6;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 4, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/10.1.1.jpg', secondary_description = NULL WHERE id = 7;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 3, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/RP_11.1.1.jpg', secondary_description = NULL WHERE id = 8;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 1, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/NP_11.1.1.jpg', secondary_description = NULL WHERE id = 9;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 2, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/9.1.2.jpg', secondary_description = NULL WHERE id = 10;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 4, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/10.1.2.jpg', secondary_description = NULL WHERE id = 12;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 3, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/RP_11.1.2.jpg', secondary_description = NULL WHERE id = 13;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 2, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/9.1.3.jpg', secondary_description = NULL WHERE id = 14;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 5, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/12.1.1.jpg', secondary_description = NULL WHERE id = 15;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 1, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/NP_11.1.2.jpg', secondary_description = NULL WHERE id = 16;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 4, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/10.1.3.jpg', secondary_description = NULL WHERE id = 17;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 5, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/12.1.2.jpg', secondary_description = NULL WHERE id = 18;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 3, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/RP_11.1.3.jpg', secondary_description = NULL WHERE id = 19;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 2, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/9.1.4.jpg', secondary_description = NULL WHERE id = 21;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 4, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/10.1.4.jpg', secondary_description = NULL WHERE id = 22;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 12, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/RP_11.2.1.jpg', secondary_description = NULL WHERE id = 23;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 1, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/NP_11.1.3.jpg', secondary_description = NULL WHERE id = 24;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 5, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/12.1.3.jpg', secondary_description = NULL WHERE id = 25;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 1, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/NP_11.1.4.jpg', secondary_description = NULL WHERE id = 26;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 5, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/12.1.4.jpg', secondary_description = NULL WHERE id = 27;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 13, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/12.2.1.jpg', secondary_description = NULL WHERE id = 28;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 2, curriculum_number = 5, featured_image = '/new_platform/static/canvas/images/9.1.5.jpg', secondary_description = NULL WHERE id = 29;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 12, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/RP_11.2.2.jpg', secondary_description = NULL WHERE id = 30;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 13, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/12.2.2.jpg', secondary_description = NULL WHERE id = 31;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 13, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/12.2.3.jpg', secondary_description = NULL WHERE id = 32;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 13, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/12.2.4.jpg', secondary_description = NULL WHERE id = 33;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 2, curriculum_number = 6, featured_image = '/new_platform/static/canvas/images/9.1.6.jpg', secondary_description = NULL WHERE id = 34;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 2, curriculum_number = 7, featured_image = '/new_platform/static/canvas/images/9.1.7.jpg', secondary_description = NULL WHERE id = 35;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 12, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/RP_11.2.3.jpg', secondary_description = NULL WHERE id = 36;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 11, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/NP_11.2.1.jpg', secondary_description = NULL WHERE id = 37;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 11, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/NP_11.2.2.jpg', secondary_description = NULL WHERE id = 38;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 11, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/NP_11.2.3.jpg', secondary_description = NULL WHERE id = 39;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 11, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/NP_11.2.4.jpg', secondary_description = NULL WHERE id = 40;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 12, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/RP_11.2.4.jpg', secondary_description = NULL WHERE id = 41;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 9, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/9.2.1.jpg', secondary_description = NULL WHERE id = 42;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 9, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/9.2.2.jpg', secondary_description = NULL WHERE id = 43;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 9, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/9.2.3.jpg', secondary_description = NULL WHERE id = 44;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 9, curriculum_number = 4, featured_image = '/new_platform/static/canvas/images/9.2.4.jpg', secondary_description = NULL WHERE id = 45;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 10, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/10.2.1.jpg', secondary_description = NULL WHERE id = 46;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 10, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/10.2.2.jpg', secondary_description = NULL WHERE id = 47;
UPDATE canvas_curriculum SET canvas_type = 3, unit_id = 10, curriculum_number = 3, featured_image = '/new_platform/static/canvas/images/10.2.3.jpg', secondary_description = NULL WHERE id = 48;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 7, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/11.3.1.jpg', secondary_description = NULL WHERE id = 50;
UPDATE canvas_curriculum SET canvas_type = 1, unit_id = 7, curriculum_number = 2, featured_image = '/new_platform/static/canvas/images/11.3.2.jpg', secondary_description = NULL WHERE id = 51;
UPDATE canvas_curriculum SET canvas_type = 2, unit_id = 8, curriculum_number = 1, featured_image = '/new_platform/static/canvas/images/10.3.1.jpg', secondary_description = NULL WHERE id = 52;

--Master Lesson Copies

UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 2, curriculum_number = 1 WHERE parent_id = 6;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 4, curriculum_number = 1 WHERE parent_id = 7;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 3, curriculum_number = 1 WHERE parent_id = 8;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 1, curriculum_number = 1 WHERE parent_id = 9;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 2, curriculum_number = 2 WHERE parent_id = 10;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 4, curriculum_number = 2 WHERE parent_id = 12;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 3, curriculum_number = 2 WHERE parent_id = 13;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 2, curriculum_number = 3 WHERE parent_id = 14;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 5, curriculum_number = 1 WHERE parent_id = 15;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 1, curriculum_number = 2 WHERE parent_id = 16;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 4, curriculum_number = 3 WHERE parent_id = 17;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 5, curriculum_number = 2 WHERE parent_id = 18;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 3, curriculum_number = 3 WHERE parent_id = 19;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 2, curriculum_number = 4 WHERE parent_id = 21;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 4, curriculum_number = 4 WHERE parent_id = 22;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 12, curriculum_number = 1 WHERE parent_id = 23;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 1, curriculum_number = 3 WHERE parent_id = 24;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 5, curriculum_number = 3 WHERE parent_id = 25;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 1, curriculum_number = 4 WHERE parent_id = 26;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 5, curriculum_number = 4 WHERE parent_id = 27;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 13, curriculum_number = 1 WHERE parent_id = 28;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 2, curriculum_number = 5 WHERE parent_id = 29;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 12, curriculum_number = 2 WHERE parent_id = 30;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 13, curriculum_number = 2 WHERE parent_id = 31;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 13, curriculum_number = 3 WHERE parent_id = 32;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 13, curriculum_number = 4 WHERE parent_id = 33;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 2, curriculum_number = 6 WHERE parent_id = 34;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 2, curriculum_number = 7 WHERE parent_id = 35;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 12, curriculum_number = 3 WHERE parent_id = 36;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 11, curriculum_number = 1 WHERE parent_id = 37;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 11, curriculum_number = 2 WHERE parent_id = 38;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 11, curriculum_number = 3 WHERE parent_id = 39;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 11, curriculum_number = 4 WHERE parent_id = 40;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 12, curriculum_number = 4 WHERE parent_id = 41;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 9, curriculum_number = 1 WHERE parent_id = 42;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 9, curriculum_number = 2 WHERE parent_id = 43;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 9, curriculum_number = 3 WHERE parent_id = 44;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 9, curriculum_number = 4 WHERE parent_id = 45;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 10, curriculum_number = 1 WHERE parent_id = 46;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 10, curriculum_number = 2 WHERE parent_id = 47;
UPDATE canvas_curriculum_copy SET canvas_type = 3, unit_id = 10, curriculum_number = 3 WHERE parent_id = 48;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 7, curriculum_number = 1 WHERE parent_id = 50;
UPDATE canvas_curriculum_copy SET canvas_type = 1, unit_id = 7, curriculum_number = 2 WHERE parent_id = 51;
UPDATE canvas_curriculum_copy SET canvas_type = 2, unit_id = 8, curriculum_number = 1 WHERE parent_id = 52;

/*
select * from canvas_curriculum_copy where persona_id in (select persona_id from iuser_persona_partners where partner_id = 2142);
*/