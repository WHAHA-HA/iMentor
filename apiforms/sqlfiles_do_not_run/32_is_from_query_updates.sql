UPDATE forms_section_answer
SET is_active = FALSE
WHERE id IN (SELECT id FROM forms_section_answer WHERE is_from_query = TRUE);