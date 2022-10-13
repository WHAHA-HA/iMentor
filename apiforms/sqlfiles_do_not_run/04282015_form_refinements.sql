--Update the master questions to remove curly quotes that caused crashes

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "My happiest time..."'
WHERE id = 1910;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "My proudest moment..."'
WHERE id = 1911;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "I would like to be better at..."'
WHERE id = 1912;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "One would describe me as..."'
WHERE id = 1913;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "I am best when..."'
WHERE id = 1914;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "I am concerned about..."'
WHERE id = 1915;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: "My most challenging experience was..."'
WHERE id = 1916;

--Update the copy questions as well

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "My happiest time..."'
WHERE parent_id = 1910;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "My proudest moment..."'
WHERE parent_id = 1911;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "I would like to be better at..."'
WHERE parent_id = 1912;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "One would describe me as..."'
WHERE parent_id = 1913;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "I am best when..."'
WHERE parent_id = 1914;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "I am concerned about..."'
WHERE parent_id = 1915;

UPDATE forms_section_question_copy
SET question_text = 'Complete the sentence: "My most challenging experience was..."'
WHERE parent_id = 1916;

--Make refinements to questions types

UPDATE forms_section_question
SET question_type = 7
WHERE id = 1888;

UPDATE forms_section_question
SET question_type = 7
WHERE id = 1890;

--Finally, update ordinals to allow the insertion of new questions, then insert one new conditional question

UPDATE forms_section_question
SET ordinal = ordinal * 100;

UPDATE forms_section_question
SET sub_ordinal = sub_ordinal * 100;

UPDATE forms_section
SET ordinal = ordinal * 100;

UPDATE forms_section_answer
SET ordinal = ordinal * 100;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (1936, NULL, 0, TRUE, FALSE, TRUE, 32, NULL, NULL, NULL, 2, 350, 0, 16, E'As a college-success focused organization, we''ve found mentees benefit most from working with someone who has been through the process of graduating high school, completing a 2- or 4-year degree and transitioning to a career. Therefore, we ask all applicants to hold a minimum of a 2- or 4-year degree.');

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (200, 1936, 'OR', 44, NULL);