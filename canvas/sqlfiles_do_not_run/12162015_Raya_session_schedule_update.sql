--We're updating the schedules and sessions.

--2158, BASE '18 Class 2

begin transaction;

DELETE from reporting_matchcompletesession * WHERE session_id = 39382;
--0 rows. 0 affected.

DELETE from partners_session_curriculum * WHERE id = 3042;
--1 row. 1 affected.

DELETE from partners_session * WHERE id = 39382;
--1 row. 1 affected.

UPDATE partners_session
SET start = '2015-12-10 16:03:00', end_date = '2015-12-16 16:04:59'
WHERE id = 39215;
--1 row. 1 affected.

/*
select id, name from partners_partner where name ilike 'BASE ''18 Class 2%';
select * from partners_session where partner_id = 2158 order by start desc limit 15;

select * from partners_session_curriculum where p_session_id = 39382;
select * from reporting_matchcompletesession where session_id = 39382;

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
where ps.partner_id = 1853
	and ps.start::date >= '8/17/15'
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
WHERE pp.id IN (2150)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (39,40,41);

SELECT
	*
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2150)
	AND cc.parent_id = 14;

select * from reporting_allmatchemail WHERE partner_id = 2150 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59';
select * from reporting_allmatchemail where sess_id = 36556;

select email from iuser_user where id = 170096
select * from canvas_set_copy where user_id = 170096
select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436
select * from partners_session where partner_id in (2122,2123,2124)
select * from canvas_set where id = 14
select * from canvas_curriculum where id = 8
*/