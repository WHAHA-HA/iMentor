--Refine the BBBS Tennessee mentor application

UPDATE forms_section_question
SET question_text = 'Which recruiter told you about this program?'
WHERE id = 2002;

UPDATE forms_section_answer
SET answer_text = 'Went to high school in Knox County'
WHERE id = 6830;