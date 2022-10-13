begin transaction;

UPDATE forms_section_question
SET question_type = 7
WHERE id = 2104;

/*
select question_type from forms_section_question where id = 2104;
*/