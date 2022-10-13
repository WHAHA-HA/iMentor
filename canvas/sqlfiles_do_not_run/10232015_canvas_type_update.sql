UPDATE canvas_curriculum
SET canvas_type = 2
WHERE id = 20;
--1 row.

UPDATE canvas_curriculum_copy
SET canvas_type = 2
WHERE parent_id = 20;
--904 rows.