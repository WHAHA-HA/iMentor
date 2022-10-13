--Update sessions with overlaps that disrupted the correct logging of emails, then place finished lessons in the correct sessions

UPDATE reporting_allmatchemail
SET sess_id = 36587
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1679 AND send_date BETWEEN '2015-09-16 00:00:00-04' AND '2016-02-13 13:00:00-05');
--26 rows

/*
select id, name from partners_partner where name ilike 'North Dallas 2016B'
select * from partners_session where partner_id = 1679 order by start desc limit 10;
select * from reporting_allmatchemail WHERE partner_id = 1679 AND send_date BETWEEN '2015-09-16 00:00:00-04' AND '2016-02-13 13:00:00-05';
select * from reporting_allmatchemail where sess_id = 36587;
select * from partners_session where id = 36587;
select * from canvas_set_copy where persona_id in (select persona_id from iuser_persona_partners where partner_id = 2148) order by parent_id asc;
*/