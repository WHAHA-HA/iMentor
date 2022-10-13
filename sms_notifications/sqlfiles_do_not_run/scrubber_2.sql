drop table if exists temp_nyc_phone_backup;select id, email, cell_phone, home_phone, work_phone into temp_nyc_phone_backup from iuser_user where member_id = 1 and status = 'A';

create or replace function remove_nonnumeric(text)
RETURNS text AS
$$
 select regexp_replace($1,E'[^0-9]','','gs');
$$
LANGUAGE SQL;

create or replace function remove_leading_one(text)
RETURNS text AS
$$
 select regexp_replace($1,E'^1','','gs');
$$
LANGUAGE SQL;

update iuser_user set home_phone = remove_leading_one(remove_nonnumeric(home_phone)),
cell_phone = remove_leading_one(remove_nonnumeric(cell_phone)),
work_phone = remove_leading_one(remove_nonnumeric(work_phone));

