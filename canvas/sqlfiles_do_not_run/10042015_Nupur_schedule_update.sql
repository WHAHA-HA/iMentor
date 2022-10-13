--Resolve an issue with Nupur's students

UPDATE canvas_curriculum_copy
SET end_datetime = '2015-09-30 16:00:01'
WHERE id = 15808;

/*
select * from canvas_curriculum_copy where id = 15808;
select * from canvas_curriculum_copy where user_id = 166996;
select email from iuser_user where id = 166996;
*/