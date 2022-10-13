--Correct one error in partners_session from a bad scheduling attempt that led to overlapping dates

UPDATE partners_session
SET end_date = '2015-09-02 12:26:59-04'
WHERE id = 36354;