UPDATE forms_section_question
SET dependent_on_question_id = 1399
WHERE id = 1400;

UPDATE forms_section_question
SET dependent_on_question_id = 1411
WHERE id = 1412;

UPDATE forms_section_question
SET dependent_on_question_id = 1415
WHERE id = 1416;

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (194, 1400, 'OR', 4811, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (195, 1412, 'OR', 4847, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id) VALUES (196, 1416, 'OR', 4874, NULL);