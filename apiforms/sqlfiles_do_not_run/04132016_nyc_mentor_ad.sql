begin transaction;

UPDATE forms_section_question
SET question_type = 7
WHERE id = 1949;

/*
select question_type from forms_section_question where id = 1949;
*/