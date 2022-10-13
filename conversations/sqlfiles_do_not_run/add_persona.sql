--alter table conversation add column persona_id INTEGER NOT NULL default 0;
--alter table conversation add column recipient_persona_id INTEGER NOT NULL default 0;
alter table conversation add constraint conversation_fkey_persona FOREIGN KEY(persona_id) REFERENCES iuser_persona (id);
alter table conversation add constraint conversation_fkey_recipient_persona FOREIGN KEY(recipient_persona_id) REFERENCES iuser_persona (id);
