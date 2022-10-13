begin transaction;

UPDATE forms_section_answer
SET answer_text = 'Received a GED'
WHERE answer_text = 'Finished high school';
--30 rows. 30 affected.

begin transaction;

UPDATE forms_section_answer_copy
SET answer_text = 'Received a GED'
WHERE answer_text = 'Finished high school';
--8914 rows. 8914 affected.

/*
select * from forms_section_answer where answer_text = 'Finished high school'
select * from forms_section_answer_copy where answer_text = 'Finished high school'
*/