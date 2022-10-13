WITH existing_emaillog AS (
	SELECT
		pp.id AS "partner_id",
		rel.id AS "emaillog_id"
	FROM reporting_emaillog AS rel
	JOIN partners_partner AS pp ON pp.name = rel.partner_name_list
	LEFT OUTER JOIN reporting_emaillog_partners AS relp ON relp.emaillog_id = rel.id
	WHERE rel.sent_date::DATE >= '8/17/15'
		AND relp.partner_id IS NULL
	)
INSERT INTO reporting_emaillog_partners (partner_id, emaillog_id)
SELECT partner_id, emaillog_id FROM existing_emaillog;
--2812 rows.

/*
select * from reporting_emaillog_partners where emaillog_id = 2369830;

select * from reporting_emaillog_partners order by id desc limit 10;
*/