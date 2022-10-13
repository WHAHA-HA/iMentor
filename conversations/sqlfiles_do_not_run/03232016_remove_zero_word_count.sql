begin transaction;

DELETE FROM conversation * WHERE word_count = 0 AND data = '';
--37 rows. 37 affected.

/*
select count(*) from conversation where word_count = 0;
select id, data, word_count from conversation where word_count = 0 and data != '';
select id, data, word_count from conversation where word_count = 0;
select data from conversation order by id desc limit 50;
*/