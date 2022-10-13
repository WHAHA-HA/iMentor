begin transaction;
commit
UPDATE utils_college
SET alias = 'university of california-chico|csu chico'
WHERE id = 985;

UPDATE utils_college
SET alias = 'cal state east bay|california state university-east bay|csu east bay'
WHERE id = 987;

UPDATE utils_college
SET alias = 'california state university-fresno|csu fresno'
WHERE id = 988;

UPDATE utils_college
SET alias = 'cal state fullerton|california state university-fullerton|csu fullerton'
WHERE id = 989;

UPDATE utils_college
SET alias = 'cal state long beach|california state university-long beach|csu long beach'
WHERE id = 990;

UPDATE utils_college
SET alias = 'california state university-los angeles|csu los angeles'
WHERE id = 991;

UPDATE utils_college
SET alias = 'cma|california maritime academy|csu maritime academy'
WHERE id = 981;

UPDATE utils_college
SET alias = 'california state university-northridge|csu northridge'
WHERE id = 24;

/*
select id, name, alias from utils_college where name ilike '%northridge%'
*/