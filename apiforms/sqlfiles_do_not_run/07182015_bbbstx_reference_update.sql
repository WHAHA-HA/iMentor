INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1952, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 46, 850, 0, 16, E'Please ensure that all fields are filled out correctly, giving particular attention to contact information for references.');

UPDATE forms_section_question
SET question_text = 'You will be asked to list the names and phone numbers of 2 required references, one personal and one professional. Additional reference(s) required only if you have previous voluntary or paid involvement with a youth organization. If you do not have any additional references, please fill out N/A for Reference #3.'
WHERE id = 927;

UPDATE forms_section_question_copy
SET question_text = 'You will be asked to list the names and phone numbers of 2 required references, one personal and one professional. Additional reference(s) required only if you have previous voluntary or paid involvement with a youth organization. If you do not have any additional references, please fill out N/A for Reference #3.'
WHERE parent_id = 927;

UPDATE forms_section_question
SET question_text = 'Please note that references will be contacted as part of your volunteer screening. We encourage you to let them know that you have listed them and to expect contact from us.'
WHERE id = 928;

UPDATE forms_section_question_copy
SET question_text = 'Please note that references will be contacted as part of your volunteer screening. We encourage you to let them know that you have listed them and to expect contact from us.'
WHERE parent_id = 928;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1953, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 46, 1150, 0, 16, E'Please note that during your personal interview you may be asked for additional references as needed.');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1954, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 46, 1175, 0, 16, E'Your first reference must be your spouse/partner, and if you do not have a spouse/partner, then an immediate family member.');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1955, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 46, 1550, 0, 16, E'Your second reference should be a friend, work colleague, supervisor or school colleague whom you have known for a minimum of two (2) years.');

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1956, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 46, 1950, 0, 16, E'IF YOU HAVE PREVIOUS EXPERIENCE WITH YOUTH (in a paid or volunteer capacity) please list a contact at all organizations you have been involved with in the past five (5) years. If you do not have previous experience, please write N/A.');