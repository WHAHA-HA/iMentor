UPDATE forms_section_question
SET question_type = 18
WHERE id IN (45,120,174,283,348,421,483,557,625,707,774,848,906,983,1037,1109,1163,1237,1289,1361,1421,1494,1556,1631,1680,1755,1816,1923);

UPDATE forms_section_question
SET question_text = 'What other careers are you interested in?'
WHERE id IN (120,283,707,848,1237,1631,1755,421,557,983,1109,1361,1923,1494);