UPDATE forms_section_answer
SET answer_text = 'Had friends or family struggle with substance abuse/personally struggled with substance abuse or pressure to use'
WHERE id IN (2680,196,399,635,1014,1269,1466,1719,1922,2182,2400,2883,3134,3396,3638,3838,4077,4280,4519,4715,4963,5157,5418,5617,5844,6038,6309,6654);

UPDATE forms_section_answer_copy
SET answer_text = 'Had friends or family struggle with substance abuse/personally struggled with substance abuse or pressure to use'
WHERE parent_id IN (2680,196,399,635,1014,1269,1466,1719,1922,2182,2400,2883,3134,3396,3638,3838,4077,4280,4519,4715,4963,5157,5418,5617,5844,6038,6309,6654);

UPDATE utils_occupation
SET name = 'Lawyer – Public Defender / Public Interest'
WHERE id = 117;