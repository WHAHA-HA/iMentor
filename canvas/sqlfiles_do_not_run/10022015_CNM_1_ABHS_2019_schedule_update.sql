--We're updating the schedules and sessions.

--2328, 1 ABHS 2019, "About Me"

UPDATE partners_session
SET start = '2015-08-17 00:00:00-04', end_date = '2015-08-17 00:00:01-04'
WHERE id = 36427;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36427
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:00-04' AND '2015-08-17 00:00:01-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:00-04', end_datetime = '2015-08-17 00:00:01-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (7,8,9,11)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:00-04', end_datetime = '2015-08-17 00:00:01-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 4
);
--0 rows.

--2328, 1 ABHS 2019, "About Us"

UPDATE partners_session
SET start = '2015-08-17 00:00:02-04', end_date = '2015-08-17 00:00:03-04'
WHERE id = 36491;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36491
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:02-04' AND '2015-08-17 00:00:03-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:02-04', end_datetime = '2015-08-17 00:00:03-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:02-04', end_datetime = '2015-08-17 00:00:03-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 13
);
--0 rows.

--2328, 1 ABHS 2019, "Survey" (11th grade)

UPDATE partners_session
SET start = '2015-08-17 00:00:04-04', end_date = '2015-08-17 00:00:05-04'
WHERE id = 36366;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36366
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:04-04' AND '2015-08-17 00:00:05-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:04-04', end_datetime = '2015-08-17 00:00:05-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (39,40,41)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:04-04', end_datetime = '2015-08-17 00:00:05-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 19
);
--0 rows.

--2328, 1 ABHS 2019, "Survey" (10th grade)

UPDATE partners_session
SET start = '2015-08-17 00:00:06-04', end_date = '2015-08-17 00:00:07-04'
WHERE id = 36393;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36393
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:06-04' AND '2015-08-17 00:00:07-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:06-04', end_datetime = '2015-08-17 00:00:07-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--2 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:06-04', end_datetime = '2015-08-17 00:00:07-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 12
);
--2 rows.

--2328, 1 ABHS 2019, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-08-17 00:00:08-04', end_date = '2015-08-17 00:00:09-04'
WHERE id = 36461;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36461
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:08-04' AND '2015-08-17 00:00:09-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:08-04', end_datetime = '2015-08-17 00:00:09-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:08-04', end_datetime = '2015-08-17 00:00:09-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 8
);
--0 rows.

--2328, 1 ABHS 2019, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-08-17 00:00:10-04', end_date = '2015-08-17 00:00:11-04'
WHERE id = 36383;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36383
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:10-04' AND '2015-08-17 00:00:11-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:10-04', end_datetime = '2015-08-17 00:00:11-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--2 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:10-04', end_datetime = '2015-08-17 00:00:11-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 7
);
--2 rows.

--2328, 1 ABHS 2019, "Application"

UPDATE partners_session
SET start = '2015-08-17 00:00:12-04', end_date = '2015-09-14 18:54:59-04'
WHERE id = 36472;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36472
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-08-17 00:00:12-04' AND '2015-09-14 18:54:59-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-17 00:00:12-04', end_datetime = '2015-09-14 18:54:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (20)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-17 00:00:12-04', end_datetime = '2015-09-14 18:54:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 10
);
--1 row.

--2328, 1 ABHS 2019, "Survey" (9th grade)

UPDATE partners_session
SET start = '2015-09-14 18:55:00-04', end_date = '2015-09-21 06:59:59-04'
WHERE id = 36561;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36561
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-09-14 18:55:00-04' AND '2015-09-21 06:59:59-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-14 18:55:00-04', end_datetime = '2015-09-21 06:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (28,60)
);
--43 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-14 18:55:00-04', end_datetime = '2015-09-21 06:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 14
);
--43 rows.

--2328, 1 ABHS 2019, "Introduction to iMentor"

UPDATE partners_session
SET start = '2015-09-21 07:00:00-04', end_date = '2016-02-21 07:00:00-04'
WHERE id = 36468;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36468
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2328 AND send_date BETWEEN '2015-09-21 07:00:00-04' AND '2016-02-21 07:00:00-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-21 07:00:00-04', end_datetime = '2016-02-21 07:00:00-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (12)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-21 07:00:00-04', end_datetime = '2016-02-21 07:00:00-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2328)
	AND cc.parent_id = 6
);
--0 rows.

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

select * from partners_session where partner_id = 2328 order by start desc limit 15;

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