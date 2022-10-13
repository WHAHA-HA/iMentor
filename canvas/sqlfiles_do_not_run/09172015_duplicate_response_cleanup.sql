--We saw duplicate data again.

--User ID 151309
DELETE FROM canvas_content_user_response * WHERE id IN (33523);

--User ID 151268
DELETE FROM canvas_content_user_response * WHERE id IN (34961);

--User ID 162072
DELETE FROM canvas_content_user_response * WHERE id IN (34537);

--User ID 161629
DELETE FROM canvas_content_user_response * WHERE id IN (34958);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
639
,8427
,9080
,637
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