begin transaction;

DELETE FROM conversation *
WHERE id IN (
	SELECT id
	FROM (
		SELECT
			id,
			ROW_NUMBER() OVER (PARTITION BY user_id, recipient_user_id, "data" ORDER BY id ASC) AS rnum
		FROM conversation
	) x
	WHERE x.rnum > 1
);

/*
select * from conversation where id in (
SELECT id
FROM (SELECT id,
	     ROW_NUMBER() OVER (partition BY user_id, recipient_user_id, data ORDER BY id asc) AS rnum
     FROM conversation) t
WHERE t.rnum > 1
);

SELECT id, rnum
FROM (SELECT id,
	     ROW_NUMBER() OVER (partition BY user_id, recipient_user_id, data ORDER BY id asc) AS rnum
     FROM conversation) t
WHERE t.rnum > 1

select * from conversation where id = 12086
select * from conversation where user_id = 173894 and recipient_user_id = 179805

SELECT
	user_id,
	recipient_user_id,
	data,
	COUNT(*)
FROM conversation
GROUP BY
	user_id,
	recipient_user_id,
	data
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

select * from conversation;
*/