--These marker reference copies were pointing to response marker copies that didn't exist, so we repointed them.

begin transaction;

UPDATE canvas_widget_content_marker_reference_copy
SET other_marker_id = 21177
WHERE id = 26078;

UPDATE canvas_widget_content_marker_reference_copy
SET other_marker_id = 21179
WHERE id = 26080;

UPDATE canvas_widget_content_marker_reference_copy
SET other_marker_id = 105582
WHERE id = 92114;

/*
SELECT
    cwcmr.id AS "Marker Reference ID",
    cwcmr.other_marker_id AS "Marker Reference Other Marker ID",
    cwcmr.parent_id AS "Marker Reference Parent ID",
    cwcmr.user_id AS "User ID",
    ip.id AS "Persona ID",
    ip.match_status AS "Match Status",
    cwcrm.id AS "Response Marker ID"
FROM canvas_widget_content_marker_reference_copy AS cwcmr
JOIN iuser_persona AS ip ON ip.user_id = cwcmr.user_id
LEFT OUTER JOIN canvas_widget_content_response_marker_copy AS cwcrm ON cwcrm.id = cwcmr.other_marker_id
WHERE cwcrm.id IS NULL
    AND ip.status = 'A'
    AND ip.match_status = 'M'
    AND cwcmr.other_marker_id != 0;

select * from canvas_widget_content_marker_reference_copy where parent_id between 59 and 70 and user_id = 155417 order by parent_id asc
select * from canvas_widget_content_response_marker_copy where parent_id = 129 and user_id = 177593;

--Mentee 155417 joymendoza@stu.irvingisd.net had mentor 163887 shachin@swstrategies.com without 12.1.3 in Irving 2016C at Lone Star
--Mentor 174203 had mentee 177593
*/