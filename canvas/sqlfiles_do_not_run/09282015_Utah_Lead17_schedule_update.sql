--We're updating the schedules and sessions.

--2142, CHS'17LeadersinAction, "Survey"

UPDATE partners_session
SET start = '2015-08-16 00:00:01-04', end_date = '2015-08-16 00:00:59-04'
WHERE id = 36535;

UPDATE reporting_allmatchemail
SET sess_id = 36535
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2142 AND send_date BETWEEN '2015-08-16 00:00:01-04' AND '2015-08-16 00:00:59-04');
--0 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-08-16 00:00:01-04', end_datetime = '2015-08-16 00:00:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (39,40,41)
);
--56 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-16 00:00:01-04', end_datetime = '2015-08-16 00:00:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND cc.parent_id = 19
);
--56 rows.

--2142, CHS'17LeadersinAction, "Refresh and Reconnect"

UPDATE partners_session
SET start = '2015-08-16 00:01:00-04', end_date = '2015-09-10 18:29:59-04'
WHERE id = 36420;

UPDATE reporting_allmatchemail
SET sess_id = 36420
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2142 AND send_date BETWEEN '2015-08-16 00:01:00-04' AND '2015-09-10 18:29:59-04');
--39 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-08-16 00:01:00-04', end_datetime = '2015-09-10 18:29:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (16,17,18)
);
--55 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-08-16 00:01:00-04', end_datetime = '2015-09-10 18:29:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND cc.parent_id = 8
);
--55 rows.

--2142, CHS'17LeadersinAction, "About Us"

UPDATE partners_session
SET start = '2015-09-10 18:30:00-04', end_date = '2015-09-17 18:29:59-04'
WHERE id = 36400;

UPDATE reporting_allmatchemail
SET sess_id = 36400
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2142 AND send_date BETWEEN '2015-09-10 18:30:00-04' AND '2015-09-17 18:29:59-04');
--10 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-10 18:30:00-04', end_datetime = '2015-09-17 18:29:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (25,26,27)
);
--55 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-10 18:30:00-04', end_datetime = '2015-09-17 18:29:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND cc.parent_id = 13
);
--55 rows.

--2142, CHS'17LeadersinAction, "College Success Toolkit"

UPDATE partners_session
SET start = '2015-09-17 18:30:00-04', end_date = '2015-09-24 17:59:59-04'
WHERE id = 36610;

UPDATE reporting_allmatchemail
SET sess_id = 36610
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2142 AND send_date BETWEEN '2015-09-17 18:30:00-04' AND '2015-09-24 17:59:59-04');
--14 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-17 18:30:00-04', end_datetime = '2015-09-24 17:59:59-04'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (48,49,50)
);
--54 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-17 18:30:00-04', end_datetime = '2015-09-24 17:59:59-04'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND cc.parent_id = 23
);
--54 rows.

--2142, CHS'17LeadersinAction, "Teamwork Makes the Dreamwork"

UPDATE partners_session
SET start = '2015-09-24 18:00:00-04', end_date = '2016-02-21 18:00:00-05'
WHERE id = 36738;

UPDATE reporting_allmatchemail
SET sess_id = 36738
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2142 AND send_date BETWEEN '2015-09-24 18:00:00-04' AND '2016-02-21 18:00:00-05');
--10 rows

UPDATE canvas_set_copy
SET start_datetime = '2015-09-24 18:00:00-04', end_datetime = '2016-02-21 18:00:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (70,71,72)
);
--52 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-09-24 18:00:00-04', end_datetime = '2016-02-21 18:00:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2142)
	AND cc.parent_id = 30
);
--52 rows.

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

select * from partners_session where partner_id = 2142 order by start desc limit 15;

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
select id, name from partners_partner where name ilike '%Lead%';
select * from canvas_curriculum where id = 8
*/