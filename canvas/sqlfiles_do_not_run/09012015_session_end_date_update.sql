--We closed all open sessions on 8/16/15 to exclude summer emails from the 2015-16 school year and give ourselves a fresh start with the Canvas.

UPDATE partners_session
SET end_date = '8/16/15'
WHERE end_date IS NULL;

/*
select * from partners_session where end_date is null;

select * from partners_session where end_date is not null and activity_recorded = false

(
1
,191
,196
,195
,231
,237
,236
,234
,233
,247
,246
,245
,244
)
*/