--We saw duplicate data again.

--User ID 164390
DELETE FROM canvas_content_user_response * WHERE id = 21078;

--User ID 164437
DELETE FROM canvas_content_user_response * WHERE id = 19200;

--User ID 164440
DELETE FROM canvas_content_user_response * WHERE id = 18497;

--User ID 164447
DELETE FROM canvas_content_user_response * WHERE id = 18492;

--User ID 164409
DELETE FROM canvas_content_user_response * WHERE id IN (22175,22014,22024);

--User ID 164380
DELETE FROM canvas_content_user_response * WHERE id = 21509;

--User ID 164832
DELETE FROM canvas_content_user_response * WHERE id = 17942;

--User ID 154218
DELETE FROM canvas_content_user_response * WHERE id = 22461;

--User ID 153587
DELETE FROM canvas_content_user_response * WHERE id = 21688;

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
65
,60
,104
,750
,110
,5714
,27
,89
,15
)
order by marker_id,words asc;

SELECT
	user_id,
	marker_id,
	COUNT(*)
FROM canvas_content_user_response
GROUP BY
	user_id,
	marker_id
HAVING COUNT(*) > 1;
*/