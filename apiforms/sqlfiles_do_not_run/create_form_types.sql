alter table forms_form add column form_user_type INTEGER NOT NULL DEFAULT 0;
alter table forms_form_copy add column form_user_type INTEGER NOT NULL DEFAULT 0;
update forms_form set form_user_type = 1 where description ilike '%Mentor%';
update forms_form set form_user_type = 2 where description ilike '%Mentee%';
update forms_form_copy set form_user_type = 1 where description ilike '%Mentor%';
update forms_form_copy set form_user_type = 2 where description ilike '%Mentee%';

alter table forms_form add column form_data_type INTEGER NOT NULL DEFAULT 0;
alter table forms_form_copy add column form_data_type INTEGER NOT NULL DEFAULT 0;
alter table forms_section add column section_data_type INTEGER NOT NULL DEFAULT 0;
alter table forms_section_copy add column section_data_type INTEGER NOT NULL DEFAULT 0;
-- 1 = APPLICATION form and section
update forms_form set form_data_type = 1;
update forms_form_copy set form_data_type = 1;
update forms_section set section_data_type = 1 where ordinal = 1;
update forms_section_copy set section_data_type = 1 where ordinal = 1;
