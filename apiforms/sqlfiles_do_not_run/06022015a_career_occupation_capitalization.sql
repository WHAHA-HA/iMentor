UPDATE utils_career
SET name = initcap(name);

UPDATE utils_occupation
SET name = initcap(name);

UPDATE utils_occupation
SET name = 'Entertainment Business (Sports Management, Record Labels, etc.)'
WHERE id = 20;

UPDATE utils_occupation
SET name = 'School Administration (Principal, Superintendent, etc.)'
WHERE id = 52;

UPDATE utils_occupation
SET name = 'Civil Service (Post Office, Motor Vehicles, etc.)'
WHERE id = 71;

UPDATE utils_occupation
SET name = 'Politics, Political Parties, Legislative Branch (Federal and State)'
WHERE id = 78;

UPDATE utils_occupation
SET name = 'Law Enforcement and Criminal Justice'
WHERE id = 114;

UPDATE utils_occupation
SET name = 'Network and Systems Administrators'
WHERE id = 155;

UPDATE utils_occupation
SET name = 'Military / Armed Forces and Defense'
WHERE id = 77;

UPDATE utils_occupation
SET name = 'Private Tutor / Instructor (SAT Test Prep, etc.)'
WHERE id = 51;