--Remove an extra lesson

UPDATE canvas_curriculum_copy
SET end_datetime = '10/1/15 06:00:01'
WHERE id = 22166;

UPDATE canvas_curriculum_copy
SET end_datetime = '2015-10-06 14:00:01'
WHERE id = 25302;

UPDATE canvas_curriculum_copy
SET end_datetime = '2015-10-16 05:59:59'
WHERE id = 27155;

UPDATE canvas_set_copy
SET end_datetime = '2015-10-06 14:00:01'
WHERE id = 24787;

UPDATE canvas_set_copy
SET end_datetime = '2015-10-16 05:59:59'
WHERE id = 26624;

/*
select * from canvas_curriculum_copy where user_id = 149851
select * from canvas_set_copy where user_id = 149851
select id, match_status from iuser_persona where user_id = 149851
select partner_id from iuser_persona_partners where persona_id = 99842
select id, name from partners_partner where id = 2320
select * from partners_session where partner_id = 2320 order by id desc limit 10
2015-10-06 06:00:00-04
2015-10-16 05:59:59-04
select email from iuser_user where id = 149851
*/