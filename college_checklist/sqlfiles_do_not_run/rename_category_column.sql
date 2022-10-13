alter table college_checklist rename category to category_id;
alter table college_checklist alter column category_id drop not null;
