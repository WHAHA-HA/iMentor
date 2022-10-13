--We're updating the schedule as requested.

UPDATE canvas_set_copy
SET end_datetime = '2016-09-23 23:59:59'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2129)
	AND csc.role IN (4,5,1)
	AND csc.parent_id IN (39,40,41)
);
--52 rows.

UPDATE canvas_curriculum_copy
SET end_datetime = '2016-09-23 23:59:59'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2129)
	AND cc.parent_id = 19
);
--52 rows.

/*
SELECT
	csc.*,
	pp.name
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2129)
	AND csc.role IN (4,5,1)
	AND csc.parent_id IN (39,40,41)

SELECT
	cc.*,
	pp.name
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (2129)
	AND cc.parent_id = 19

select email from iuser_user where id = 170096
select * from canvas_set_copy where user_id = 170096

select email from iuser_user where id = 164436
select * from canvas_set_copy where user_id = 164436

select * from partners_session where partner_id in (2122,2123,2124)

select * from canvas_set where id = 14
*/