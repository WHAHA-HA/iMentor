--We create a table for college categories and their ordinals.

CREATE TABLE college_category (
	id integer NOT NULL PRIMARY KEY,
	ordinal integer NOT NULL DEFAULT 0,
	name VARCHAR NOT NULL DEFAULT 'NULL' UNIQUE
	);

CREATE SEQUENCE college_category_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER SEQUENCE college_category_id_seq OWNED BY college_category.id;

ALTER TABLE ONLY college_category ALTER COLUMN id SET DEFAULT nextval('college_category_id_seq'::regclass);
    
--We now add values to this table.

INSERT INTO college_category (id, ordinal, name) VALUES (0, 100, 'None');
INSERT INTO college_category (id, ordinal, name) VALUES (1, 300, 'Target');
INSERT INTO college_category (id, ordinal, name) VALUES (2, 200, 'Safety');
INSERT INTO college_category (id, ordinal, name) VALUES (3, 400, 'Reach');

--We finally relate the college_checklist table with this new table.

ALTER TABLE ONLY college_checklist ADD CONSTRAINT college_checklist_category FOREIGN KEY (category) REFERENCES college_category(id);