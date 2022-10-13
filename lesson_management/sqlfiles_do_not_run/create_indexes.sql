--We create indexes on the columns relevant to scheduling lessons.

CREATE INDEX partners_session_start_idx ON partners_session (start);
CREATE INDEX partners_session_end_date_idx ON partners_session (end_date);
CREATE INDEX canvas_set_copy_start_datetime_idx ON canvas_set_copy (start_datetime);
CREATE INDEX canvas_set_copy_end_datetime_idx ON canvas_set_copy (end_datetime);
CREATE INDEX canvas_curriculum_copy_start_datetime_idx ON canvas_curriculum_copy (start_datetime);
CREATE INDEX canvas_curriculum_copy_end_datetime_idx ON canvas_curriculum_copy (end_datetime);