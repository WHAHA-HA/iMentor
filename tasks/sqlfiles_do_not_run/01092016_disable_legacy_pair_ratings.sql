--We're disabling legacy pair ratings to prepare for new pair ratings in Tasks.

begin transaction;

UPDATE ratings_ratinginterval
SET active = FALSE;
--649 expected. 649 affected.

UPDATE ratings_ratingdefaults
SET active = FALSE;
--12 expected. 12 affected.

/*
select * from ratings_ratinginterval where partner_id = 877 --ACHS '13 Class 1
select * from ratings_ratinginterval
select * from ratings_ratingdefaults
*/