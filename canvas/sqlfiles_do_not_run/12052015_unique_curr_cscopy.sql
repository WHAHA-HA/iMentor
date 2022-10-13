alter table canvas_curriculum_copy add constraint composite_user_currparent_key unique(parent_id,user_id);
alter table canvas_set_copy add constraint composite_user_csparent_key unique(parent_id,user_id);

