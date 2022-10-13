--Add a question and its answers for the iMentor NYC ad campaign.

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1949, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 2, 1200, 0, 7, E'Where have you seen an iMentor ad? (Check all that apply)');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6721, NULL, 100, 1949, TRUE, 'Facebook', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6722, NULL, 200, 1949, TRUE, 'Movie Theater', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6723, NULL, 300, 1949, TRUE, 'Subway', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6724, NULL, 400, 1949, TRUE, 'TV Ad', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6725, NULL, 500, 1949, TRUE, 'I have not seen an iMentor ad.', NULL, NULL, NULL, NULL, FALSE);

--Below are minor updates to answers whose ordinals were set to 1 and 2 by mistake.

UPDATE forms_section_answer
SET ordinal = 100
WHERE id = 6719;

UPDATE forms_section_answer
SET ordinal = 200
WHERE id = 6720;

UPDATE forms_section_answer_copy
SET ordinal = 100
WHERE parent_id = 6719;

UPDATE forms_section_answer_copy
SET ordinal = 200
WHERE parent_id = 6720;

--Create a new "hear about us" question and its answers, since refining an existing question and its answers isn't possible or desirable.

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1950, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 2, 1000, 0, 6, E'How did you hear about iMentor NYC?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6726, NULL, 100, 1950, TRUE, 'Alumni / University Network', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6727, NULL, 200, 1950, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6728, NULL, 300, 1950, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6729, NULL, 400, 1950, TRUE, 'Facebook', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6730, NULL, 500, 1950, TRUE, 'Family / Friend', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6731, NULL, 600, 1950, TRUE, 'LinkedIn', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6732, NULL, 700, 1950, TRUE, 'Nomination / Mentor Together Email', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6733, NULL, 800, 1950, TRUE, 'Social Media (Twitter, Instagram, etc.)', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6734, NULL, 900, 1950, TRUE, 'Website (Idealist, NYC Service, etc.)', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6735, NULL, 1000, 1950, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1951, NULL, 0, FALSE, TRUE, TRUE, NULL, NULL, NULL, NULL, 2, 1100, 0, 2, E'Who referred you to iMentor NYC?');

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id = 39;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 39;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 40;