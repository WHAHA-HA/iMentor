begin transaction;

UPDATE tasks_announcement
SET is_active = TRUE
WHERE id IN (1,2);

/*
select * from tasks_announcement;
*/