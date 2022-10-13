--Update sessions with overlaps that disrupted the correct logging of emails, then place finished lessons in the correct sessions

UPDATE partners_session
SET start = '2015-08-31 00:4:00-04', end_date = '2015-09-17 00:33:59-04'
WHERE id = 36385;

UPDATE partners_session
SET start = '2015-09-18 00:34:00-04', end_date = '2016-02-18 00:34:00-04'
WHERE id = 36395;

UPDATE reporting_allmatchemail
SET sess_id = 36385
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2123 AND send_date BETWEEN '2015-08-31 00:4:00-04' AND '2015-09-17 00:33:59-04');
--22 rows

UPDATE reporting_allmatchemail
SET sess_id = 36395
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2123 AND send_date BETWEEN '2015-09-18 00:34:00-04' AND '2016-02-17 23:34:00-05');
--14 rows

/*
select id, name from partners_partner where name ilike '2 sva%'
select * from partners_session where partner_id = 2123 order by id desc limit 10;
select * from partners_session where partner_id = 2123 order by start desc limit 10;
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '8/18/15 04:00:00' and '9/8/15 3:59:59';
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '9/8/15 04:00:00' and '9/15/15 13:59:59';
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '9/15/15 14:00:00' and '2/14/16 14:00:00';
select * from reporting_allmatchemail where sess_id = 36385;
select * from partners_session where id = 36385;
select * from partners_session where partner_id = 2126 order by id desc limit 10;
*/