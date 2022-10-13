--Make refinements to SVA 1, 2, and 3 2018 for Malaka

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 17:00:00', end_datetime = '2016-02-15 17:00:00'
WHERE id = 2021;

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 17:00:00', end_datetime = '2016-02-15 17:00:00'
WHERE id = 2112;