-- rgroups
-- Fix existing map and already mapped user values.
update iuser_racialgroup set "group" = 'I identify with a race not listed here' where id=12;
update iuser_racialgroup set "group" = 'I would prefer not to indicate my race' where id=13;
update iuser_user_racialgroup set racialgroup_id = 13 where racialgroup_id=14;
delete from  iuser_racialgroup where id=14;

update forms_section_question set question_type=19 where question_text ilike 'With which race or races do you identify?%';

update forms_section_answer set is_active=false where question_id in (select id from forms_section_question where question_text ilike 'With which race or races do you identify?%');

update forms_section_question_copy set question_type=19 where question_text ilike 'With which race or races do you identify?%';

update forms_section_answer_copy set is_active=false where parent_id in (select id from forms_section_answer where question_id in (select id  from forms_section_question where question_text ilike 'With which race or races do you identify?%'));

-- -----------------------------------------------
-- mprograms
update forms_section_question set question_type=21 where question_text ilike 'Program Preferences%';

update forms_section_answer set is_active=false where question_id in (select id from forms_section_question where question_text ilike 'Program Preferences%');

update forms_section_question_copy set question_type=21 where question_text ilike 'Program Preferences%';

update forms_section_answer_copy set is_active=false where parent_id in (select id from forms_section_answer where question_id in (select id  from forms_section_question where question_text ilike 'Program preferences%'));


