--We're updating the Smart Tag keys to work with the new Intake Application questions.

--$MatchQuestion1_1; for the mentee
UPDATE smarttags_smarttag
SET attribute = '%career%job%'
WHERE id = 69;

--$MatchQuestion1_2; for the mentor
UPDATE smarttags_smarttag
SET attribute = '%current%career%'
WHERE id = 70;

--$MatchQuestion1_3; for the mentor
UPDATE smarttags_smarttag
SET attribute = '%additional%work%'
WHERE id = 71;

--$MatchQuestion2_1; for the mentee and mentor
UPDATE smarttags_smarttag
SET attribute = '%major%college%'
WHERE id = 73;

--$MatchQuestion2_2; for the mentee and mentor
UPDATE smarttags_smarttag
SET attribute = '%projects%work%'
WHERE id = 74;

--$MatchQuestion3_4; for the mentee and mentor
UPDATE smarttags_smarttag
SET attribute = '%free%time%'
WHERE id = 80;

--$MatchQuestionAboutMe; for the mentee and mentor
UPDATE smarttags_smarttag
SET tag = '$MatchQuestionAboutMe;', attribute = '%about%yourself%'
WHERE id = 81;

/*
select * from smarttags_smarttag;
*/