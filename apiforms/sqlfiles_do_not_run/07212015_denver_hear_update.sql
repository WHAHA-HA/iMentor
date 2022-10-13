UPDATE forms_section_question
SET question_text = 'How did you hear about mentor2.0 Denver? Please give details in the space provided, i.e. the person, website or advertisement.'
WHERE id = 757;

UPDATE forms_section_question_copy
SET question_text = 'How did you hear about mentor2.0 Denver? Please give details in the space provided, i.e. the person, website or advertisement.'
WHERE parent_id = 757;