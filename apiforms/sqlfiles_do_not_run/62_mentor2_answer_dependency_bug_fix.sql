UPDATE forms_section_question
SET question_text = 'Does your mother/female guardian work?'
WHERE id = 255;

UPDATE forms_section_question
SET dependent_on_question_id = 249
WHERE id = 250;

UPDATE forms_section_question
SET dependent_on_question_id = 252
WHERE id = 253;

UPDATE forms_section_question
SET dependent_on_question_id = 255
WHERE id = 256;

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (197, 250, 'OR', 787, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (198, 253, 'OR', 801, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (199, 256, 'OR', 809, NULL);