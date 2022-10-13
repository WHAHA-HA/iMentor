UPDATE forms_section_answer
SET answer_text = 'Mathematics'
WHERE id IN (SELECT id FROM forms_section_answer WHERE answer_text ILIKE '%math');

UPDATE forms_section_answer
SET answer_text = 'Began college career in community college'
WHERE id IN (SELECT id FROM forms_section_answer WHERE answer_text = 'Began my college career in community college');

UPDATE forms_section_answer
SET answer_text = 'Did not know what to study in college at first'
WHERE id IN (SELECT id FROM forms_section_answer WHERE answer_text = 'Did not know what I wanted to study in college at first');