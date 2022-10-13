--We're updating the schedules and sessions.

--2134, 2018 ABHS Monday, "Best and Worst of Summer"

UPDATE partners_session
SET start = '2015-07-06 14:00:00-04', end_date = '2015-08-12 03:59:00-04'
WHERE id = 36326;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36326
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2134 AND send_date BETWEEN '2015-07-06 14:00:00-04' AND '2015-08-12 03:59:00-04');
--13 rows.

--2134, 2018 ABHS Monday, "About Us" (11th grade)

UPDATE partners_session
SET start = '2015-08-12 03:59:01-04', end_date = '2015-08-12 03:59:59-04'
WHERE id = 36630;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36630
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2134 AND send_date BETWEEN '2015-08-12 03:59:01-04' AND '2015-08-12 03:59:59-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-12 03:59:01-04', end_datetime = '2015-08-12 03:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--6 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-12 03:59:01-04', end_datetime = '2015-08-12 03:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND cc.parent_id = 13
);
--10 rows.

--2134, 2018 ABHS Monday, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-08-12 04:00:00-04', end_date = '2015-09-10 18:59:59-04'
WHERE id = 36460;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36460
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2134 AND send_date BETWEEN '2015-08-12 04:00:00-04' AND '2015-09-10 18:59:59-04');
--136 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-12 04:00:00-04', end_datetime = '2015-09-10 18:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--94 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-12 04:00:00-04', end_datetime = '2015-09-10 18:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND cc.parent_id = 7
);
--94 rows.

--2134, 2018 ABHS Monday, "Survey"

UPDATE partners_session
SET start = '2015-09-10 19:00:00-04', end_date = '2015-09-18 17:59:59-04'
WHERE id = 36379;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36379
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2134 AND send_date BETWEEN '2015-09-10 19:00:00-04' AND '2015-09-18 17:59:59-04');
--51 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--94 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-10 19:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND cc.parent_id = 12
);
--94 rows.

--2134, 2018 ABHS Monday, "About Us" (10th grade)

UPDATE partners_session
SET start = '2015-09-18 18:00:00-04', end_date = '2016-02-18 18:00:00-04'
WHERE id = 36532;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36532
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2134 AND send_date BETWEEN '2015-09-18 18:00:00-04' AND '2016-02-18 18:00:00-04');
--21 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2016-02-18 18:00:00-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (33,34,35)
);
--94 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2016-02-18 18:00:00-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2134)
	AND cc.parent_id = 17
);
--94 rows.

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

select * from partners_session where partner_id = 2134 order by start desc limit 15;

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
select id, name from partners_partner where name ilike '%ABHS%';
select * from canvas_curriculum where id = 21
*/