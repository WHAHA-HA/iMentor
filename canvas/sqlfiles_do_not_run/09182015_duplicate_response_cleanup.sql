--We saw duplicate data again.

--User ID 153642
DELETE FROM canvas_content_user_response * WHERE id IN (38224);

--User ID 164828
DELETE FROM canvas_content_user_response * WHERE id IN (37846);

--User ID 164400
DELETE FROM canvas_content_user_response * WHERE id IN (37957);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
8097
,9551
,9532
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