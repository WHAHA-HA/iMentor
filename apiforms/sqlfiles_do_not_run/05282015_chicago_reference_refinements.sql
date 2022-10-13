UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 1710;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 1711;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 1712;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 1713;

UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 1714;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 1715;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 1716;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 1717;

UPDATE forms_section_question
SET question_text = 'Full Name'
WHERE id = 1718;

UPDATE forms_section_question
SET question_text = 'Email Address'
WHERE id = 1719;

UPDATE forms_section_question
SET question_text = 'Mobile/Home Phone Number'
WHERE id = 1720;

UPDATE forms_section_question
SET question_text = 'What is your relationship to this person?'
WHERE id = 1721;

--Update questions for existing users to avoid multiple columns in the export

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 1710;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 1711;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 1712;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 1713;

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 1714;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 1715;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 1716;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 1717;

UPDATE forms_section_question_copy
SET question_text = 'Full Name'
WHERE parent_id = 1718;

UPDATE forms_section_question_copy
SET question_text = 'Email Address'
WHERE parent_id = 1719;

UPDATE forms_section_question_copy
SET question_text = 'Mobile/Home Phone Number'
WHERE parent_id = 1720;

UPDATE forms_section_question_copy
SET question_text = 'What is your relationship to this person?'
WHERE parent_id = 1721;

--Insert headings for the three reference sections

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1946, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 88, 1750, 0, 15, E'First Reference');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1947, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 88, 2150, 0, 15, E'Second Reference');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1948, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 88, 2550, 0, 15, E'Third Reference');