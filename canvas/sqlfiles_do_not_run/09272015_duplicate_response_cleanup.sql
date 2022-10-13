--We saw duplicate data again.

--User ID 154736
DELETE FROM canvas_content_user_response * WHERE id IN (46913);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
14969
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