/*
select * from canvas_set_copy where user_id = 172185;
*/

--Update for lesson 9.1.1 in preparation for 9.1.2
--This update was necessary for Beata Jedynasty at BBBS WG, who doesn't begin 9.1.2 until 9/8.

UPDATE canvas_curriculum_copy
SET end_datetime = '9/7/15 23:59:59'
WHERE parent_id = 6
	AND user_id IN (
171951
);

UPDATE canvas_set_copy
SET end_datetime = '9/7/15 23:59:59'
WHERE parent_id IN (12)
	AND user_id IN (
171951
);

UPDATE canvas_curriculum_copy
SET start_datetime = '9/8/15 00:00:00'
WHERE parent_id = 10
	AND user_id IN (
171951
);

UPDATE canvas_set_copy
SET start_datetime = '9/8/15 00:00:00'
WHERE parent_id IN (20)
	AND user_id IN (
171951
);