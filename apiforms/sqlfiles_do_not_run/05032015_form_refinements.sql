UPDATE forms_section_question
SET question_text = 'As an organization that works with young people, we try to collect all relevant information from applicants before they become mentors. While we will also run a background check, we ask applicants to self-disclose any history of convictions.'
WHERE id IN (SELECT id FROM forms_section_question WHERE question_text = 'As an organization that works with young people, we try to collect all relevant information from applicants before they become mentors. While we will also run a background check, we applicants to self-disclose any history of convictions.');

UPDATE forms_section_user_response
SET user_response = '{"career_id": 2, "occupations": [19]}'
WHERE id = 5747

DELETE FROM utils_occupation * WHERE id = 12;