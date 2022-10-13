--Update the stray curriculum records for this mentee at CNM

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-13 00:00:00', end_datetime = '2015-08-13 00:00:59'
WHERE id = 565;

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-13 00:01:00', end_datetime = '2015-08-13 00:01:59'
WHERE id = 1880;

/*
select * from canvas_curriculum_copy where user_id = 164451;
*/