UPDATE forms_section_question_copy
SET question_type = 7
WHERE parent_id IN (1888);

UPDATE forms_section_question
SET question_text = 'Who helps you plan for college?'
WHERE id IN (270,699);

UPDATE forms_section_question_copy
SET question_text = 'Who helps you plan for college?'
WHERE parent_id IN (270,699);