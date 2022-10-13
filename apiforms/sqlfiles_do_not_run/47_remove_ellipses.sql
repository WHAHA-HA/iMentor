UPDATE forms_section_question
SET question_text = 'Complete the sentence: “My happiest time...”'
WHERE id = 1910;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “My proudest moment...”'
WHERE id = 1911;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “I would like to be better at...”'
WHERE id = 1912;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “One would describe me as...”'
WHERE id = 1913;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “I am best when...”'
WHERE id = 1914;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “I am concerned about...”'
WHERE id = 1915;

UPDATE forms_section_question
SET question_text = 'Complete the sentence: “My most challenging experience was...”'
WHERE id = 1916;

UPDATE forms_section_question
SET question_text = 'More about our programs...<p>College Ready 4-Year Match (recommended): This match begins in the student''s 9th grade year and continues through the 12th grade. We need over 1,000 mentors for our 4-year program in New York City this year. 4-year matches are available in Manhattan, Brooklyn and the Bronx.</p>College Success 3-Year Match: This match begins in the student''s 11th grade year and continues through the first year of college. We need approximately 200 mentors for our 3-year program in New York City this year. 3-year matches are available in Brooklyn only.'
WHERE id = 28;

UPDATE forms_section_answer
SET answer_text = 'Neither, I identify as...'
WHERE id IN (9,5690);