WITH session_email_details AS (
	SELECT
		ps.id AS "sess_id",
		ps.description as "description",
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
		AND ps.partner_id = 1817
		AND ra.send_date::DATE >= '10/20/15'
		--AND ps.start >= '10/1/15'
		--AND ra.sess_id = 36744
		--AND ra.sess_id IS NULL
	)
UPDATE reporting_allmatchemail AS ra
SET sess_id = sed.sess_id
FROM session_email_details AS sed
WHERE ra.id = sed.match_email_id;
--9064 rows. 8506 affected.

/*
SELECT
	ps.id AS "sess_id",
	ps.start AS "sess_start",
	ps.end_date AS "sess_end",
	ps.partner_id AS "partner_id",
	ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' AS "adjusted_match_email_send_date",
	ra.partner_id AS "match_email_partner_id",
	ra.id AS "match_email_id"
FROM partners_session AS ps
JOIN reporting_allmatchemail AS ra ON ra.partner_id = ps.partner_id
WHERE ps.start::DATE >= '8/17/15'
	AND ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' BETWEEN ps.start AND ps.end_date
	AND ra.sess_id IS NULL

DROP TABLE IF EXISTS temp_session_email_details;

SELECT
	ps.id AS "sess_id",
	ps.start AS "sess_start",
	ps.end_date AS "sess_end",
	ps.partner_id AS "partner_id",
	ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' AS "adjusted_match_email_send_date",
	ra.partner_id AS "match_email_partner_id",
	ra.id AS "match_email_id"
INTO temp_session_email_details
FROM partners_session AS ps
JOIN reporting_allmatchemail AS ra ON ra.partner_id = ps.partner_id
WHERE ps.start::DATE >= '8/17/15'
	AND ra.send_date::TIMESTAMPTZ AT TIME ZONE 'UTC' BETWEEN ps.start AND ps.end_date
	AND ra.sess_id IS NULL

UPDATE reporting_allmatchemail AS ra
SET sess_id = tsed.sess_id
FROM temp_session_email_details AS tsed
WHERE ra.id = tsed.match_email_id;
*/