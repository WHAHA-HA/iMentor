--We create indexes on the columns relevant to Mentee Enrollment.

CREATE INDEX mentee_readiness_school_user_id_idx ON mentee_readiness_school (user_id);
CREATE INDEX mentee_readiness_school_persona_id_idx ON mentee_readiness_school (persona_id);

