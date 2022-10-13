--We saw some duplicate data due to a less sophisticated save algorithm, which now is improved.

--User ID 153536
DELETE FROM canvas_content_user_response * WHERE id = 638;
DELETE FROM canvas_content_user_response * WHERE id = 688;

--User ID 152608
DELETE FROM canvas_content_user_response * WHERE id = 3047;
DELETE FROM canvas_content_user_response * WHERE id = 3116;

--User ID 164317
DELETE FROM canvas_content_user_response * WHERE id = 9725;

--User ID 166122
DELETE FROM canvas_content_user_response * WHERE id = 10205;

--User ID 165690
DELETE FROM canvas_content_user_response * WHERE id = 8621;

--User ID 164742
DELETE FROM canvas_content_user_response * WHERE id = 10650;
DELETE FROM canvas_content_user_response * WHERE id = 10659;

--User ID 165168
DELETE FROM canvas_content_user_response * WHERE id = 10664;

--User ID 164744
DELETE FROM canvas_content_user_response * WHERE id = 10447;

--User ID 161414
DELETE FROM canvas_content_user_response * WHERE id = 8006;

--User ID 164070
DELETE FROM canvas_content_user_response * WHERE id = 12017;

--User ID 165153
DELETE FROM canvas_content_user_response * WHERE id = 11679;

/*
select id,user_id,persona_id,marker_id,words,response_html,response_text from canvas_content_user_response where marker_id in (
784
,945
,853
,1123
,556
,510
,847
,2797
,911
,2822
,908
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