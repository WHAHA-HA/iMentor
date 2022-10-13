begin transaction;

UPDATE forms_section_question_copy
SET question_type = 7
WHERE id IN (
	select distinct
		fsqc.id
	from forms_section_question_copy as fsqc
	join iuser_user as iu on iu.id = fsqc.user_id
	where fsqc.parent_id = 1949
		and fsqc.question_type != 7
		and iu.status = 'AI'
		and iu.last_modified_date::date >= '4/1/16'
);

/*
select id, status from iuser_user where email = 'crkeise@gmail.com'
select id, question_type, question_text from forms_section_question_copy where user_id = 175995 and parent_id = 1949

select distinct
	iu.id,
	iu.first_name,
	iu.last_name,
	iu.email,
	iu.status,
	fsqc.question_text,
	fsqc.question_type
from forms_section_question_copy as fsqc
join iuser_user as iu on iu.id = fsqc.user_id
where fsqc.parent_id = 1949
	and fsqc.question_type = 7
	and iu.status = 'AI'
	and iu.last_modified_date::date >= '4/1/16'
*/