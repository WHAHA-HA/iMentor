ALTER TABLE iuser_racialgroup
	ADD COLUMN ordinal INTEGER;

UPDATE iuser_racialgroup SET (ordinal) = (100) WHERE id = 10;
UPDATE iuser_racialgroup SET (ordinal) = (200) WHERE id = 11;
UPDATE iuser_racialgroup SET (ordinal) = (300) WHERE id = 15;
UPDATE iuser_racialgroup SET (ordinal) = (400) WHERE id = 16;
UPDATE iuser_racialgroup SET (ordinal) = (500) WHERE id = 9;
UPDATE iuser_racialgroup SET (ordinal) = (600) WHERE id = 12;
UPDATE iuser_racialgroup SET (ordinal) = (700) WHERE id = 13;