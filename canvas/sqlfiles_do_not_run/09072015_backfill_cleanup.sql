--The following DELETE statements remove all legacy data for a given email ID.
DELETE FROM reporting_allmatchsessions * WHERE session_id IN (SELECT sess_id FROM reporting_allmatchemail WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15'));
DELETE FROM reporting_allmatchemail * WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15');
DELETE FROM reporting_emaillog_recipients * WHERE emaillog_id IN (SELECT id FROM reporting_emaillog WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15'));
DELETE FROM reporting_emaillog_partners * WHERE emaillog_id IN (SELECT id FROM reporting_emaillog WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15'));
DELETE FROM reporting_emaillog * WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15');
DELETE FROM message_emailrecipient * WHERE email_id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15');
DELETE FROM message_email * WHERE id IN (SELECT id FROM message_email WHERE subject IN (SELECT DISTINCT description FROM canvas_curriculum_copy) AND send_date::DATE > '8/1/15');

--The following DELETE statements remove all legacy data for our lessons, which began after record 5914 and all belong to the Canvas.
--We can run these DELETE statements, after we remove all legacy email data above.
DELETE FROM partners_session_curriculum *;
DELETE FROM partners_session * WHERE prompt_id IN (SELECT id FROM curriculum_prompt WHERE description IN (SELECT DISTINCT description FROM canvas_curriculum_copy));
DELETE FROM curriculum_curriculumprompt * WHERE prompt_id IN (SELECT id FROM curriculum_prompt WHERE description IN (SELECT DISTINCT description FROM canvas_curriculum_copy));
DELETE FROM curriculum_prompt * WHERE id IN (SELECT id FROM curriculum_prompt WHERE description IN (SELECT DISTINCT description FROM canvas_curriculum_copy));

--We now update the sequences, where available, since deletions disrupt them.
SELECT SETVAL('reporting_allmatchemail_id_seq', (SELECT MAX(id) FROM reporting_allmatchemail));
SELECT SETVAL('reporting_emaillog_recipients_id_seq', (SELECT MAX(id) FROM reporting_emaillog_recipients));
SELECT SETVAL('reporting_emaillog_partners_id_seq', (SELECT MAX(id) FROM reporting_emaillog_partners));
SELECT SETVAL('reporting_emaillog_id_seq', (SELECT MAX(id) FROM reporting_emaillog));
SELECT SETVAL('message_emailrecipient_id_seq', (SELECT MAX(id) FROM message_emailrecipient));
SELECT SETVAL('message_email_id_seq', (SELECT MAX(id) FROM message_email));

SELECT SETVAL('partners_session_curriculum_id_seq', (SELECT MAX(id) FROM partners_session_curriculum));
SELECT SETVAL('partners_session_id_seq', (SELECT MAX(id) FROM partners_session));
SELECT SETVAL('curriculum_curriculumprompt_id_seq', (SELECT MAX(id) FROM curriculum_curriculumprompt));
SELECT SETVAL('curriculum_prompt_id_seq', (SELECT MAX(id) FROM curriculum_prompt));