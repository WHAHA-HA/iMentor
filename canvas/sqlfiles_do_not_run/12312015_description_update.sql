begin transaction;

UPDATE canvas_set
SET description = 'Fighting Senioritis, Dealing with Stress, Finishing Strong'
WHERE id IN (327, 328, 329);

UPDATE canvas_set_copy
SET description = 'Fighting Senioritis, Dealing with Stress, Finishing Strong'
WHERE parent_id IN (327, 328, 329);