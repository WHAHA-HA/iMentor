INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1940, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 1, 2450, 0, 16, E'Mentor Together is our 2015 campaign to match mentors with a friend at the same school site. Mentors who participate in Mentor Together will be able to travel to events with someone they know and share the mentoring experience with one another.<p><p><i>Due to the high number of female applicants each year, Mentor Together participants must be either male-male or female-male pairings.</i></p></p>');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1941, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 1, 2455, 0, 5, E'Are you participating in Mentor Together?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6719, NULL, 1, 1941, TRUE, 'Yes', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6720, NULL, 2, 1941, TRUE, 'No', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1942, NULL, 0, TRUE, FALSE, TRUE, 1941, NULL, NULL, NULL, 1, 2460, 0, 2, E'Mentor Together Buddy Full Name');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1943, NULL, 0, TRUE, FALSE, TRUE, 1941, NULL, NULL, NULL, 1, 2465, 0, 2, E'Mentor Together Buddy Email');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (201, 1942, 'OR', 6719, NULL);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (202, 1943, 'OR', 6719, NULL);