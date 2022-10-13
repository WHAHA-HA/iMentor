--We saw duplicate data again.

--User ID 163051
DELETE FROM canvas_content_user_response * WHERE id IN (27210);

--User ID 155011
DELETE FROM canvas_content_user_response * WHERE id IN (32963);

--User ID 147956
DELETE FROM canvas_content_user_response * WHERE id IN (30987);

--User ID 152798
DELETE FROM canvas_content_user_response * WHERE id IN (28634);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
8590
,5402
,6516
,7111
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