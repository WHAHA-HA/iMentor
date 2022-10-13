--We updated the admin_last_viewed field to prevent hundreds of rows of new content in the Flipbook.

begin transaction;

UPDATE canvas_set_copy
SET admin_last_viewed = '3/1/16'
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (1815,
		1816,
		1817,
		1818,
		1819,
		1820,
		1821,
		1822,
		1837,
		1838,
		1840,
		2454)
);
--3033 rows. 3033 affected.

UPDATE portfolio_reflection_user_details
SET admin_last_viewed = '3/1/16'
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (1815,
		1816,
		1817,
		1818,
		1819,
		1820,
		1821,
		1822,
		1837,
		1838,
		1840,
		2454)
);
--160 rows. 160 affected.

/*
SELECT
	admin_last_viewed
FROM canvas_set_copy
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (1815,
		1816,
		1817,
		1818,
		1819,
		1820,
		1821,
		1822,
		1837,
		1838,
		1840,
		2454)
);

SELECT
	admin_last_viewed
FROM portfolio_reflection_user_details
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (1815,
		1816,
		1817,
		1818,
		1819,
		1820,
		1821,
		1822,
		1837,
		1838,
		1840,
		2454)
);

select id, name from partners_partner where member_id = 197 and status_id = 1 and is_alumni = FALSE order by id asc;
*/