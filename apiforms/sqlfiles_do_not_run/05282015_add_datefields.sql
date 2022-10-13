alter table forms_form_copy add column last_touched_datetime TIMESTAMP NOT NULL DEFAULT now();
alter table forms_form_copy add column started_datetime TIMESTAMP NOT NULL DEFAULT now();
