begin transaction;

UPDATE canvas_curriculum
SET canvas_type = 2
WHERE id = 168;

UPDATE canvas_curriculum_copy
SET canvas_type = 2
WHERE parent_id = 168;

/*
select id, description, canvas_type from canvas_curriculum where canvas_type = 1 and curriculum_number = 1
select id, description, canvas_type from canvas_curriculum_copy where canvas_type = 1 and curriculum_number = 1
*/