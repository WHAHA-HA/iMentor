--Trim trailing spaces for the unit title.

UPDATE canvas_unit_info
SET description = 'Leadership'
WHERE id = 20;

/*
select * from canvas_unit_info where description ilike '%  %'
*/