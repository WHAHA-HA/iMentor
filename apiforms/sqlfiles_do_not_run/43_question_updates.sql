UPDATE forms_section_question
SET is_active = FALSE
WHERE question_type = 15
	AND question_text = 'Contact Information';