--Update these dates, based on information from R&E

begin transaction;

UPDATE program_year
SET end_datetime = '6/30/16 23:59:59'
WHERE id = 1;

UPDATE program_year
SET start_datetime = '7/1/16', end_datetime = '6/30/17 23:59:59'
WHERE id = 2;

/*
select * from program_year;
*/