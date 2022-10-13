--We're updating the NYC mentor application based on these requests: https://docs.google.com/document/d/1XXCLytW3F3s9LgQVhthiABRYnBRl7ncSRg3vnSrzKlk/edit?pref=2&pli=1

begin transaction;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE id IN (
	SELECT
		fsa.id
	FROM forms_section_answer AS fsa
	JOIN forms_section_question AS fsq ON fsq.id = fsa.question_id
	WHERE fsa.is_active = TRUE AND fsq.is_active = FALSE
);

UPDATE forms_section_question
SET question_text = 'In 2016, most of our partner schools will be in the Brooklyn and the Bronx. We try to place mentors at sites that are reasonably convenient. Therefore, please indicate the following. Note: We cannot guarantee a particular borough, subway line, or school site.'
WHERE id = 24;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 25;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id = 25;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2057, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 1, 2250, 0, 6, E'I would prefer to mentor closer to');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6921, NULL, 100, 2057, TRUE, 'My work address', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6922, NULL, 200, 2057, TRUE, 'My home address', NULL, NULL, NULL, NULL, FALSE);

UPDATE forms_section_question
SET is_active = FALSE
WHERE id IN (27, 28, 29);

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id IN (27, 28, 29);

UPDATE forms_section_question
SET is_active = FALSE
WHERE id IN (36, 37, 38);

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id IN (36, 37, 38);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2058, NULL, 0, FALSE, FALSE, TRUE, 35, NULL, NULL, NULL, 2, 650, 0, 7, E'What are the languages (other than English) that you speak comfortably? (Check all that apply)');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6923, NULL, 100, 2058, TRUE, 'Arabic', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6924, NULL, 200, 2058, TRUE, 'Cantonese', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6925, NULL, 300, 2058, TRUE, 'Creole', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6926, NULL, 400, 2058, TRUE, 'French', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6927, NULL, 500, 2058, TRUE, 'German', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6928, NULL, 600, 2058, TRUE, 'Greek', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6929, NULL, 700, 2058, TRUE, 'Hebrew', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6930, NULL, 800, 2058, TRUE, 'Hindi', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6931, NULL, 900, 2058, TRUE, 'Hungarian', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6932, NULL, 1000, 2058, TRUE, 'Italian', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6933, NULL, 1100, 2058, TRUE, 'Japanese', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6934, NULL, 1200, 2058, TRUE, 'Korean', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6935, NULL, 1300, 2058, TRUE, 'Mandarin', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6936, NULL, 1400, 2058, TRUE, 'Persian', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6937, NULL, 1500, 2058, TRUE, 'Polish', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6938, NULL, 1600, 2058, TRUE, 'Portuguese', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6939, NULL, 1700, 2058, TRUE, 'Russian', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6940, NULL, 1800, 2058, TRUE, 'Serbo-Croatian', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6941, NULL, 1900, 2058, TRUE, 'Spanish', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6942, NULL, 2000, 2058, TRUE, 'Tagalog', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6943, NULL, 2100, 2058, TRUE, 'Urdu', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6944, NULL, 2200, 2058, TRUE, 'Vietnamese', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6945, NULL, 2300, 2058, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_answer_dependency (id, question_id, and_or, dependent_on_answer_id_for_question_id, dependent_on_answer_value_for_question_id)
VALUES (228, 2058, 'OR', 51, NULL);

UPDATE forms_section_question
SET is_active = FALSE
WHERE id = 1950;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id = 1950;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2059, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 2, 1000, 0, 6, E'How did you hear about iMentor NYC?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6946, NULL, 100, 2059, TRUE, 'Alumni / University Network', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6947, NULL, 200, 2059, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6948, NULL, 300, 2059, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6949, NULL, 400, 2059, TRUE, 'Facebook', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6950, NULL, 500, 2059, TRUE, 'Family / Friend', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6951, NULL, 600, 2059, TRUE, 'Instagram', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6952, NULL, 700, 2059, TRUE, 'LinkedIn', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6953, NULL, 800, 2059, TRUE, 'Nomination / Mentor Together Email', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6954, NULL, 900, 2059, TRUE, 'Twitter', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6955, NULL, 1000, 2059, TRUE, 'Website (Idealist, NYC Service, etc.)', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6956, NULL, 1100, 2059, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

UPDATE forms_section_question
SET question_text = E'What else do you think we should know in order to find you the best possible match? Please tell us anything we didn''t learn from the previous questions.'
WHERE id = 57;

UPDATE forms_section_question
SET question_text = E'Please use 2-3 sentences to describe your personal definition of emotional abuse.'
WHERE id = 66;

UPDATE forms_section_question
SET question_text = E'Please use 2-3 sentences to describe your personal definition of physical abuse.'
WHERE id = 67;

UPDATE forms_section_question
SET question_text = E'Please use 2-3 sentences to describe your personal definition of sexual abuse.'
WHERE id = 68;

UPDATE forms_section_question
SET question_text = E'To find great mentors for our students, it''s important to learn out about our applicants from the people who know them best. Please provide 3 references who have known you for at least 6 months. References can include friends, colleagues, employers, professors, roommates, et cetera. We will contact your references via email or phone once you submit your application. If you have questions about our how we use references, find out more about our application process <a href="https://learn.imentor.org/help/article/link/frequently-asked-questions-about-the-mentor-application" target="_blank">here</a>.'
WHERE id = 70;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id BETWEEN 71 AND 74;

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id BETWEEN 71 AND 74;

UPDATE forms_section_question
SET is_active = FALSE
WHERE id IN (78, 82, 86);

UPDATE forms_section_answer
SET is_active = FALSE
WHERE question_id IN (78, 82, 86);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2060, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 2100, 0, 6, E'What is your relationship to this person?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6957, NULL, 100, 2060, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6958, NULL, 200, 2060, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6959, NULL, 300, 2060, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6960, NULL, 400, 2060, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6961, NULL, 500, 2060, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6962, NULL, 600, 2060, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2061, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 2500, 0, 6, E'What is your relationship to this person?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6963, NULL, 100, 2061, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6964, NULL, 200, 2061, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6965, NULL, 300, 2061, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6966, NULL, 400, 2061, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6967, NULL, 500, 2061, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6968, NULL, 600, 2061, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2062, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 4, 2900, 0, 6, E'What is your relationship to this person?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6969, NULL, 100, 2062, TRUE, 'Friend', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6970, NULL, 200, 2062, TRUE, 'Coworker', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6971, NULL, 300, 2062, TRUE, 'Employer', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6972, NULL, 400, 2062, TRUE, 'Teacher', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6973, NULL, 500, 2062, TRUE, 'Roommate', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6974, NULL, 600, 2062, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

--We update the ordinals of these questions to ensure a consistent, sensible order in the exports spreadsheet.

UPDATE forms_section_question
SET ordinal = 1010
WHERE id = 1950;

UPDATE forms_section_question
SET ordinal = 1020
WHERE id = 2059;

UPDATE forms_section_question
SET ordinal = 1110
WHERE id = 1951;

UPDATE forms_section_question
SET ordinal = 310
WHERE id = 44;

UPDATE forms_section_question
SET ordinal = 2110
WHERE id = 2060;

UPDATE forms_section_question
SET ordinal = 2510
WHERE id = 2061;

UPDATE forms_section_question
SET ordinal = 2910
WHERE id = 2062;

INSERT into forms_section_question (id, copied_from_id, weighted_val, is_required, is_visible, is_immutable, dependent_on_question_id, dependent_on_noanswer_question_id, if_answered_goto_question, answer_matches_goto_question, section_id, ordinal, sub_ordinal, question_type, question_text)
VALUES (2063, NULL, 0, TRUE, TRUE, TRUE, NULL, NULL, NULL, NULL, 1, 1050, 0, 6, E'Which best describes your living location?');

INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6975, NULL, 100, 2063, TRUE, 'Manhattan', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6976, NULL, 200, 2063, TRUE, 'Brooklyn', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6977, NULL, 300, 2063, TRUE, 'Bronx', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6978, NULL, 400, 2063, TRUE, 'Queens', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6979, NULL, 500, 2063, TRUE, 'Staten Island', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6980, NULL, 600, 2063, TRUE, 'Long Island', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6981, NULL, 700, 2063, TRUE, 'New Jersey', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6982, NULL, 800, 2063, TRUE, 'Westchester', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6983, NULL, 900, 2063, TRUE, 'Connecticut', NULL, NULL, NULL, NULL, FALSE);
INSERT INTO forms_section_answer (id, copied_from_id, ordinal, question_id, is_immutable, answer_text, answer_char, answer_bool, answer_int, answer_datetime, is_from_query)
VALUES (6984, NULL, 1000, 2063, TRUE, 'Other', NULL, NULL, NULL, NULL, FALSE);

/*
select distinct
	fsq1.id, fsq1.section_id, fsq1.ordinal, fsq1.question_text, fsq1.is_active
from forms_section_question as fsq1
join forms_section_question as fsq2 on fsq2.section_id = fsq1.section_id
	and fsq2.ordinal = fsq1.ordinal
	and fsq2.id != fsq1.id
where fsq2.sub_ordinal = 0
	and fsq1.sub_ordinal = 0
order by fsq1.section_id,
	fsq1.ordinal,
	fsq1.id asc;
*/
/*
select * from forms_form_member_site where member_site_id = 1
select * from forms_form where id in (1,2)
select * from forms_section where form_id = 1 order by ordinal asc
select * from forms_section_question where section_id = 2 order by ordinal, sub_ordinal asc
select * from forms_section_answer where question_id = 1950 order by ordinal asc
select max(id)+1 from forms_section_question
select max(id)+1 from forms_section_answer
select max(id)+1 from forms_answer_dependency
select * from forms_section_question where question_text ilike '%language%(check all that apply)'
select * from forms_answer_dependency where question_id = 36
select
	fsa.id
from forms_section_answer as fsa
join forms_section_question as fsq on fsq.id = fsa.question_id
where fsa.is_active = true and fsq.is_active = false

select
	fad.id
from forms_answer_dependency as fad
join forms_section_question as fsq on fsq.id = fad.question_id
where fad.is_active = true and fsq.is_active = false
*/