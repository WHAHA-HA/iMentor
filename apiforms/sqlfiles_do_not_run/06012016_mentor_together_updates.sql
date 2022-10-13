--NYC Mentor Together

begin transaction;

UPDATE forms_section_question
SET is_active = TRUE
WHERE id BETWEEN 1940 AND 1943;

UPDATE forms_section_question
SET is_required = FALSE
WHERE id = 1943;

UPDATE forms_section_question
SET question_text = 'Mentor Together is our campaign to match mentors with a friend at the same school site. Mentors who participate in Mentor Together will be able to travel to events with someone they know and share the mentoring experience with one another.<p><p><i>Due to the high number of female applicants each year, Mentor Together participants must be either male-male or female-male pairings.</i></p></p>'
WHERE id = 1940;

UPDATE forms_section_answer
SET is_active = TRUE
WHERE id BETWEEN 6719 AND 6720;

--Chicago Mentor Together

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2497, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 85, 2100, 0, 16, E'Mentor Together is our campaign to match mentors with a friend at the same school site. Mentors who participate in Mentor Together will be able to travel to events with someone they know and share the mentoring experience with one another.<p><p><i>Due to the high number of female applicants each year, Mentor Together participants must be either male-male or female-male pairings.</i></p></p>', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2498, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 85, 2200, 0, 5, E'Are you participating in Mentor Together?', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2499, NULL, 0, TRUE, FALSE, TRUE, 2498, NULL, NULL, NULL, 85, 2300, 0, 2, E'Mentor Together Buddy Full Name', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2500, NULL, 0, FALSE, FALSE, TRUE, 2498, NULL, NULL, NULL, 85, 2400, 0, 2, E'Mentor Together Buddy Email', TRUE);

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7938, NULL, 100, 2498, TRUE, 'Yes', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (7939, NULL, 200, 2498, TRUE, 'No', NULL, NULL, NULL, NULL, FALSE, TRUE);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (312, 2499, 'OR', 7938, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (313, 2500, 'OR', 7938, NULL);

--Bay Area Mentor Together

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2546, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 103, 2700, 0, 16, E'Mentor Together is our campaign to match mentors with a friend at the same school site. Mentors who participate in Mentor Together will be able to travel to events with someone they know and share the mentoring experience with one another.<p><p><i>Due to the high number of female applicants each year, Mentor Together participants must be either male-male or female-male pairings.</i></p></p>', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2547, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 103, 2800, 0, 5, E'Are you participating in Mentor Together?', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2548, NULL, 0, TRUE, FALSE, TRUE, 2547, NULL, NULL, NULL, 103, 2900, 0, 2, E'Mentor Together Buddy Full Name', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2549, NULL, 0, FALSE, FALSE, TRUE, 2547, NULL, NULL, NULL, 103, 3000, 0, 2, E'Mentor Together Buddy Email', TRUE);

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8093, NULL, 100, 2547, TRUE, 'Yes', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8094, NULL, 200, 2547, TRUE, 'No', NULL, NULL, NULL, NULL, FALSE, TRUE);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (316, 2548, 'OR', 8093, NULL);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (317, 2549, 'OR', 8093, NULL);

/*
select * from forms_section_question where id between 1940 and 1943
select * from forms_section_answer where question_id between 1940 and 1943
select * from forms_answer_dependency where question_id between 1940 and 1943
select * from forms_section_question where section_id = 1 and is_active = true order by ordinal, sub_ordinal
*/