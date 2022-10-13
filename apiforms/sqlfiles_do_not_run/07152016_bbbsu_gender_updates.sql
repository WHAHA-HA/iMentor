begin transaction;

--As per the email request from Alexander on 7/6/16
--First, we update the existing gender questions on the Contact Information sections of the mentor and mentee applications.
--Mentor application

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8401, NULL, 300, 1393, TRUE, 'Neither, I identify as...', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2640, NULL, 0, FALSE, FALSE, TRUE, 1393, NULL, NULL, NULL, 71, 1850, 0, 1, E'Please tell us more about how you identify so we can match you effectively.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (322, 2640, 'OR', 8401, NULL);

--Mentee application

UPDATE forms_section_question
SET question_type = 6
WHERE id = 1478;

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8402, NULL, 300, 1478, TRUE, 'Neither, I identify as...', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2641, NULL, 0, FALSE, FALSE, TRUE, 1478, NULL, NULL, NULL, 75, 1450, 0, 1, E'Please tell us more about how you identify so we can match you effectively.', TRUE);
INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (323, 2641, 'OR', 8402, NULL);

--Next, we update the Evaluation sections of the mentor and mentee applications.
--Mentor application

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2642, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 72, 50, 0, 6, E'How would you describe your sexual orientation?', TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8403, NULL, 100, 2642, TRUE, 'Straight', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8404, NULL, 200, 2642, TRUE, 'Gay', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8405, NULL, 300, 2642, TRUE, 'Lesbian', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8406, NULL, 400, 2642, TRUE, 'Bi-Sexual', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8407, NULL, 500, 2642, TRUE, 'Questioning', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8408, NULL, 600, 2642, TRUE, 'Other/Not Listed', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8409, NULL, 700, 2642, TRUE, 'Prefer not to answer', NULL, NULL, NULL, NULL, FALSE, TRUE);

--Mentee application

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2643, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 76, 50, 0, 6, E'How would you describe your sexual orientation?', TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8410, NULL, 100, 2643, TRUE, 'Straight', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8411, NULL, 200, 2643, TRUE, 'Gay', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8412, NULL, 300, 2643, TRUE, 'Lesbian', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8413, NULL, 400, 2643, TRUE, 'Bi-Sexual', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8414, NULL, 500, 2643, TRUE, 'Questioning', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8415, NULL, 600, 2643, TRUE, 'Other/Not Listed', NULL, NULL, NULL, NULL, FALSE, TRUE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query, is_active)
VALUES (8416, NULL, 700, 2643, TRUE, 'Prefer not to answer', NULL, NULL, NULL, NULL, FALSE, TRUE);

/*
select * from forms_section_question where id between 1940 and 1943
select * from forms_section_answer where question_id between 1940 and 1943
select * from forms_answer_dependency where question_id between 1940 and 1943
select * from forms_section_question where section_id = 1 and is_active = true order by ordinal, sub_ordinal
*/