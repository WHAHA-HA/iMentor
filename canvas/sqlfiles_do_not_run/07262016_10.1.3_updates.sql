begin transaction;

update canvas_widget_content
set html = '<ul><li>Share 2-3 norms or expectations that resonate with you most.</li><li>Why do these particular norms stand out to you? How can you personally be a leader in bringing these norms to life in your classroom? In your life outside of this classroom?</li><li>Ask your mentor how he/she has applied these norms in his/her professional and social lives.</li></ul>'
where id in (239, 244);

update canvas_widget_content
set html = 'Here are the norms that resonated most with your mentee:'
where id = 250;

update canvas_widget_content
set html = 'Tell your mentee what you think about the norms they wrote about. Share a few norms at home or at work that contribute to the culture of that space.'
where id = 251;

/*
select * from canvas_widget_content where html ilike 'Here are the norms%'
select * from canvas_widget_content where id between 249 and 252
*/