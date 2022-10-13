alter table canvas_curriculum rename column grade to grade_id;
alter table canvas_curriculum rename column unit to unit_id;
alter table canvas_curriculum_copy rename column grade to grade_id;
alter table canvas_curriculum_copy rename column unit to unit_id;
alter table canvas_curriculum add column curriculum_number integer default NULL;
alter table canvas_curriculum_copy add column curriculum_number integer default NULL;
