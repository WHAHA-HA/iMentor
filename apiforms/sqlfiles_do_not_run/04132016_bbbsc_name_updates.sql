begin transaction;

UPDATE forms_section_question
SET question_text = 'Can mentor2.0 Colorado send you text message reminders to help you complete the application and screening process? We will never share your contact information with third parties.'
WHERE id = 730;

UPDATE forms_section_question
SET question_text = 'How did you hear about mentor2.0 Colorado?'
WHERE id = 757;

UPDATE forms_section_question
SET question_text = 'Who referred you to mentor2.0 Colorado?'
WHERE id = 758;

UPDATE forms_section_answer
SET answer_text = 'Went to high school in Colorado'
WHERE id = 2665;