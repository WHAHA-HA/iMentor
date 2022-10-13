--We saw duplicate data again.

--User ID 151653
DELETE FROM canvas_content_user_response * WHERE id IN (105061);

--User ID 144750
DELETE FROM canvas_content_user_response * WHERE id IN (97768);

--User ID 157645
DELETE FROM canvas_content_user_response * WHERE id IN (98858);

--User ID 157784
DELETE FROM canvas_content_user_response * WHERE id IN (79854);

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
1167
,24069
,23158
,26677
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