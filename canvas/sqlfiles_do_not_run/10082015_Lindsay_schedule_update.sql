--We're updating the schedules and sessions.

--2143, CHS'17LatinosinAction, "Teamwork Makes the Dreamwork"

UPDATE canvas_set_copy
SET start_datetime = '2015-09-24 18:00:00', end_datetime = '2015-10-08 16:29:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2143)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (70,71,72)
);
--81 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-24 18:00:00', end_datetime = '2015-10-08 16:29:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2143)
	AND cc.parent_id = 30
);
--81 rows.

--Update the lessons specifically for Lindsay as well

UPDATE canvas_curriculum_copy
SET end_datetime = '10/1/15 00:00:01'
WHERE id = 7402;

UPDATE canvas_curriculum_copy
SET end_datetime = '10/7/15 15:30:00'
WHERE id = 26498;

UPDATE canvas_set_copy
SET end_datetime = '10/1/15 00:00:01'
WHERE id = 7264;

UPDATE canvas_set_copy
SET end_datetime = '10/7/15 15:30:00'
WHERE id = 25961;

/*
select distinct
	partner_id
from partners_session
where partner_id in (
select
	id
from partners_partner
where start::date >= '8/17/15'
	and member_id = 195
	and status_id = 1
	and is_alumni = false
)
order by partner_id asc;

select * from partners_session where partner_id = 2143 order by start desc limit 15;

select
	ps.id,
	ps.partner_id,
	ps.description,
	ps.start,
	ps.end_date,
	cs.curriculum_id,
	cs.id,
	cs.role
from partners_session as ps
join partners_session_curriculum as psc on psc.p_session_id = ps.id
join canvas_set as cs on cs.curriculum_id = psc.curr_id
where ps.partner_id = 2143
	and ps.start::date >= '8/1/15'
order by
	ps.start,
	cs.curriculum_id,
	cs.id,
	cs.role;

SELECT
	*
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2143)
	--order by user_id, parent_id
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (70,71,72);

SELECT
	*
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2143)
	AND cc.parent_id = 12;

select * from reporting_allmatchemail WHERE partner_id = 2150 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59';
select * from reporting_allmatchemail where sess_id = 36556;

select email from iuser_user where id = 165154
select * from canvas_set_copy where user_id = 170096
select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436
select * from partners_session where partner_id in (2122,2123,2124)
select * from canvas_set where id = 14
select id, name from partners_partner where name ilike '%2017%Wed%';
select * from canvas_curriculum where id = 21
*/