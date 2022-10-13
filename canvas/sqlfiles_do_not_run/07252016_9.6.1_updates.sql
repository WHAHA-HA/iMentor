begin transaction;

update canvas_curriculum
set description = 'Treasure Hunters and Junk Collectors'
where id = 147;

update canvas_set
set description = 'Treasure Hunters and Junk Collectors'
where curriculum_id = 147;

/*
select * from canvas_curriculum where description ilike 'treasure%'
select * from canvas_set where curriculum_id = 147
select * from canvas_widget_content where html ilike '%Tell your mentor three things in your life that you feel good about and why.%'
select * from canvas_widget_content where id between 3015 and 3035
*/