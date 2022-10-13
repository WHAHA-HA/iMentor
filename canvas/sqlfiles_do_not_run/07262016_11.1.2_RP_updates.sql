begin transaction;

update canvas_widget_content
set html = '<ul><li>Why is having a motto and norms important for the class?</li><li>What is the class motto that was created?</li><li>Does the class motto also work for your relationship with your mentor? What would you add or remove from that motto to make it work for you and your mentor?</li><li>How can your mentor help create this culture?</li></ul>'
where id in (186, 193);

update canvas_widget_content
set html = 'Consider the following:<ul><li>What do you think are the most important things for building culture?</li><li>Does your class or school currently have any of these in place?</li><li>Where else might you have experienced strong culture as defined in this article?</li></ul>'
where id in (183, 190);

/*
select * from canvas_widget_content where html ilike '%Which 2-3 of the 10 ingredients%'
select * from canvas_widget_content where id between 180 and 193
*/