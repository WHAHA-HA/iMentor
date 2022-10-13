begin transaction;

UPDATE iuser_user
SET application_submit_date = NULL, status = 'AI'
WHERE id IN (185937);

UPDATE forms_form_copy
SET form_was_completed = FALSE, form_was_completed_datetime = NULL
WHERE user_id IN (185937);

/*
select user_id from iuser_persona where id = 114536
select application_submit_date, status from iuser_user where id IN (186156)
select * from forms_form_copy where user_id IN (186156)
*/