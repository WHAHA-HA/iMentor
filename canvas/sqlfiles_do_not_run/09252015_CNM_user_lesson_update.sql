--Remove one overlap from a CNM user's lesson as per Zendesk 1799

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 17:00:00', end_datetime = '2015-09-18 17:00:59'
WHERE id = 7706;

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 17:00:00', end_datetime = '2015-09-18 17:00:59'
WHERE id = 7090

