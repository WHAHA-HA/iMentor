--We saw duplicate data again.

--User ID 164325
DELETE FROM canvas_content_user_response * WHERE id = 14680;

--User ID 164768
DELETE FROM canvas_content_user_response * WHERE id = 15281;

--User ID 165266
DELETE FROM canvas_content_user_response * WHERE id = 15927;

--User ID 164746
DELETE FROM canvas_content_user_response * WHERE id = 15931;

--User ID 144703
DELETE FROM canvas_content_user_response * WHERE id = 16505;

--User ID 144774
DELETE FROM canvas_content_user_response * WHERE id = 16444;

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
1931
,4928
,1939
,1696
,4938
,1625
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