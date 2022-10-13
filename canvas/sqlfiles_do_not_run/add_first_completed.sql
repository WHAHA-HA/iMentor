alter table canvas_set_copy add column user_first_completed TIMESTAMP DEFAULT NULL;
update canvas_set_copy set user_first_completed = user_completed;
