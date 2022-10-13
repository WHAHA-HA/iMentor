--The related Zendesk tickets are #2803, #2802, and #2801.

begin transaction;

--Below is the mentor version with missing marker references for mentee responses.
WITH missing_response_marker AS (
	SELECT
		rc.id AS "marker_ref_copy_id",
		rc.parent_id AS "marker_ref_id",
		rc.other_marker_id AS "other_marker_copy_id",
		mr.other_marker_id AS "other_marker_id",
		mc.id AS "response_marker_copy_id",
		mc.parent_id AS "response_marker_id",
		rc.user_id AS "mentor_user_id",
		rc.persona_id AS "mentor_persona_id",
		mc.user_id AS "mentee_user_id",
		mc.persona_id AS "mentee_persona_id"
	FROM canvas_widget_content_marker_reference_copy AS rc
	JOIN iuser_persona AS ip ON ip.id = rc.persona_id
	JOIN iuser_user AS iu ON iu.id = ip.user_id
	JOIN iuser_matchhistory AS mh ON mh.mentor_id = ip.id
	JOIN canvas_widget_content_marker_reference AS mr ON mr.id = rc.parent_id
	JOIN canvas_widget_content_response_marker_copy AS mc ON mc.parent_id = mr.other_marker_id AND mc.persona_id = mh.mentee_id
	WHERE ip.match_status = 'M'
		AND ip.status = 'A'
		AND iu.status = 'A'
		AND rc.other_marker_id = 0
    )
UPDATE canvas_widget_content_marker_reference_copy AS rc
SET other_marker_id = mrm.response_marker_copy_id
FROM missing_response_marker AS mrm
WHERE rc.id = mrm.marker_ref_copy_id;
--2490 expected. 2490 affected.

begin transaction;

--Below is the mentee version with missing marker references for mentor responses.
WITH missing_response_marker AS (
	SELECT
		rc.id AS "marker_ref_copy_id",
		rc.parent_id AS "marker_ref_id",
		rc.other_marker_id AS "other_marker_copy_id",
		mr.other_marker_id AS "other_marker_id",
		mc.id AS "response_marker_copy_id",
		mc.parent_id AS "response_marker_id",
		rc.user_id AS "mentee_user_id",
		rc.persona_id AS "mentee_persona_id",
		mc.user_id AS "mentor_user_id",
		mc.persona_id AS "mentor_persona_id"
	FROM canvas_widget_content_marker_reference_copy AS rc
	JOIN iuser_persona AS ip ON ip.id = rc.persona_id
	JOIN iuser_user AS iu ON iu.id = ip.user_id
	JOIN iuser_matchhistory AS mh ON mh.mentee_id = ip.id
	JOIN canvas_widget_content_marker_reference AS mr ON mr.id = rc.parent_id
	JOIN canvas_widget_content_response_marker_copy AS mc ON mc.parent_id = mr.other_marker_id AND mc.persona_id = mh.mentor_id
	WHERE ip.match_status = 'M'
		AND ip.status = 'A'
		AND iu.status = 'A'
		AND rc.other_marker_id = 0
    )
UPDATE canvas_widget_content_marker_reference_copy AS rc
SET other_marker_id = mrm.response_marker_copy_id
FROM missing_response_marker AS mrm
WHERE rc.id = mrm.marker_ref_copy_id;
--81 expected. 81 affected.

/*
select * FROM canvas_widget_content_marker_reference_copy WHERE id = 16120
--expected other_marker_id: 36351

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 16121
--expected other_marker_id: 36352

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202681
--expected other_marker_id: 222290

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202689
--expected other_marker_id: 222305

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202690
--expected other_marker_id: 222306

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 203903
--expected other_marker_id: 223812

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 203904
--expected other_marker_id: 223813

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 203905
--expected other_marker_id: 223814

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 203906
--expected other_marker_id: 223815

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202715
--expected other_marker_id: 222289

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202714
--expected other_marker_id: 222288

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 202713
--expected other_marker_id: 222287

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 207478
--expected other_marker_id: 227763

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 5227
--expected other_marker_id: 11080

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 204989
--expected other_marker_id: 224974

select * FROM canvas_widget_content_marker_reference_copy WHERE id = 204990
--expected other_marker_id: 224975
*/