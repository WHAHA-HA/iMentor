DROP TABLE IF EXISTS br_temp_joey_scrubbed_cell_1;

SELECT
	id AS "user_id",
	cell_phone AS "original_cell",
	REGEXP_REPLACE(cell_phone, '^[1]', '', 'g') AS "scrubbed_cell_1"
INTO br_temp_joey_scrubbed_cell_1
FROM iuser_user
WHERE member_id = 1
	AND status IN ('A','SI','AI');

DROP TABLE IF EXISTS br_temp_joey_scrubbed_cell_2;

SELECT
	user_id,
	original_cell,
	REGEXP_REPLACE(scrubbed_cell_1, '[ )(-.]', '', 'g') AS "scrubbed_cell_2"
INTO br_temp_joey_scrubbed_cell_2
FROM br_temp_joey_scrubbed_cell_1;

DROP TABLE IF EXISTS br_temp_joey_scrubbed_cell_3;

SELECT
	user_id,
	original_cell,
	REGEXP_REPLACE(scrubbed_cell_2, '[A-Za-z]', '', 'g') AS "scrubbed_cell_3"
INTO br_temp_joey_scrubbed_cell_3
FROM br_temp_joey_scrubbed_cell_2;

DROP TABLE IF EXISTS br_temp_joey_scrubbed_cell_4;

SELECT
	user_id,
	original_cell,
	(CASE
		WHEN CHAR_LENGTH(scrubbed_cell_3) != 10 THEN NULL
		ELSE scrubbed_cell_3
		END) AS "scrubbed_cell_4"
INTO br_temp_joey_scrubbed_cell_4
FROM br_temp_joey_scrubbed_cell_3;

select * from br_temp_joey_scrubbed_cell_4 limit 10;