begin transaction;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 2056;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id = 2056;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2340, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 36, 2110, 0, 21, E'We have two mentoring programs in Colorado. Please select your preference.');