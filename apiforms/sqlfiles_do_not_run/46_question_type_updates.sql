UPDATE forms_section_question
SET dependent_on_noanswer_question_id = NULL
WHERE id BETWEEN 169 AND 186;

UPDATE forms_section_question
SET dependent_on_question_id = 168
WHERE id BETWEEN 169 AND 170;

UPDATE forms_section_question
SET question_type = 6
WHERE id = 169;