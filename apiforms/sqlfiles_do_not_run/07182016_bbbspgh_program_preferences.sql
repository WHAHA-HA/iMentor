--Add program preferences for BBBS Pittsburgh as per the request from Alex on 7/18/16

begin transaction;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text, is_active)
VALUES (2644, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 64, 2100, 0, 21, E'We partner with two high schools in Pittsburgh. Please select the school(s) you prefer to be matched with a mentee in.', TRUE);

/*
select * from forms_section_question where section_id in (64) and is_active = true order by section_id, ordinal, sub_ordinal asc;
*/