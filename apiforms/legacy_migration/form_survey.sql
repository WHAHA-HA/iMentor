SELECT
    sa.persona_id AS "Persona ID",
    ss.id AS "Survey ID",
    ss.name AS "Survey Name",
    ss.type AS "Survey Type",
    ss.status AS "Survey Status",
    ss.member_id AS "Survey for Member ID",
    ss.close_date AS "Survey Close Date",
    ssq.id AS "Question ID",
    ssq.text AS "Question Text",
    ssq.order AS "Question Ordinal",
    ssq.active AS "Question Active",
    ssq.hidden AS "Question Hidden",
    ssa.text AS "Answer Text",
    ssa.active AS "Answer Active",
    ssa.hidden AS "Answer Hidden",
    ssa.order AS "Answer Ordinal",
    sr.answer_id AS "Answer Id",
    sr.text AS "Answer Text"
FROM survey_answerresult AS sa
JOIN iuser_persona AS ip ON ip.id = sa.persona_id
JOIN iuser_user AS iu ON iu.id = ip.user_id
JOIN survey_result AS sr ON sr.id = sa.result_id
JOIN survey_surveyanswer AS ssa ON ssa.id = sr.answer_id
JOIN survey_survey AS ss ON ss.id = sa.survey_id
JOIN survey_surveyquestion AS ssq ON ssq.id = sa.question_id
WHERE ss.member_id = 1
    AND (ss.name ILIKE '%Mentor Eval%'
        OR ss.name ILIKE '%Mentor Matching%'
        OR ss.name ILIKE '%Reference%')
LIMIT 1000; 
