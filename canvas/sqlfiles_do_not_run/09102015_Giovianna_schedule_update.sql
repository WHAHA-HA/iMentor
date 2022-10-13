--We're extending a lesson at CNM for three partner sites that Giovianna Burrell manages, based on her scheduling trouble.

UPDATE canvas_set_copy
SET end_datetime = '2016-02-08 16:45:00-05'
WHERE id IN (
SELECT
	csc.id
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851,1853,1855)
	AND csc.role IN (4,5,1)
	AND csc.parent_id IN (17,18,16)
);
--167 rows.

UPDATE canvas_curriculum_copy
SET end_datetime = '2016-02-08 16:45:00-05'
WHERE id IN (
SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851,1853,1855)
	AND cc.parent_id = 8
);
--167 rows.

/*
SELECT
	csc.*
FROM canvas_set_copy AS csc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = csc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851,1853,1855)
	AND csc.role IN (4,5,1)
	AND csc.parent_id IN (17,18,16)

SELECT
	cc.*
FROM canvas_curriculum_copy AS cc
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = cc.persona_id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
WHERE pp.id IN (1851,1853,1855)
	AND cc.parent_id = 8

select email from iuser_user where id = 154082
*/