alter table iuser_user drop column old_occupation_id;
alter table iuser_user drop column old_career_id;
ALTER TABLE ONLY utils_occupation ADD CONSTRAINT utils_occupation_career_id FOREIGN KEY (career_id) REFERENCES utils_career(id);
