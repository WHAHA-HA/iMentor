begin transaction;

UPDATE forms_section_question
SET is_required = TRUE
WHERE id IN (1951, 1676, 2103);

--Bay Area
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2341, NULL, 0, TRUE, FALSE, TRUE, 2138, NULL, NULL, NULL, 106, 2120, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (274, 2341, 'OR', 7186, NULL);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2342, NULL, 0, TRUE, FALSE, TRUE, 2143, NULL, NULL, NULL, 106, 2520, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (275, 2342, 'OR', 7192, NULL);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2343, NULL, 0, TRUE, FALSE, TRUE, 2148, NULL, NULL, NULL, 106, 2920, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (276, 2343, 'OR', 7198, NULL);

--Chicago
UPDATE forms_section_question
SET question_type = 6
WHERE id = 1713;

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7573, NULL, 100, 1713, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7574, NULL, 200, 1713, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7575, NULL, 300, 1713, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7576, NULL, 400, 1713, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7577, NULL, 500, 1713, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7578, NULL, 600, 1713, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE, TRUE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2344, NULL, 0, TRUE, FALSE, TRUE, 1713, NULL, NULL, NULL, 88, 2110, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (277, 2344, 'OR', 7578, NULL);

UPDATE forms_section_question
SET question_type = 6
WHERE id = 1717;

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7579, NULL, 100, 1717, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7580, NULL, 200, 1717, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7581, NULL, 300, 1717, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7582, NULL, 400, 1717, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7583, NULL, 500, 1717, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7584, NULL, 600, 1717, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE, TRUE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2345, NULL, 0, TRUE, FALSE, TRUE, 1717, NULL, NULL, NULL, 88, 2510, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (278, 2345, 'OR', 7584, NULL);

UPDATE forms_section_question
SET question_type = 6
WHERE id = 1721;

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7585, NULL, 100, 1721, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7586, NULL, 200, 1721, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7587, NULL, 300, 1721, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7588, NULL, 400, 1721, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7589, NULL, 500, 1721, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7590, NULL, 600, 1721, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE, TRUE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2346, NULL, 0, TRUE, FALSE, TRUE, 1721, NULL, NULL, NULL, 88, 2910, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (279, 2346, 'OR', 7590, NULL);

--NYC
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2347, NULL, 0, TRUE, FALSE, TRUE, 2060, NULL, NULL, NULL, 4, 2120, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (280, 2347, 'OR', 6962, NULL);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2348, NULL, 0, TRUE, FALSE, TRUE, 2061, NULL, NULL, NULL, 4, 2520, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (281, 2348, 'OR', 6968, NULL);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2349, NULL, 0, TRUE, FALSE, TRUE, 2062, NULL, NULL, NULL, 4, 2920, 0, 2, E'Please describe.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (282, 2349, 'OR', 6974, NULL);

--"Who referred you?" question updates for NYC and Bay Area

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 1951;
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2350, NULL, 0, TRUE, FALSE, TRUE, 2059, NULL, NULL, NULL, 2, 1115, 0, 2, E'Who referred you to iMentor NYC?', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (283, 2350, 'OR', 6947, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (284, 2350, 'OR', 6950, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (285, 2350, 'OR', 6956, NULL);

UPDATE forms_section_question
SET is_visible = FALSE, dependent_on_question_id = 2102
WHERE id = 2103;
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (286, 2103, 'OR', 7074, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (287, 2103, 'OR', 7077, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (288, 2103, 'OR', 7083, NULL);

--Update a few questions on the Chicago mentor application according to the red highlights on https://docs.google.com/document/d/15vw-ayiBuBtjJmkIYo3xh3bclhNuz77hV0JbzI-SlFs/edit?pref=2&pli=1

UPDATE forms_section_question
SET is_active = FALSE
WHERE id BETWEEN 1673 AND 1674;

UPDATE forms_section_question
SET question_text = 'What are the languages (other than English) that you speak comfortably? (Check all that apply)', question_type = 7
WHERE id = 1672;

UPDATE forms_section_question
SET question_text = 'What else do you think we should know in order to find you the best possible match? Please tell us anything we didn''t learn from the previous questions.'
WHERE id = 1692;

--Update one misspelling for NYC

