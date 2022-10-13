--We're updating the schedules and sessions.

begin transaction;

UPDATE canvas_set_copy
SET start_datetime = '2015-10-26 14:18:00', end_datetime = '2015-11-02 15:17:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2165)
	AND csc.role IN (1,5,4)
	AND csc.parent_id IN (76, 77, 78)
);
--25 rows.

UPDATE canvas_curriculum_copy
SET start_datetime = '2015-10-26 14:18:00', end_datetime = '2015-11-02 15:17:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2165)
	AND cc.parent_id = 32
);
--25 rows.

/*
select * from canvas_curriculum_copy where user_id = 165967 order by end_datetime asc
select * from canvas_set_copy where user_id = 165967 order by end_datetime asc

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
where ps.partner_id = 2165
	and ps.start::date >= '8/17/15'
order by
	ps.start,
	cs.curriculum_id,
	cs.id,
	cs.role;

select * from partners_session where partner_id = 2165 order by start desc limit 15;
*/