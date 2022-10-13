--We saw duplicate data again, but have a great way to resolve it quickly now.
--Simply add marker IDs to the DELETE statement from the SELECT statement below, delete them, then repeat from adding marker IDs to the DELETE statement until no duplicate marker IDs remain.

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
--50 to 0 rows.

SELECT
	id,
	marker_id,
	words
FROM canvas_content_user_response WHERE marker_id IN (
45842
,32261
,33667
,42101
,36216
,32254
,32058
,37093
,26584
,23697
,40318
,36185
,32152
,32115
,32267
,36178
,32008
,40561
,36461
,36198
,36883
,42001
,36891
,33518
,30185
,36218
,32183
,41842
,45485
,36232
,32171
,31955
,40647
,32077
,36228
,45830
,36197
,18173
,46007
,36087
,32255
,32285
,33307
,32243
,31936
,32059
,31972
,15749
,29595
,45866
)
ORDER BY user_id ASC;
--131 to 50 rows.
*/