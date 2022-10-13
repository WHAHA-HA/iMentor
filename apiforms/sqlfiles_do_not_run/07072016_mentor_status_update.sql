begin transaction;

UPDATE iuser_user
SET status = 'AI'
WHERE id = 185557;

UPDATE forms_form_copy
SET form_was_completed = FALSE, form_was_completed_datetime = NULL
WHERE user_id = 185557;

/*
select * from iuser_user where id = 185557 or status = 'AI' and member_id = 248 order by id desc limit 5
select * from iuser_persona where user_id = 185557
select * from forms_form_copy where user_id = 185557
*/