--Add curriculum numbers to complement the existing grade numbers and unit numbers, so that we have 9.1.2 notation for all lessons.

UPDATE canvas_curriculum SET curriculum_number = 1 WHERE id = 6;
UPDATE canvas_curriculum SET curriculum_number = 1 WHERE id = 7;
UPDATE canvas_curriculum SET curriculum_number = 1 WHERE id = 8;
UPDATE canvas_curriculum SET curriculum_number = 1 WHERE id = 9;
UPDATE canvas_curriculum SET curriculum_number = 2 WHERE id = 10;
UPDATE canvas_curriculum SET curriculum_number = 2 WHERE id = 12;
UPDATE canvas_curriculum SET curriculum_number = 2 WHERE id = 13;
UPDATE canvas_curriculum SET curriculum_number = 3 WHERE id = 14;
UPDATE canvas_curriculum SET curriculum_number = 1 WHERE id = 15;
UPDATE canvas_curriculum SET curriculum_number = 2 WHERE id = 16;
UPDATE canvas_curriculum SET curriculum_number = 3 WHERE id = 17;
UPDATE canvas_curriculum SET curriculum_number = 2 WHERE id = 18;
UPDATE canvas_curriculum SET curriculum_number = 3 WHERE id = 19;