--Update sessions with overlaps that disrupted the correct logging of emails, then place finished lessons in the correct sessions

UPDATE partners_session
SET start = '2015-09-02 04:00:00', end_date = '2015-09-10 18:59:59'
WHERE id = 36416;

UPDATE partners_session
SET start = '2015-09-10 19:00:00', end_date = '2015-09-16 12:59:59'
WHERE id = 36542;

UPDATE partners_session
SET start = '2015-09-16 13:00:00-04', end_date = '2016-02-13 13:00:00-05'
WHERE id = 36592;

UPDATE reporting_allmatchemail
SET sess_id = 36416
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1806 AND send_date BETWEEN '2015-09-02 04:00:00' AND '2015-09-10 18:59:59');
--17 rows

UPDATE reporting_allmatchemail
SET sess_id = 36542
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1806 AND send_date BETWEEN '2015-09-10 19:00:00' AND '2015-09-16 12:59:59');
--4 rows

UPDATE reporting_allmatchemail
SET sess_id = 36592
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 1806 AND send_date BETWEEN '2015-09-16 13:00:00-04' AND '2016-02-13 13:00:00-05');
--21 rows

/*
select id, name from partners_partner where name ilike '%2017%Wed F%'
select * from partners_session where partner_id = 1806 order by start desc limit 10;
select * from reporting_allmatchemail WHERE partner_id = 1806 AND send_date BETWEEN '2015-09-10 19:00:00' AND '2015-09-16 12:59:59';
select * from reporting_allmatchemail where sess_id = 36592;
select * from partners_session where id = 36624;
select * from canvas_set_copy where persona_id in (select persona_id from iuser_persona_partners where partner_id = 1806) order by parent_id asc;
select id, name from partners_partner where id = 1806;
*/