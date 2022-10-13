--Unfinish these lessons as per 3367 on Zendesk

begin transaction;

UPDATE canvas_set_copy
SET user_completed = NULL, user_first_completed = NULL
WHERE id IN (230298, 230314, 230917, 230898);

/*
select user_completed, user_first_completed from canvas_set_copy where user_completed is not null and user_first_completed is not null order by id desc limit 20
select * from canvas_set_copy where id = 230298
select email from iuser_user where id = 157957
*/