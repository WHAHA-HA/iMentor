UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id IN (29,883);

UPDATE forms_section_question
SET question_type = 21
WHERE id IN (29,883);