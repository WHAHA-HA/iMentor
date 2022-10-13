UPDATE forms_section_question
SET is_active = FALSE
WHERE id BETWEEN 1940 AND 1943;

/*
select * from forms_form where id = 1
select * from forms_section where form_id = 1
select * from forms_section_question where section_id = 1 order by ordinal asc
*/