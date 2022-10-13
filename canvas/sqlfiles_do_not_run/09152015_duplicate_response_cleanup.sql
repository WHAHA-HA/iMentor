--We saw duplicate data again.

--User ID 160609
DELETE FROM canvas_content_user_response * WHERE id IN (26755);

--User ID 154967
DELETE FROM canvas_content_user_response * WHERE id IN (26657);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
164
,6979
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