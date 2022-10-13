ALTER TABLE ONLY iuser_user ADD COLUMN work_lat NUMERIC(11,7) default null;
ALTER TABLE ONLY iuser_user ADD COLUMN work_long NUMERIC(11,7) default null;
ALTER TABLE ONLY iuser_user ADD COLUMN home_lat NUMERIC(11,7) default null;
ALTER TABLE ONLY iuser_user ADD COLUMN home_long NUMERIC(11,7) default null;
ALTER TABLE ONLY member_member ADD COLUMN member_long NUMERIC(11,7) default null;
ALTER TABLE ONLY member_member ADD COLUMN member_lat NUMERIC(11,7) default null;
ALTER TABLE ONLY partners_partner ADD COLUMN partner_long NUMERIC(11,7) default null;
ALTER TABLE ONLY partners_partner ADD COLUMN partner_lat NUMERIC(11,7) default null;
