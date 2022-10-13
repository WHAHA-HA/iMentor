SELECT
    user_id,
    academicfield_id,
    COUNT(*)
FROM iuser_user_academic_fields
GROUP BY
    user_id,
    academicfield_id
HAVING COUNT(*) > 1;