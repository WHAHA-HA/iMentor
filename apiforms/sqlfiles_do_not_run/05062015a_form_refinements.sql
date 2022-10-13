UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 75;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 76;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 77;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 78;

UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 79;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 80;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 81;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 82;

UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 83;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 84;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 85;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 86;

--Update questions for existing users to avoid multiple columns in the export

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 75;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 76;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 77;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 78;

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 79;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 80;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 81;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 82;

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 83;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 84;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 85;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 86;

--Insert headings for the three reference sections

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1937, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 1750, 0, 15, E'First Reference');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1938, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 2150, 0, 15, E'Second Reference');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1939, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 2550, 0, 15, E'Third Reference');