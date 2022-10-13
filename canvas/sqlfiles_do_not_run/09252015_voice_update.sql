--Update voice in the descriptions

UPDATE canvas_app
SET description = 'Reconnect with your mentor'
WHERE id = 275;

UPDATE canvas_app_copy
SET description = 'Reconnect with your mentor'
WHERE parent_id = 275;

UPDATE canvas_app
SET description = 'Share with your mentor'
WHERE id = 277;

UPDATE canvas_app_copy
SET description = 'Share with your mentor'
WHERE parent_id = 277;