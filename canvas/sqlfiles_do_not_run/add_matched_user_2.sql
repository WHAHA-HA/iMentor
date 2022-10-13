ALTER TABLE canvas_curriculum_copy ADD CONSTRAINT canvas_curriculum_copy_mui_fk FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_curriculum_copy ADD CONSTRAINT canvas_curriculum_copy_mpi_fk FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_set_copy ADD CONSTRAINT canvas_set_copy_mui_fk FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_set_copy ADD CONSTRAINT canvas_set_copy_mpi_fk FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_app_copy ADD CONSTRAINT canvas_app_copy_mui_fk FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_app_copy ADD CONSTRAINT canvas_app_copy_mpi_fk FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_copy ADD CONSTRAINT canvas_widget_copy_mui_fk FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_widget_copy ADD CONSTRAINT canvas_widget_copy_mpi_fk FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content_copy ADD CONSTRAINT canvas_widget_content_copy_mui_fk FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_widget_content_copy ADD CONSTRAINT canvas_widget_content_copy_mpi_fk FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content_response_marker_copy ADD CONSTRAINT canvas_widget_content_response_marker_mui_copy FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_widget_content_response_marker_copy ADD CONSTRAINT canvas_widget_content_response_marker_mpi_copy FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content_marker_reference_copy ADD CONSTRAINT canvas_widget_content_marker_reference_mui_copy FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_widget_content_marker_reference_copy ADD CONSTRAINT canvas_widget_content_marker_reference_mpi_copy FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_content_user_response ADD CONSTRAINT canvas_content_user_response_mui FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_content_user_response ADD CONSTRAINT canvas_content_user_response_mpi FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_content_user_response_history ADD CONSTRAINT canvas_content_user_response_history_mui FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_content_user_response_history ADD CONSTRAINT canvas_content_user_response_history_mpi FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_flagged_lesson ADD CONSTRAINT canvas_flagged_lesson_mui FOREIGN KEY (matched_user_id) REFERENCES iuser_user(id);
ALTER TABLE canvas_flagged_lesson ADD CONSTRAINT canvas_flagged_lesson_mpi FOREIGN KEY (matched_persona_id) REFERENCES iuser_persona(id);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_curriculum_copy DROP CONSTRAINT composite_user_currparent_key;
alter table canvas_set_copy drop constraint composite_user_csparent_key;
alter table canvas_curriculum_copy add constraint composite_user_currparent_key unique(parent_id,user_id,matched_user_id);
alter table canvas_set_copy add constraint composite_user_csparent_key unique(parent_id,user_id,matched_user_id);

