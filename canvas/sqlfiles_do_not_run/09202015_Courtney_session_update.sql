--Update sessions with overlaps that disrupted the correct logging of emails, then place finished lessons in the correct sessions

UPDATE partners_session
SET start = '2015-08-16 04:00:00-04', end_date = '2015-08-16 23:59:59-04'
WHERE id = 36455;

UPDATE partners_session
SET start = '2015-08-17 04:00:00-04', end_date = '2015-08-17 23:59:59-04'
WHERE id = 36466;

UPDATE partners_session
SET start = '2015-08-18 04:00:00-04', end_date = '2015-09-08 03:59:59-04'
WHERE id = 36486;

UPDATE partners_session
SET start = '2015-09-08 04:00:00-04', end_date = '2015-09-15 13:59:59-04'
WHERE id = 36407;

UPDATE partners_session
SET start = '2015-09-15 14:00:00-04', end_date = '2016-02-14 14:00:00-04'
WHERE id = 36567;

UPDATE reporting_allmatchemail
SET sess_id = 36486
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2126 AND send_date BETWEEN '8/18/15 04:00:00' AND '9/8/15 3:59:59');
--24 rows

UPDATE reporting_allmatchemail
SET sess_id = 36407
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2126 AND send_date BETWEEN '9/8/15 04:00:00' AND '9/15/15 13:59:59');
--30 rows

UPDATE reporting_allmatchemail
SET sess_id = 36567
WHERE id IN (SELECT id FROM reporting_allmatchemail WHERE partner_id = 2126 AND send_date BETWEEN '9/15/15 14:00:00' AND '2/14/16 14:00:00');
--21 rows

/*
select * from partners_session where partner_id = 2126 order by id desc limit 10;
select * from partners_session where partner_id = 2126 order by start desc limit 10;
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '8/18/15 04:00:00' and '9/8/15 3:59:59';
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '9/8/15 04:00:00' and '9/15/15 13:59:59';
select * from reporting_allmatchemail where partner_id = 2126 and send_date between '9/15/15 14:00:00' and '2/14/16 14:00:00';
select * from reporting_allmatchemail where sess_id = 36455;
select * from partners_session where id = 36455;
select * from partners_session where partner_id = 2126 order by id desc limit 10;
*/