--Somehow these values were changed! We're reverting them now.

UPDATE canvas_grade_info
SET description = 'High School Freshman'
WHERE id = 1;

UPDATE canvas_grade_info
SET description = 'High School Sophomore'
WHERE id = 2;

UPDATE canvas_grade_info
SET description = 'High School Junior'
WHERE id = 3;

UPDATE canvas_grade_info
SET description = 'High School Senior'
WHERE id = 4;

UPDATE canvas_grade_info
SET description = 'College Freshman'
WHERE id = 5;

UPDATE canvas_unit_info
SET description = 'Building Relationships - New'
WHERE id = 1;

UPDATE canvas_unit_info
SET description = 'Building Relationships'
WHERE id = 2;

UPDATE canvas_unit_info
SET description = 'Building Relationships - Returning'
WHERE id = 3;