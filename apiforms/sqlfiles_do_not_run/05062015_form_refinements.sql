UPDATE forms_section_question
SET question_text = 'Please list the programs in which you have been involved and the years you were involved. (Example: Higher Achievement Program, 2011-2013, For Love of Children''s Tutoring Program, 2011-12).'
WHERE id = 1903;

UPDATE forms_section_question_copy
SET question_text = 'Please list the programs in which you have been involved and the years you were involved. (Example: Higher Achievement Program, 2011-2013, For Love of Children''s Tutoring Program, 2011-12).'
WHERE parent_id = 1903;