--We're updating the schedules and sessions.

--2135, 2018 ABHS Wednesday, "Best and Worst of Summer"

UPDATE partners_session
SET start = '2015-07-06 12:00:00-04', end_date = '2015-08-12 03:59:00-04'
WHERE id = 36328;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36328
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-07-06 12:00:00-04' AND '2015-08-12 03:59:00-04');
--26 rows.

--2135, 2018 ABHS Wednesday, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-08-12 03:59:01-04', end_date = '2015-08-12 03:59:02-04'
WHERE id = 36476;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36476
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-08-12 03:59:01-04' AND '2015-08-12 03:59:02-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-12 03:59:01-04', end_datetime = '2015-08-12 03:59:02-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--3 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-12 03:59:01-04', end_datetime = '2015-08-12 03:59:02-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND cc.parent_id = 8
);
--4 rows.

--2135, 2018 ABHS Wednesday, "About Us" (11th grade)

UPDATE partners_session
SET start = '2015-08-12 03:59:03-04', end_date = '2015-08-12 03:59:59-04'
WHERE id = 36493;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36493
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-08-12 03:59:03-04' AND '2015-08-12 03:59:59-04');
--0 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-12 03:59:03-04', end_datetime = '2015-08-12 03:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--2 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-12 03:59:03-04', end_datetime = '2015-08-12 03:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND cc.parent_id = 13
);
--3 rows.

--2135, 2018 ABHS Wednesday, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-08-12 04:00:00-04', end_date = '2015-09-09 18:59:59-04'
WHERE id = 36482;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36482
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-08-12 04:00:00-04' AND '2015-09-09 18:59:59-04');
--116 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-08-12 04:00:00-04', end_datetime = '2015-09-09 18:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--75 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-12 04:00:00-04', end_datetime = '2015-09-09 18:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND cc.parent_id = 7
);
--75 rows.

--2135, 2018 ABHS Wednesday, "Survey"

UPDATE partners_session
SET start = '2015-09-09 19:00:00-04', end_date = '2015-09-16 18:34:59-04'
WHERE id = 36380;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36380
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-09-09 19:00:00-04' AND '2015-09-16 18:34:59-04');
--35 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-09 19:00:00-04', end_datetime = '2015-09-16 18:34:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--75 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-09 19:00:00-04', end_datetime = '2015-09-16 18:34:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND cc.parent_id = 12
);
--75 rows.

--2135, 2018 ABHS Wednesday, "About Us" (10th grade)

UPDATE partners_session
SET start = '2015-09-16 18:35:00-04', end_date = '2016-02-15 18:35:00-04'
WHERE id = 36533;
--1 row.

UPDATE reporting_allmatchemail
SET sess_id = 36533
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2135 AND send_date BETWEEN '2015-09-16 18:35:00-04' AND '2016-02-15 18:35:00-04');
--16 rows.

UPDATE canvas_set_copy
SET start_datetime = '2015-09-16 18:35:00-04', end_datetime = '2016-02-15 18:35:00-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (33,34,35)
);
--74 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-16 18:35:00-04', end_datetime = '2016-02-15 18:35:00-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2135)
	AND cc.parent_id = 17
);
--74 rows.

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

select * from partners_session where partner_id = 2135 order by start desc limit 15;

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
select id, name from partners_partner where name ilike '%Veritas%';
select * from canvas_curriculum where id = 21
*/