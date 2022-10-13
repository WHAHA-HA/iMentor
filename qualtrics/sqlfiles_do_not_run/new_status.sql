update qualtrics_invite set survey_status = 5 where survey_status = 3 and survey_id not in (15,16);
