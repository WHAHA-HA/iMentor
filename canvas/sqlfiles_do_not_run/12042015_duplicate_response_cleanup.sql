--We saw duplicate data again, but have a great way to resolve it quickly now.
--Simply add marker IDs to the DELETE statement from the SELECT statement below, delete them, then repeat from adding marker IDs to the DELETE statement until no duplicate marker IDs remain.

commit;

begin transaction;

DELETE FROM canvas_content_user_response *
WHERE id IN (
	SELECT DISTINCT ON (user_id)
		NTH_VALUE(id, 1) OVER x AS "id"
	FROM canvas_content_user_response
	WHERE marker_id IN (

	)
	WINDOW x AS (PARTITION BY user_id ORDER BY words ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
);

/*
SELECT
	user_id,
	marker_id,
	COUNT(*)
FROM canvas_content_user_response
GROUP BY
	user_id,
	marker_id
HAVING COUNT(*) > 1;
--11 to 0 rows.

SELECT
	id,
	marker_id,
	words
FROM canvas_content_user_response WHERE marker_id IN (
68113
,128760
,170740
,156505
,159087
,168112
,146923
,171285
,146857
,163589
,163599
)
ORDER BY user_id ASC;
--22 to 11 rows.
*/