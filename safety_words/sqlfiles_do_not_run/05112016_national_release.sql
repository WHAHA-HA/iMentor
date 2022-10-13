--We clear out the existing records, then run the Python script to add the latest records, based on the CSV.
--We maintain the safety_check_tracking table to avoid duplicate alerts.

begin transaction;

delete from safety_phrase *;
delete from safety_word_contact *;
delete from safety_word_source *;

/*
select * from safety_check_tracking
select * from safety_phrase
select * from safety_word_contact
select * from safety_word_source
*/