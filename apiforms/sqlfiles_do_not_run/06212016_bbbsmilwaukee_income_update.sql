begin transaction;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 1025;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id = 1025;

/*
select is_active, question_text from forms_section_question where id = 1025
select is_active, answer_text from forms_section_answer where question_id = 1025
*/