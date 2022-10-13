UPDATE forms_section_question
SET question_type = 1
WHERE id IN (SELECT id FROM forms_section_question WHERE question_text ILIKE 'Please tell us a little bit about yourself%');