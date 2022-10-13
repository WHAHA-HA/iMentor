UPDATE canvas_curriculum_copy
SET start_datetime = '10/1/15', end_datetime = '10/2/15'
WHERE id IN (32152, 20576, 41055);

/*
select * from canvas_curriculum_copy where user_id = 167340 order by end_datetime asc
select * from canvas_set_copy where user_id = 167340 order by end_datetime asc
*/