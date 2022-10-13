--We're updating the schedules and sessions.

--2125, 4 SVA 2018, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-08-16 00:00:01-04', end_date = '2015-08-16 00:00:02-04'
WHERE id = 36402;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36402
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2125 AND send_date BETWEEN '2015-08-16 00:00:01-04' AND '2015-08-16 00:00:02-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-16 00:00:01-04', end_datetime = '2015-08-16 00:00:02-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-16 00:00:01-04', end_datetime = '2015-08-16 00:00:02-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND cc.parent_id = 8
);
--0 rows.

--2125, 4 SVA 2018, "About Us"

UPDATE partners_session
SET start = '2015-08-16 00:00:03-04', end_date = '2015-09-11 00:33:59-04'
WHERE id = 36429;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36429
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2125 AND send_date BETWEEN '2015-08-16 00:00:03-04' AND '2015-09-11 00:33:59-04');
--1 row.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-16 00:00:03-04', end_datetime = '2015-09-11 00:33:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-16 00:00:03-04', end_datetime = '2015-09-11 00:33:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND cc.parent_id = 13
);
--0 rows.

--2125, 4 SVA 2018, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-09-11 00:34:00-04', end_date = '2015-09-18 00:33:59-04'
WHERE id = 36388;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36388
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2125 AND send_date BETWEEN '2015-09-11 00:34:00-04' AND '2015-09-18 00:33:59-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 00:34:00-04', end_datetime = '2015-09-18 00:33:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--9 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 00:34:00-04', end_datetime = '2015-09-18 00:33:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND cc.parent_id = 7
);
--9 rows.

--2125, 4 SVA 2018, "Survey"

UPDATE partners_session
SET start = '2015-09-18 00:34:00-04', end_date = '2016-02-25 00:34:00-04'
WHERE id = 36622;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36622
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2125 AND send_date BETWEEN '2015-09-18 00:34:00-04' AND '2016-02-25 00:34:00-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 00:34:00-04', end_datetime = '2016-02-25 00:34:00-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--9 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 00:34:00-04', end_datetime = '2016-02-25 00:34:00-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2125)
	AND cc.parent_id = 12
);
--9 rows.

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

select * from partners_session where partner_id = 2140 order by start desc limit 15;

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
where ps.partner_id = 2317
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
WHERE pp.id IN (2321)
	order by user_id,parent_id
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24);

SELECT
	*
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2132)
	AND cc.parent_id = 12;

select * from reporting_allmatchemail WHERE partner_id = 2150 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59';
select * from reporting_allmatchemail where sess_id = 36556;

select email from iuser_user where id = 170096
select * from canvas_set_copy where user_id = 170096
select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436
select * from partners_session where partner_id in (2122,2123,2124)
select * from canvas_set where id = 14
select id, name from partners_partner where name ilike '%SVA2%';
select * from canvas_curriculum where id = 21
*/