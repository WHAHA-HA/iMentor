DELETE FROM portfolio_reflection_user_response *
WHERE id IN (
    SELECT DISTINCT ON (user_id)
	    NTH_VALUE(id, 1) OVER x AS "id"
    FROM portfolio_reflection_user_response
    WHERE reflection_user_details_id IN (
        SELECT
            reflection_user_details_id
        FROM portfolio_reflection_user_response
        GROUP BY
            user_id,
            reflection_user_details_id
        HAVING COUNT(*) > 1
    )
    WINDOW x AS (PARTITION BY user_id ORDER BY words ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
);

/*
SELECT
    user_id,
    reflection_user_details_id,
    COUNT(*)
FROM portfolio_reflection_user_response
GROUP BY
    user_id,
    reflection_user_details_id
HAVING COUNT(*) > 1;

select * from portfolio_reflection_user_response where user_id = 163187 and reflection_user_details_id = 2942
select * from portfolio_reflection_user_details where id = 12385
select email, member_id from iuser_user where id = 165063
select url_name from member_member where id = 195
*/