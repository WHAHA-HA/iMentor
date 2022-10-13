UPDATE forms_section_answer
SET answer_text = 'Portuguese'
WHERE answer_text = 'Portugeuese';
--14 rows. 14 affected.

UPDATE forms_section_answer_copy
SET answer_text = 'Portuguese'
WHERE answer_text = 'Portugeuese';
--6271 rows. TBD affected.

/*
select * from forms_section_answer where answer_text ilike 'portuge%'
select * from forms_section_answer_copy where answer_text ilike 'portuge%'
*/