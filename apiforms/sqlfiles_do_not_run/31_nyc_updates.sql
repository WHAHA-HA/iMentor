UPDATE forms_section_question SET is_active = FALSE WHERE id = 44;
UPDATE forms_section_question SET is_visible = TRUE WHERE id = 44;
UPDATE forms_section_answer
SET is_active = FALSE WHERE question_id = 44;