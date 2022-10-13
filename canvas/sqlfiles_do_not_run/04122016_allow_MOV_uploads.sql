begin transaction;

INSERT INTO file_upload_allow_list (file_extension)
VALUES ('.mov');

/*
select * from file_upload_allow_list order by id desc limit 10;
*/