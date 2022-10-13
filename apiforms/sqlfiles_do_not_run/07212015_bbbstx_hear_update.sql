INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1957, NULL, 0, TRUE, FALSE, TRUE, 901, NULL, NULL, NULL, 44, 2000, 0, 16, E'Which recruiter told you about this program? Choose one and type it into the textbox below:<ul><li>Doug Pearce</li><li>Kime Smith</li><li>Raul Garcia</li><li>Leandra McLennon</li><li>Wendell Hall</li><li>Other</li></ul>');

UPDATE forms_answer_dependency
SET question_id = 1957
WHERE id = 96;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1958, NULL, 0, TRUE, FALSE, TRUE, 901, NULL, NULL, NULL, 44, 2100, 0, 2, E'Recruiter Name');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (209, 1958, 'OR', 3030, NULL);