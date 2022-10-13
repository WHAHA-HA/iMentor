--We create indexes on the columns relevant to the College Checklist.

CREATE INDEX college_checklist_college_id_idx ON college_checklist (college_id);
CREATE INDEX college_checklist_user_id_idx ON college_checklist (user_id);
CREATE INDEX college_checklist_app_deadline_idx ON college_checklist (app_deadline);
CREATE INDEX college_checklist_app_submission_idx ON college_checklist (app_submission);
CREATE INDEX college_checklist_category_id_idx ON college_checklist (category_id);

CREATE INDEX college_count_college_id_idx ON college_count (college_id);

