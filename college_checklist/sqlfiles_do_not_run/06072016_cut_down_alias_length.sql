begin transaction;

WITH updated_alias AS (
	select
		id as "college_id",
		left(alias, 500) as "new_alias"
	from utils_college
    )
UPDATE utils_college AS uc
SET alias = ua.new_alias
FROM updated_alias AS ua
WHERE uc.id = ua.college_id;
--4896 rows. 4896 affected.

/*
select length(alias), alias from utils_college order by length(alias) desc
select alias from utils_college where id = 2167
inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter amer
inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter amer
inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter american university of puerto rico-guayama|inter amer

select alias from utils_college where id = 24
california state university-northridge|csu northridge
california state university-northridge|csu northridge
california state university-northridge|csu northridge
*/