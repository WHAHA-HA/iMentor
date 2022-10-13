--We resolved a bug today where Canvas data from MAs would not reach the legacy tables.
--Therefore, we're clearing canvas_set_copy.user_completed for the one affected user ID of 162343, then using Masquerade to finish the lesson again for her.

UPDATE canvas_set_copy
SET user_completed = NULL
WHERE id = 2672;