UPDATE forms_section_question
SET question_text = 'In which country were you born?'
WHERE question_text = 'Which country were you born?';

UPDATE forms_section_question_copy
SET question_text = 'In which country were you born?'
WHERE question_text = 'Which country were you born?';