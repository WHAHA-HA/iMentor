--Update sessions with overlaps that disrupted the correct logging of emails, then place finished lessons in the correct sessions

UPDATE partners_session
SET start = '2015-09-16 12:00:00', end_date = '2015-09-22 11:59:59'
WHERE id = 36556;

UPDATE reporting_allmatchemail
SET sess_id = 36556
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2148 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59');
--36 rows

/*
select id, name from partners_partner where name ilike 'Brashear 18-PD 3'
select * from partners_session where partner_id = 2148 order by start desc limit 10;
select * from reporting_allmatchemail WHERE partner_id = 2148 AND send_date BETWEEN '2015-09-16 12:00:00' AND '2015-09-22 11:59:59';
select * from reporting_allmatchemail where sess_id = 36556;
select * from partners_session where id = 36624;
select * from canvas_set_copy where persona_id in (select persona_id from iuser_persona_partners where partner_id = 2148) order by parent_id asc;
*/