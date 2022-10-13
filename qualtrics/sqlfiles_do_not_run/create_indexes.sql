--We create indexes on the columns relevant to our new surveys.

CREATE INDEX qualtrics_invite_persona_id_idx ON qualtrics_invite (persona_id);
CREATE INDEX qualtrics_invite_user_id_idx ON qualtrics_invite (user_id);
CREATE INDEX qualtrics_invite_invited_by_user_id_idx ON qualtrics_invite (invited_by_user_id);
CREATE INDEX qualtrics_invite_survey_id_idx ON qualtrics_invite (survey_id);
CREATE INDEX qualtrics_invite_date_invited_idx ON qualtrics_invite (date_invited);
CREATE INDEX qualtrics_invite_last_modified_idx ON qualtrics_invite (last_modified);

CREATE INDEX qualtrics_survey_member_id_idx ON qualtrics_survey (member_id);
CREATE INDEX qualtrics_survey_start_date_idx ON qualtrics_survey (start_date);
CREATE INDEX qualtrics_survey_end_date_idx ON qualtrics_survey (end_date);

CREATE INDEX qualtrics_surveys_start_date_idx ON qualtrics_surveys (start_date);
CREATE INDEX qualtrics_surveys_end_date_idx ON qualtrics_surveys (end_date);

