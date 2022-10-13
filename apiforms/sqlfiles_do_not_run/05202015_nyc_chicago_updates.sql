INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1944, NULL, 0, TRUE, FALSE, TRUE, 30, NULL, NULL, NULL, 2, 150, 0, 1, E'Please list all of the programs you have mentored with in the past:');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (203, 1944, 'OR', 36, NULL);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1945, NULL, 0, TRUE, FALSE, TRUE, 1666, NULL, NULL, NULL, 86, 150, 0, 1, E'Please list all of the programs you have mentored with in the past:');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (204, 1945, 'OR', 5699, NULL);