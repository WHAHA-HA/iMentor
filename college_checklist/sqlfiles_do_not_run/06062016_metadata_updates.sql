begin transaction;

UPDATE utils_college
SET alias = 'university of california-santa cruz|uc santa cruz'
WHERE id = 162;

UPDATE utils_college
SET alias = 'ucla|university of california-los angeles|university of california los angeles'
WHERE id = 163;

/*
select id, name, alias from utils_college where name ilike '%cali%los%ang%'
select id, name, alias from utils_college where alias ilike '%ucla%'
*/