UPDATE forms_section_question_copy
SET is_visible = FALSE
WHERE parent_id IN (SELECT id FROM forms_section_question WHERE dependent_on_question_id IS NOT NULL AND is_active = TRUE);