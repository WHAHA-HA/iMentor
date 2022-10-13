begin transaction;

UPDATE iuser_user
SET application_submit_date = NULL
WHERE id = 185557;

/*
select application_submit_date from iuser_user where id = 185557
*/