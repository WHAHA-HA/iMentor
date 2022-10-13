INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6738, NULL, 600, 1151, TRUE, 'Other College', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1959, NULL, 0, TRUE, FALSE, TRUE, 1151, NULL, NULL, NULL, 58, 850, 0, 16, E'Please specify the length of study and degree obtained.');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1960, NULL, 0, TRUE, FALSE, TRUE, 1151, NULL, NULL, NULL, 58, 875, 0, 2, E'Length and Degree');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (210, 1959, 'OR', 6738, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (211, 1960, 'OR', 6738, NULL);