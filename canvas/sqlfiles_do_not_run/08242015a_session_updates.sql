--We moved the showcase lesson named "About Me" to the past, so that it wouldn't be the default lesson for users without a scheduled lesson.

UPDATE canvas_curriculum
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE id = 4;

UPDATE canvas_curriculum_copy
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE parent_id = 4;

UPDATE canvas_set
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE id IN (8,9,11);

UPDATE canvas_set_copy
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE parent_id IN (8,9,11);