alter table mentee_readiness_school add column persona_id integer default null;
alter table mentee_readiness_school add constraint mrs_persona_id_fk foreign key (persona_id) references iuser_persona (id);
alter table mentee_readiness_school add constraint mrs_user_id UNIQUE (user_id);
