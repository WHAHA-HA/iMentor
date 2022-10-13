--We create indexes on the columns relevant to the Canvas.

CREATE INDEX canvas_app_canvas_set_id_idx ON canvas_app (canvas_set_id);

CREATE INDEX canvas_app_copy_parent_id_idx ON canvas_app_copy (parent_id);
CREATE INDEX canvas_app_copy_user_id_idx ON canvas_app_copy (user_id);
CREATE INDEX canvas_app_copy_persona_id_idx ON canvas_app_copy (persona_id);
CREATE INDEX canvas_app_copy_canvas_set_id_idx ON canvas_app_copy (canvas_set_id);
CREATE INDEX canvas_app_copy_user_started_idx ON canvas_app_copy (user_started);
CREATE INDEX canvas_app_copy_user_completed_idx ON canvas_app_copy (user_completed);

CREATE INDEX canvas_content_user_response_user_id_idx ON canvas_content_user_response (user_id);
CREATE INDEX canvas_content_user_response_persona_id_idx ON canvas_content_user_response (persona_id);
CREATE INDEX canvas_content_user_response_marker_id_idx ON canvas_content_user_response (marker_id);

CREATE INDEX canvas_curriculum_start_datetime_idx ON canvas_curriculum (start_datetime);
CREATE INDEX canvas_curriculum_end_datetime_idx ON canvas_curriculum (end_datetime);
CREATE INDEX canvas_curriculum_grade_id_idx ON canvas_curriculum (grade_id);
CREATE INDEX canvas_curriculum_unit_id_idx ON canvas_curriculum (unit_id);
CREATE INDEX canvas_curriculum_member_id_idx ON canvas_curriculum (member_id);

CREATE INDEX canvas_curriculum_copy_parent_id_idx ON canvas_curriculum_copy (parent_id);
CREATE INDEX canvas_curriculum_copy_user_id_idx ON canvas_curriculum_copy (user_id);
CREATE INDEX canvas_curriculum_copy_persona_id_idx ON canvas_curriculum_copy (persona_id);
CREATE INDEX canvas_curriculum_copy_grade_id_idx ON canvas_curriculum_copy (grade_id);
CREATE INDEX canvas_curriculum_copy_unit_id_idx ON canvas_curriculum_copy (unit_id);

CREATE INDEX canvas_set_start_datetime_idx ON canvas_set (start_datetime);
CREATE INDEX canvas_set_end_datetime_idx ON canvas_set (end_datetime);
CREATE INDEX canvas_set_curriculum_id_idx ON canvas_set (curriculum_id);
CREATE INDEX canvas_set_created_datetime_idx ON canvas_set (created_datetime);

CREATE INDEX canvas_set_copy_parent_id_idx ON canvas_set_copy (parent_id);
CREATE INDEX canvas_set_copy_user_id_idx ON canvas_set_copy (user_id);
CREATE INDEX canvas_set_copy_persona_id_idx ON canvas_set_copy (persona_id);
CREATE INDEX canvas_set_copy_curriculum_id_idx ON canvas_set_copy (curriculum_id);
CREATE INDEX canvas_set_copy_user_started_idx ON canvas_set_copy (user_started);
CREATE INDEX canvas_set_copy_user_completed_idx ON canvas_set_copy (user_completed);
CREATE INDEX canvas_set_copy_created_datetime_idx ON canvas_set_copy (created_datetime);

CREATE INDEX canvas_widget_canvas_app_id_idx ON canvas_widget (canvas_app_id);

CREATE INDEX canvas_widget_content_widget_id_idx ON canvas_widget_content (widget_id);

CREATE INDEX canvas_widget_content_copy_parent_id_idx ON canvas_widget_content_copy (parent_id);
CREATE INDEX canvas_widget_content_copy_user_id_idx ON canvas_widget_content_copy (user_id);
CREATE INDEX canvas_widget_content_copy_persona_id_idx ON canvas_widget_content_copy (persona_id);
CREATE INDEX canvas_widget_content_copy_widget_id_idx ON canvas_widget_content_copy (widget_id);

CREATE INDEX canvas_widget_content_marker_reference_wc_id_idx ON canvas_widget_content_marker_reference (widget_content_id);
CREATE INDEX canvas_widget_content_marker_reference_om_id_idx ON canvas_widget_content_marker_reference (other_marker_id);

CREATE INDEX canvas_widget_content_marker_reference_copy_pa_id_idx ON canvas_widget_content_marker_reference_copy (parent_id);
CREATE INDEX canvas_widget_content_marker_reference_copy_u_id_idx ON canvas_widget_content_marker_reference_copy (user_id);
CREATE INDEX canvas_widget_content_marker_reference_copy_pe_id_idx ON canvas_widget_content_marker_reference_copy (persona_id);
CREATE INDEX canvas_widget_content_marker_reference_copy_wc_id_idx ON canvas_widget_content_marker_reference_copy (widget_content_id);
CREATE INDEX canvas_widget_content_marker_reference_copy_om_id_idx ON canvas_widget_content_marker_reference_copy (other_marker_id);

CREATE INDEX canvas_widget_content_response_marker_wc_id_idx ON canvas_widget_content_response_marker (widget_content_id);

CREATE INDEX canvas_widget_content_response_marker_copy_pa_id_idx ON canvas_widget_content_response_marker_copy (parent_id);
CREATE INDEX canvas_widget_content_response_marker_copy_u_id_idx ON canvas_widget_content_response_marker_copy (user_id);
CREATE INDEX canvas_widget_content_response_marker_copy_pe_id_idx ON canvas_widget_content_response_marker_copy (persona_id);
CREATE INDEX canvas_widget_content_response_marker_copy_wc_id_idx ON canvas_widget_content_response_marker_copy (widget_content_id);

CREATE INDEX canvas_widget_copy_parent_id_idx ON canvas_widget_copy (parent_id);
CREATE INDEX canvas_widget_copy_user_id_idx ON canvas_widget_copy (user_id);
CREATE INDEX canvas_widget_copy_persona_id_idx ON canvas_widget_copy (persona_id);
CREATE INDEX canvas_widget_copy_canvas_app_id_idx ON canvas_widget_copy (canvas_app_id);