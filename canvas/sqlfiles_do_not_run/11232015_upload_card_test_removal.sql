--Remove the test lesson for upload cards

begin transaction;

UPDATE canvas_curriculum
SET grade_id = NULL, unit_id = NULL, member_id = NULL, curriculum_number = NULL
WHERE id = 96;

/*
select * from canvas_curriculum where curriculum_number = 999
select * from canvas_curriculum where curriculum_number is null
*/