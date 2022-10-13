--Adjust lessons for Giovianna Burrell

UPDATE canvas_set_copy
SET start_datetime = '8/6/15 00:00:00', end_datetime = '2015-08-13 03:59:59'
WHERE id = 4347;

UPDATE canvas_set_copy
SET start_datetime = '2015-09-10 19:00:00'
WHERE id = 421;

--Adjust a lesson for one student in SVA1 2017 with Giovianna Burrell

UPDATE canvas_set_copy
SET end_datetime = '2016-02-08 16:45:00'
WHERE id = 769;

UPDATE canvas_set_copy
SET start_datetime = '8/6/15 00:00:00', end_datetime = '2015-08-13 03:59:59'
WHERE id = 122;

/*
select * from canvas_set_copy where user_id = 152229
select * from canvas_set_copy where user_id = 150077
*/