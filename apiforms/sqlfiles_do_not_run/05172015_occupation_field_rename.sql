alter table iuser_user set occupation_id = 18 where occupation_id = 113;
alter table iuser_user set occupation_id = 106 where occupation_id = 151;
alter table iuser_user rename occupation_id to old_occupation_id;
alter table iuser_user rename career_id to old_career_id;
alter table iuser_user add column occupation_id default null;
alter table iuser_user add column career_id default null;
alter table iuser_user add constraint occupation_id_fk foreign key (occupation_id) references utils_occupation.id default null;
alter table iuser_user add constraint career_id_fk foreign key (career_id) references utils_career.id default null;
