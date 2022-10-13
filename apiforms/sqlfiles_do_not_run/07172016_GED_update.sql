begin transaction;

UPDATE forms_section_answer
SET answer_text = 'Received a GED'
WHERE answer_text = 'Finished high school';
--3 rows. 3 affected.

UPDATE forms_section_answer_copy
SET answer_text = 'Received a GED'
WHERE answer_text = 'Finished high school';
--0 rows. 0 affected.

/*
select * from forms_section_answer where answer_text = 'Finished high school'
select * from forms_section_answer_copy where answer_text = 'Finished high school'
*/