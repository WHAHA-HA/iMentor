--We updated the admin_last_viewed field to prevent hundreds of rows of new content in the Flipbook.

begin transaction;

UPDATE canvas_set_copy
SET admin_last_viewed = '3/7/16'
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (
		2338,
		2339,
		2340,
		2341,
		2211,
		2212,
		2213,
		2372,
		2373,
		2375,
		2376,
		2377,
		1962,
		1963,
		1964,
		1965,
		1930,
		1931,
		1932,
		1933)
);
--12195 rows. 12195 affected.

UPDATE portfolio_reflection_user_details
SET admin_last_viewed = '3/7/16'
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (
		2338,
		2339,
		2340,
		2341,
		2211,
		2212,
		2213,
		2372,
		2373,
		2375,
		2376,
		2377,
		1962,
		1963,
		1964,
		1965,
		1930,
		1931,
		1932,
		1933)
);
--1434 rows. 1434 affected.

/*
SELECT
	admin_last_viewed
FROM canvas_set_copy
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (
		2338,
		2339,
		2340,
		2341,
		2211,
		2212,
		2213,
		2372,
		2373,
		2375,
		2376,
		2377,
		1962,
		1963,
		1964,
		1965,
		1930,
		1931,
		1932,
		1933)
);

SELECT
	admin_last_viewed
FROM portfolio_reflection_user_details
WHERE persona_id IN (
	SELECT
		persona_id
	FROM iuser_persona_partners
	WHERE partner_id IN (
		2338,
		2339,
		2340,
		2341,
		2211,
		2212,
		2213,
		2372,
		2373,
		2375,
		2376,
		2377,
		1962,
		1963,
		1964,
		1965,
		1930,
		1931,
		1932,
		1933)
);
*/