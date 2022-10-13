--This user had a bad persona that caused a crash during the legacy update, so we're clearing the user_completed field and trying again.

begin transaction;

UPDATE canvas_set_copy
SET user_completed = NULL
WHERE id = 125808;

/*
select * from canvas_set_copy where user_id = 5645 order by end_datetime asc
*/