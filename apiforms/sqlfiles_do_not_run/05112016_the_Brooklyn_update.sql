begin transaction;

UPDATE forms_section_question
SET question_text = 'In 2016, most of our partner schools will be in Brooklyn and the Bronx. We try to place mentors at sites that are reasonably convenient. Therefore, please indicate the following. Note: We cannot guarantee a particular borough, subway line, or school site.'
WHERE id = 24;

/*
select * from forms_section_question where question_text ilike '%the Brooklyn%'
*/