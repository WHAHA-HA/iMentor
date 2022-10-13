--Update the lesson descriptions

UPDATE canvas_set
SET description = 'Completing My College List'
WHERE id IN (64,65,66);

UPDATE canvas_set_copy
SET description = 'Completing My College List'
WHERE parent_id IN (64,65,66);