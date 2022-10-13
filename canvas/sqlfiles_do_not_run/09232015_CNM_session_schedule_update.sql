--We're updating the schedules and sessions of CNM.

--1805

UPDATE partners_session
SET start = '2015-09-10 19:00:00-04', end_date = '2015-09-16 12:59:59-04'
WHERE id = 36413;

UPDATE reporting_allmatchemail
SET sess_id = 36413
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1805 AND send_date BETWEEN '2015-09-10 19:00:00-04' AND '2015-09-16 12:59:59-04');
--18 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-16 12:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1805)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (29,40,41)
);
--43 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-16 12:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1805)
	AND cc.parent_id = 19
);
--45 rows.

UPDATE partners_session
SET start = '2015-09-10 19:00:00-04', end_date = '2015-09-16 12:59:59-04'
WHERE id = 36413;

UPDATE reporting_allmatchemail
SET sess_id = 36413
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1805 AND send_date BETWEEN '2015-09-10 19:00:00-04' AND '2015-09-16 12:59:59-04');
--18 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-16 12:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1805)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (29,40,41)
);
--43 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-16 12:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1805)
	AND cc.parent_id = 19
);
--45 rows.

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
where ps.partner_id = 1805
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

select * from reporting_allmatchemail WHERE partner_id = 2150 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59';
select * from reporting_allmatchemail where sess_id = 36556;

select email from iuser_user where id = 170096
select * from canvas_set_copy where user_id = 170096
select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436
select * from partners_session where partner_id in (2122,2123,2124)
select * from canvas_set where id = 14
select id, name from partners_partner where name ilike 'Sheridan%';
*/