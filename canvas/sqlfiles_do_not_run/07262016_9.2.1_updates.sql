begin transaction;

update canvas_widget_content
set html = 'How will you build a healthy relationship with your mentor? Share your thoughts with your mentor by answering the following questions:<ul><li>What activities can you and your mentor do together to build your relationship?</li><li>What disappoints and frustrates you most in your relationships?</li><li>What can you and your mentor do to avoid them?</li></ul>'
where id in (769, 774);

/*
select * from canvas_widget_content where html ilike 'How will you build a healthy relationship with your mentor? Share your thoughts with your mentor by answering the following questions:%'
*/