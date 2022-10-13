--The following students experienced crashes during the legacy update of the "Finish" button click, so we cleared the user_completed field and clicked "Finish" for them again to capture their participation.

begin transaction;

--147135, kmiddleton2479@iam-hs.org
UPDATE canvas_set_copy
SET user_completed = NULL
WHERE id = 85775;

--146880, ndeck6787@iam-hs.org
UPDATE canvas_set_copy
SET user_completed = NULL
WHERE id = 85844;

--147115, speart8192@iam-hs.org
UPDATE canvas_set_copy
SET user_completed = NULL
WHERE id = 85765;

/*
select * from canvas_set_copy where user_id = 147115 order by user_completed desc
select email from iuser_user where id = 147115
select * from iuser_persona where user_id = 147135
select * from iuser_matchhistory where mentee_id = 69412
select * from iuser_persona where id = 63346
select * from iuser_persona where user_id = 141418
select * from iuser_user where id = 141418

select id, match_status, status from iuser_persona where user_id = 147115
select * from iuser_matchhistory where mentee_id = 69392
select id, user_id, match_status, status from iuser_persona where id = 49594
select * from iuser_matchhistory where mentor_id = 63346

select * from canvas_widget_content_response_marker_copy where user_id = 147115
select * from canvas_content_user_response where marker_id = 135683

select * from canvas_widget_content_response_marker_copy where user_id = 146880
select * from canvas_content_user_response where marker_id = 135762
*/