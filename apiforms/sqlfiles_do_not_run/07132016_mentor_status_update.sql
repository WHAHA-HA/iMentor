begin transaction;

UPDATE iuser_user
SET application_submit_date = NULL, status = 'AI'
WHERE id IN (185217, 186505);

UPDATE forms_form_copy
SET form_was_completed = FALSE, form_was_completed_datetime = NULL
WHERE user_id IN (185217, 186505);

/*
select user_id from iuser_persona where id = 114548
select application_submit_date, status from iuser_user where id IN (185217, 186505)
select * from forms_form_copy where user_id IN (185217, 186505)
*/