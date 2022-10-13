--We saw duplicate data again.

--User ID 160967
DELETE FROM canvas_content_user_response * WHERE id IN (25922,25940);

--User ID 160819
DELETE FROM canvas_content_user_response * WHERE id IN (23356,23341);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
177
,5390
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