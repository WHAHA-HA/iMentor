--We're updating the schedules and sessions.

--2148, Brashear 18-Pd 3, "Survey" (11th grade)

UPDATE partners_session
SET start = '2015-09-16 11:59:00-04', end_date = '2015-09-16 11:59:59-04'
WHERE id = 36741;

UPDATE reporting_allmatchemail
SET sess_id = 36741
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2148 AND send_date BETWEEN '2015-09-16 11:59:00-04' AND '2015-09-16 11:59:59-04');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-16 11:59:00-04', end_datetime = '2015-09-16 11:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2148)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (28,60)
);
--1 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-16 11:59:00-04', end_datetime = '2015-09-16 11:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2148)
	AND cc.parent_id = 14
);
--1 rows.

--2148, Brashear 18-Pd 3, "Survey" (10th grade)

UPDATE partners_session
SET start = '2015-09-22 12:00:00-04', end_date = '2016-02-19 12:00:00-05'
WHERE id = 36624;

UPDATE reporting_allmatchemail
SET sess_id = 36624
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2148 AND send_date BETWEEN '2015-09-22 12:00:00-04' AND '2016-02-19 12:00:00-05');
--9 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2148)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--74 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2148)
	AND cc.parent_id = 12
);
--74 rows.

--2151, Brashear 18-Pd 8, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-09-16 12:00:00', end_date = '2015-09-22 11:59:59'
WHERE id = 36559;

UPDATE reporting_allmatchemail
SET sess_id = 36559
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2151 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59');
--20 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-16 12:00:00', end_datetime = '2015-09-22 11:59:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2151)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--42 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-16 12:00:00', end_datetime = '2015-09-22 11:59:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2151)
	AND cc.parent_id = 7
);
--42 rows.

--2151, Brashear 18-Pd 8, "Survey" (10th grade)

UPDATE partners_session
SET start = '2015-09-22 12:00:00-04', end_date = '2016-02-19 12:00:00-05'
WHERE id = 36627;

UPDATE reporting_allmatchemail
SET sess_id = 36627
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2151 AND send_date BETWEEN '2015-09-22 12:00:00-04' AND '2016-02-19 12:00:00-05');
--14 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2151)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--50 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2151)
	AND cc.parent_id = 12
);
--50 rows.

--2149, Brashear 18-Pd 9, "Refresh and Reconnect" (10th grade)

UPDATE partners_session
SET start = '2015-09-16 12:00:00', end_date = '2015-09-22 11:59:59'
WHERE id = 36557;

UPDATE reporting_allmatchemail
SET sess_id = 36557
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2149 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59');
--2 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-16 12:00:00', end_datetime = '2015-09-22 11:59:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2149)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (13,14,15)
);
--16 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-16 12:00:00', end_datetime = '2015-09-22 11:59:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2149)
	AND cc.parent_id = 7
);
--16 rows.

--2149, Brashear 18-Pd 9, "Survey" (10th grade)

UPDATE partners_session
SET start = '2015-09-22 12:00:00-04', end_date = '2016-02-19 12:00:00-05'
WHERE id = 36625;

UPDATE reporting_allmatchemail
SET sess_id = 36625
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2149 AND send_date BETWEEN '2015-09-22 12:00:00-04' AND '2016-02-19 12:00:00-05');
--1 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2149)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (22,23,24)
);
--25 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-22 12:00:00-04', end_datetime = '2016-02-19 12:00:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2149)
	AND cc.parent_id = 12
);
--25 rows.

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

select * from partners_session where partner_id = 2149 order by start desc limit 15;

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
WHERE pp.id IN (2149)
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
select id, name from partners_partner where name ilike 'SVA%';
select * from canvas_curriculum where id = 8
*/