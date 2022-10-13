--Remove curriculum overlaps for one student at CNM

UPDATE canvas_curriculum_copy
SET start_datetime = '9/1/15 17:00:00', end_datetime = '9/1/15 17:00:01'
WHERE id = 22017;

UPDATE canvas_curriculum_copy
SET start_datetime = '9/1/15 17:00:02', end_datetime = '9/1/15 17:00:03'
WHERE id = 25303;

/*
select * from canvas_curriculum_copy where user_id = 176164 order by start_datetime asc
*/