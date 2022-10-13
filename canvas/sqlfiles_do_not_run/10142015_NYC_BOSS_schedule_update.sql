--We're updating the schedules and sessions.

--Update all email session assignments

WITH session_email_details AS (
	SELECT
		ps.id AS "sess_id",
		ps.description AS "description",
		ps.start AS "sess_start",
		ps.end_date AS "sess_end",
		ps.partner_id AS "partner_id",
		ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' AS "adjusted_match_email_send_date",
		ra.partner_id AS "match_email_partner_id",
		ra.id AS "match_email_id",
		ra.sess_id AS "match_email_sess_id"
	FROM partners_session AS ps
	JOIN reporting_allmatchemail AS ra ON ra.partner_id = ps.partner_id
	WHERE ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' >= ps.start
		AND (ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' < ps.end_date
		    OR ps.end_date IS NULL)
		AND ps.partner_id = 1907
		AND ps.start >= '10/7/15'
		--AND ra.sess_id IS NULL
		--AND ra.sess_id = 36744
		--AND ra.send_date::DATE = '10/8/15'
	)
UPDATE reporting_allmatchemail AS ra
SET sess_id = sed.sess_id
FROM session_email_details AS sed
WHERE ra.id = sed.match_email_id;
--25 rows. 25 affected.

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
where ps.partner_id = 2135
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
select id, name from partners_partner where id = 1907;
*/