--We remove any orphan curriculum records, ie Canvas curriculum records without a corresponding Canvas set record.

begin transaction;

DELETE FROM canvas_curriculum_copy *
WHERE id IN (
	SELECT
		cc.id
	FROM canvas_curriculum_copy AS cc
	LEFT OUTER JOIN canvas_set_copy AS cs ON cs.curriculum_id = cc.id
	WHERE cc.grade_id IS NOT NULL --We ignore sample lessons without any grade.
		AND cs.id IS NULL
	);
--29 rows. 29 affected.

/*
select * from canvas_curriculum_copy where id = 33278
select * from canvas_curriculum_copy where user_id = 166668
select * from canvas_set_copy where user_id = 166668
select first_name, last_name, email, member_id from iuser_user where id = 166668

SELECT
	cc.id
FROM canvas_curriculum_copy AS cc
LEFT OUTER JOIN canvas_set_copy AS cs ON cs.curriculum_id = cc.id
WHERE cc.grade_id IS NOT NULL --We ignore sample lessons without any grade.
	AND cs.id IS NOT NULL
--62681 rows before. 62681 rows after.
*/