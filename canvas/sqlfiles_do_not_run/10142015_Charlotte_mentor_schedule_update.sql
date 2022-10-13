UPDATE canvas_curriculum_copy
SET start_datetime = '10/1/15', end_datetime = '10/2/15'
WHERE id = 37148;

UPDATE canvas_curriculum_copy
SET end_datetime = '2016-03-12 10:00:00'
WHERE id = 36516;

UPDATE canvas_set_copy
SET start_datetime = '10/1/15', end_datetime = '10/2/15'
WHERE id = 36304;

UPDATE canvas_set_copy
SET end_datetime = '2016-03-12 10:00:00'
WHERE id = 35692;

/*
select * from canvas_curriculum_copy where user_id = 163323 order by end_datetime asc
select * from canvas_set_copy where user_id = 163323 order by end_datetime asc
select email from iuser_user where id = 163323
*/