begin transaction;

update qualtrics_survey
set member_id = 1
where id = 23;

/*
select * from qualtrics_survey
*/