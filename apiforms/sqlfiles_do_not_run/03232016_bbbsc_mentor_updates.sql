begin transaction;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2056, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 36, 2100, 0, 6, E'We have two mentoring programs in Colorado. Please select your preference.');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6919, NULL, 100, 2056, TRUE, 'Denver', NULL, NULL, NULL, NULL, FALSE);

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6920, NULL, 200, 2056, TRUE, 'Colorado Springs', NULL, NULL, NULL, NULL, FALSE);

/*
delete from forms_section_user_response * where answer_id in (select id from forms_section_answer_copy * where parent_id between 6919 and 6920);
delete from forms_section_answer_copy * where parent_id between 6919 and 6920;
delete from forms_section_answer * where id between 6919 and 6920;

delete from forms_section_user_response where question_id in (select id from forms_section_question_copy * where parent_id between 2056 and 2056);
delete from forms_section_question_copy * where parent_id between 2056 and 2056;
delete from forms_section_question * where id between 2056 and 2056;
*/