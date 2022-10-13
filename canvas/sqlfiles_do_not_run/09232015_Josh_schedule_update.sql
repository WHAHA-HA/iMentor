--We're updating the schedule as requested.

UPDATE partners_session
SET start = '2015-09-23 16:00:00', end_date = '2015-02-23 15:59:59'
WHERE id = 36689;

UPDATE canvas_set_copy
SET start_datetime = '2015-09-23 16:00:00', end_datetime = '2015-02-23 15:59:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2312)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (28,60)
);
--24 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-23 16:00:00', end_datetime = '2015-02-23 15:59:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2132)
	AND cc.parent_id = 14
);
--0 rows.

/*
select id, name from partners_partner where name ilike 'Sheridan%';
select * from partners_session where partner_id = 2312 order by start desc limit 10;
select * from partners_session where partner_id in (select id from partners_partner where start::date >= '8/17/15' and member_id = 195 and status_id = 1 and is_alumni = false) order by partner_id, start asc;

SELECT
	*
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2312)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (28,60);

SELECT
	*
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2132)
	AND cc.parent_id = 14;

select email from iuser_user where id = 170096
select * from canvas_set_copy where user_id = 170096
select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436
select * from partners_session where partner_id in (2122,2123,2124)
select * from canvas_set where id = 14
*/