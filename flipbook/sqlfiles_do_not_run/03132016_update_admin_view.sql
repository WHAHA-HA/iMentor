--We updated the admin_last_viewed field to prevent hundreds of rows of new content in the Flipbook.

begin transaction;

UPDATE canvas_set_copy
SET admin_last_viewed = '3/7/16';
--230686 rows. 230686 affected.

UPDATE portfolio_reflection_user_details
SET admin_last_viewed = '3/7/16';
--26989 rows. 26989 affected.

/*
select start_datetime, user_first_completed, user_completed, last_viewed, admin_last_viewed from canvas_set_copy limit 500;
select last_viewed, admin_last_viewed from portfolio_reflection_user_details limit 500;

select count(*) from canvas_set_copy;
select count(*) from portfolio_reflection_user_details;
*/