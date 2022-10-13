--Update the default dates of this old lesson

UPDATE canvas_curriculum
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE id = 4;

UPDATE canvas_set
SET start_datetime = '5/15/15 00:00:00', end_datetime = '5/15/15 23:59:59'
WHERE id IN (7,8,9);