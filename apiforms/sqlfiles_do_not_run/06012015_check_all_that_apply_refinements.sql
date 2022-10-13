--The UPDATE statements below aren't entirely efficient, but they do get the wording of multi-select questions to a consistent place.

UPDATE forms_section_question
SET question_text = 'Which of the following transit options are most convenient for you?'
WHERE id = 26;

UPDATE forms_section_question_copy
SET question_text = 'Which of the following transit options are most convenient for you?'
WHERE parent_id = 26;

UPDATE forms_section_question
SET question_text = 'Who do you currently live with?'
WHERE id = 1890;

UPDATE forms_section_question_copy
SET question_text = 'Who do you currently live with?'
WHERE parent_id = 1890;

UPDATE forms_section_question
SET question_text = question_text || ' (Check all that apply)'
WHERE question_type = 7 AND question_text NOT ILIKE '%check all that apply%';

UPDATE forms_section_question_copy
SET question_text = question_text || ' (Check all that apply)'
WHERE question_type = 7 AND question_text NOT ILIKE '%check all that apply%';

UPDATE forms_section_question
SET question_text = LEFT(question_text, CHAR_LENGTH(question_text) - 22)
WHERE question_type IN (18,19,20,21) AND question_text ILIKE '%check all that apply.';

UPDATE forms_section_question_copy
SET question_text = LEFT(question_text, CHAR_LENGTH(question_text) - 22)
WHERE question_type IN (18,19,20,21) AND question_text ILIKE '%check all that apply.';

UPDATE forms_section_question
SET question_text = LEFT(question_text, CHAR_LENGTH(question_text) - 21)
WHERE question_type IN (18,19,20,21) AND question_text ILIKE '%check all that apply';

UPDATE forms_section_question_copy
SET question_text = LEFT(question_text, CHAR_LENGTH(question_text) - 21)
WHERE question_type IN (18,19,20,21) AND question_text ILIKE '%check all that apply';

UPDATE forms_section_question
SET question_text = question_text || ' (Check all that apply)'
WHERE question_type IN (18,19,20,21) AND question_text NOT ILIKE '%check all that apply%';

UPDATE forms_section_question_copy
SET question_text = question_text || ' (Check all that apply)'
WHERE question_type IN (18,19,20,21) AND question_text NOT ILIKE '%check all that apply%';