begin transaction;

--As per the email request from Alexander on 7/27/16

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2645, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 72, 2150, 0, 2, E'Emergency Contact Name', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2646, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 72, 2160, 0, 2, E'Relationship To You', TRUE);
INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2647, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 72, 2170, 0, 2, E'Emergency Contact Phone Number', TRUE);