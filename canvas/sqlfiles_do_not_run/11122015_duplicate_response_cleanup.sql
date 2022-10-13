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
127230
,127263
,127267
,127278
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
--73 to 0 rows.

SELECT
	id,
	marker_id,
	words
FROM canvas_content_user_response WHERE marker_id IN (
103055
,129123
,129028
,129111
,125460
,127299
,128414
,120939
,111562
,125418
,125390
,128073
,127323
,127230
,116668
,128402
,128406
,127255
,129160
,127315
,127259
,128083
,127333
,120937
,127265
,128030
,127270
,119083
,129126
,127244
,128078
,127465
,127248
,127263
,129100
,120944
,123425
,127348
,127251
,123624
,113407
,128454
,127298
,129166
,119090
,129093
,129095
,125536
,127246
,127281
,127271
,126938
,111702
,127327
,127317
,128426
,129110
,127261
,129071
,127257
,120945
,127267
,128439
,127264
,127268
,128031
,129151
,129169
,127249
,128362
,113406
,127278
,109482
)
ORDER BY user_id ASC;
--197 to 73 rows.
*/