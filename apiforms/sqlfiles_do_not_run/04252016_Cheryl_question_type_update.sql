begin transaction;

UPDATE forms_section_question_copy
SET question_type = 7
WHERE id = 437878;

/*
select id, status from iuser_user where email = 'crkeise@gmail.com'
select id, question_type, question_text from forms_section_question_copy where user_id = 175995 and parent_id = 1949
*/