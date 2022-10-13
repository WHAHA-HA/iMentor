--Delete a silly picture as per Zendesk 3513

begin transaction;

DELETE FROM conversation * WHERE id = 30740;

/*
select * from conversation where id = 30740
*/