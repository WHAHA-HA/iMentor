alter table forms_section_user_response add constraint composite_q_u_key unique(question_id,user_id);
alter table iuser_user_academic_fields add constraint composite_a_u_key unique(academicfield_id,user_id);
alter table iuser_user_colleges add constraint composite_c_u_key unique(college_id,user_id);
alter table iuser_user_racialgroup add constraint composite_r_u_key unique(racialgroup_id,user_id);
