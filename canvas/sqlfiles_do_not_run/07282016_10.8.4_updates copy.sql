begin transaction;

update canvas_widget_content
set html = 'Although the college process may feel far away, the process for getting ready starts now. The skills needed to graduate from high school ready to succeed in college, are skills that need to be built and improved over time.<p><p>In this lesson, your mentee explored one definition of college readiness. Review that definition below the images.</p></p>'
where id = 2964;

/*
select * from canvas_widget_content where html ilike '%In this lesson, your mentee explored one definition of college readiness.%'
select * from canvas_widget_content where id between 2953 and 2975
*/