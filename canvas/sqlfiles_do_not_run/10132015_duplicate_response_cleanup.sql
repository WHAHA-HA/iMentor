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
--51 to 0 rows.

SELECT
	id,
	marker_id,
	words
FROM canvas_content_user_response WHERE marker_id IN (
42490
,30813
,28675
,48602
,18405
,53187
,53275
,53193
,35634
,32128
,53247
,53241
,53265
,53287
,43210
,51903
,53163
,48448
,41010
,53195
,39163
,53293
,27462
,48382
,44378
,53341
,48341
,40573
,45989
,48657
,53263
,48408
,53228
,53235
,23489
,48354
,37241
,53233
,48428
,53171
,46060
,48651
,52021
,33555
,48520
,53179
,48506
,48616
,48612
,53392
,53219
)
ORDER BY user_id ASC;
--133 to 51 rows.
*/