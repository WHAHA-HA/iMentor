SELECT
	iu.id AS "Mentor User ID",
	ip.id AS "Mentor Persona ID",
	iu.first_name AS "Mentor First Name",
	iu.last_name AS "Mentor Last Name",
	iu2.id AS "MA User ID",
	ip2.id AS "MA Persona ID",
	iu2.first_name AS "MA First Name",
	iu2.last_name AS "MA Last Name"
FROM iuser_user AS iu
JOIN br_temp_latest_personas AS btlp ON btlp.user_id = iu.id
JOIN iuser_persona AS ip ON ip.id = btlp.persona_id
JOIN iuser_assignedusertype AS iau ON iau.id = ip.assigned_usertype_id
JOIN iuser_usertype AS iut ON iut.id = iau.usertype_id
JOIN iuser_persona_partners AS ipp ON ipp.persona_id = ip.id
JOIN partners_partner AS pp ON pp.id = ipp.partner_id
JOIN iuser_persona AS ip2 ON ip2.id = pp.member_contact_id
JOIN iuser_user AS iu2 ON iu2.id = ip2.user_id
WHERE iu.status = 'A'
	AND iu.member_id = 1
	AND iut.id = 4
ORDER BY
	iu.first_name,
	iu.last_name ASC;