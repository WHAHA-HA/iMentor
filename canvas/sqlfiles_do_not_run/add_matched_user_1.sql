ALTER TABLE canvas_curriculum add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_curriculum_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_curriculum_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_set add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_set_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_set_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_app add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_app_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_app_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_widget_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_widget_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_widget_content_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_widget_content_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content_response_marker add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_widget_content_response_marker_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_widget_content_response_marker_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_widget_content_marker_reference add column active BOOL NOT NULL DEFAULT True;
ALTER TABLE canvas_widget_content_marker_reference_copy add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_widget_content_marker_reference_copy add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_content_user_response add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_content_user_response add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_content_user_response_history add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_content_user_response_history add column matched_persona_id INTEGER DEFAULT NULL;
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
ALTER TABLE canvas_flagged_lesson add column matched_user_id INTEGER DEFAULT NULL;
ALTER TABLE canvas_flagged_lesson add column matched_persona_id INTEGER DEFAULT NULL;
