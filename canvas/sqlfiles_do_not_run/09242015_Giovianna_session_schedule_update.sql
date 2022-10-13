--We're updating the schedules and sessions.

--1851, SVA 1 2017, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-09-11 00:00:00-04', end_date = '2015-09-11 17:59:59-04'
WHERE id = 36554;

UPDATE reporting_allmatchemail
SET sess_id = 36554
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1851 AND send_date BETWEEN '2015-09-11 00:00:00-04' AND '2015-09-11 17:59:59-04');
--17 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 00:00:00-04', end_datetime = '2015-09-11 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--3 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 00:00:00-04', end_datetime = '2015-09-11 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND cc.parent_id = 7
);
--4 rows.

--1851, SVA 1 2017, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-09-11 18:00:00-04', end_date = '2015-09-18 17:59:59-04'
WHERE id = 36368;

UPDATE reporting_allmatchemail
SET sess_id = 36368
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1851 AND send_date BETWEEN '2015-09-11 18:00:00-04' AND '2015-09-18 17:59:59-04');
--35 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 18:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--50 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 18:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND cc.parent_id = 8
);
--50 rows.

--1851, SVA 1 2017, "About Us"

UPDATE partners_session
SET start = '2015-09-18 18:00:00-04', end_date = '2016-02-15 18:00:00-05'
WHERE id = 36611;

UPDATE reporting_allmatchemail
SET sess_id = 36611
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1851 AND send_date BETWEEN '2015-09-18 18:00:00-04' AND '2016-02-15 18:00:00-05');
--12 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2016-02-15 18:00:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--52 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2016-02-15 18:00:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851)
	AND cc.parent_id = 13
);
--52 rows.

--1855, SVA 2 2017, "Summer Prompt July"

UPDATE partners_session
SET start = '2015-07-05 14:00:00-04', end_date = '2015-09-10 23:59:59-04'
WHERE id = 36300;

UPDATE reporting_allmatchemail
SET sess_id = 36300
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1855 AND send_date BETWEEN '2015-07-05 14:00:00-04' AND '2015-09-10 23:59:59-04');
--65 rows

--1855, SVA 2 2017, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-09-11 00:00:00-04', end_date = '2015-09-11 17:59:59-04'
WHERE id = 36389;

UPDATE reporting_allmatchemail
SET sess_id = 36389
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1855 AND send_date BETWEEN '2015-09-11 00:00:00-04' AND '2015-09-11 17:59:59-04');
--20 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 00:00:00-04', end_datetime = '2015-09-11 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--0 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 00:00:00-04', end_datetime = '2015-09-11 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND cc.parent_id = 7
);
--0 rows.

--1855, SVA 2 2017, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-09-11 18:00:00-04', end_date = '2015-09-18 17:59:59-04'
WHERE id = 36373;

UPDATE reporting_allmatchemail
SET sess_id = 36373
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1855 AND send_date BETWEEN '2015-09-11 18:00:00-04' AND '2015-09-18 17:59:59-04');
--39 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 18:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--53 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 18:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND cc.parent_id = 8
);
--53 rows.

--1855, SVA 2 2017, "About Us"

UPDATE partners_session
SET start = '2015-09-18 18:00:00-04', end_date = '2015-09-25 12:59:59-04'
WHERE id = 36612;

UPDATE reporting_allmatchemail
SET sess_id = 36612
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1855 AND send_date BETWEEN '2015-09-18 18:00:00-04' AND '2015-09-25 12:59:59-04');
--11 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2015-09-25 12:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--22 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2015-09-25 12:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND cc.parent_id = 13
);
--21 rows.

--1855, SVA 2 2017, "Survey"

UPDATE partners_session
SET start = '2015-09-25 13:00:00', end_date = '2016-02-22 13:00:00'
WHERE id = 36747;

UPDATE reporting_allmatchemail
SET sess_id = 36747
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1855 AND send_date BETWEEN '2015-09-25 13:00:00' AND '2016-02-22 13:00:00');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-25 13:00:00', end_datetime = '2016-02-22 13:00:00'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (39,40,41)
);
--51 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-25 13:00:00', end_datetime = '2016-02-22 13:00:00'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1855)
	AND cc.parent_id = 19
);
--51 rows.

--1853, SVA 3 2017, "Summer Prompt July"

UPDATE partners_session
SET start = '2015-07-05 14:00:00-04', end_date = '2015-08-26 03:59:59-04'
WHERE id = 36298;

UPDATE reporting_allmatchemail
SET sess_id = 36298
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1853 AND send_date BETWEEN '2015-07-05 14:00:00-04' AND '2015-08-26 03:59:59-04');
--40 rows

--1853, SVA 3 2017, "About Us"

UPDATE partners_session
SET start = '2015-08-26 04:00:00-04', end_date = '2015-09-18 17:59:59-04'
WHERE id = 36378;

UPDATE reporting_allmatchemail
SET sess_id = 36378
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1853 AND send_date BETWEEN '2015-08-26 04:00:00-04' AND '2015-09-18 17:59:59-04');
--73 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-08-26 04:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--64 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-26 04:00:00-04', end_datetime = '2015-09-18 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND cc.parent_id = 13
);
--64 rows.

--1853, SVA 3 2017, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-09-18 18:00:00-04', end_date = '2015-09-25 12:59:59-04'
WHERE id = 36367;

UPDATE reporting_allmatchemail
SET sess_id = 36367
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1853 AND send_date BETWEEN '2015-09-18 18:00:00-04' AND '2015-09-25 12:59:59-04');
--16 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2015-09-25 12:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--64 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-18 18:00:00-04', end_datetime = '2015-09-25 12:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND cc.parent_id = 8
);
--64 rows.

--1853, SVA 3 2017, "Survey"

UPDATE partners_session
SET start = '2015-09-25 13:00:00', end_date = '2016-02-22 13:00:00'
WHERE id = 36748;

UPDATE reporting_allmatchemail
SET sess_id = 36748
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1853 AND send_date BETWEEN '2015-09-25 13:00:00' AND '2016-02-22 13:00:00');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-25 13:00:00', end_datetime = '2016-02-22 13:00:00'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (39,40,41)
);
--64 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-25 13:00:00', end_datetime = '2016-02-22 13:00:00'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1853)
	AND cc.parent_id = 19
);
--64 rows.

--SVA 4 2017 doesn't seem to be active, but we'll adjust its lessons anyway for the future.
--1854, SVA 4 2017, "Summer Prompt July"

UPDATE partners_session
SET start = '2015-07-05 14:00:00-04', end_date = '2015-08-13 03:59:59-04'
WHERE id = 36299;

UPDATE reporting_allmatchemail
SET sess_id = 36299
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1854 AND send_date BETWEEN '2015-07-05 14:00:00-04' AND '2015-08-13 03:59:59-04');
--0 rows

--1854, SVA 4 2017, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-08-13 04:00:00-04', end_date = '2015-09-11 16:00:59-04'
WHERE id = 36457;

UPDATE reporting_allmatchemail
SET sess_id = 36457
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1854 AND send_date BETWEEN '2015-08-13 04:00:00-04' AND '2015-09-11 16:00:59-04');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-08-13 04:00:00-04', end_datetime = '2015-09-11 16:00:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--1 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-13 04:00:00-04', end_datetime = '2015-09-11 16:00:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND cc.parent_id = 7
);
--1 rows.

--1854, SVA 4 2017, "Refresh and Reconnect" (11th grade)

UPDATE partners_session
SET start = '2015-09-11 16:01:00-04', end_date = '2015-09-24 23:59:59-04'
WHERE id = 36403;

UPDATE reporting_allmatchemail
SET sess_id = 36403
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1854 AND send_date BETWEEN '2015-09-11 16:01:00-04' AND '2015-09-24 23:59:59-04');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-11 16:01:00-04', end_datetime = '2015-09-24 23:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--10 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-11 16:01:00-04', end_datetime = '2015-09-24 23:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND cc.parent_id = 8
);
--10 rows.

--1854, SVA 4 2017, "Survey" (10th grade)

UPDATE partners_session
SET start = '2015-09-25 00:00:00', end_date = '2015-09-25 00:00:59'
WHERE id = 36382;

UPDATE reporting_allmatchemail
SET sess_id = 36382
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1854 AND send_date BETWEEN '2015-09-25 00:00:00' AND '2015-09-25 00:00:59');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-25 00:00:00', end_datetime = '2015-09-25 00:00:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--1 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-25 00:00:00', end_datetime = '2015-09-25 00:00:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1854)
	AND cc.parent_id = 12
);
--1 rows.

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

select * from partners_session where partner_id = 1853 order by start desc limit 15;

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
select id, name from partners_partner where name ilike 'SVA%';
select * from canvas_curriculum where id = 8
*/