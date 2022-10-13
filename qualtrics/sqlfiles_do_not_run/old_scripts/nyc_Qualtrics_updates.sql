INSERT INTO qualtrics_ids
VALUES (125, 1, 'iMentor NYC', 'GR_72qpYD0dtt1P9uR', 'ML_0N6QUUXKYvv0zYx', '5jBNVBv8z9ZGqQR', 'SV_57um2DKBY44XSp7', NULL, NULL, NULL, 'mentee');

INSERT INTO qualtrics_ids
VALUES (126, 1, 'iMentor NYC', 'GR_72qpYD0dtt1P9uR', 'ML_0N6QUUXKYvv0zYx', NULL, 'SV_3Vmg9TSjpyM8yY5', NULL, NULL, 'ekP3lwYPlwq8Kz3', 'mentor');

UPDATE qualtrics_ids
SET member_name = 'iMentor NYC'
WHERE member_id = 1;

UPDATE qualtrics_ids
SET member_name = 'iMentor Chicago'
WHERE member_id = 244;