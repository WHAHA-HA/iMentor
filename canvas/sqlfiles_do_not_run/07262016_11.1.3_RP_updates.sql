begin transaction;

update canvas_widget_content
set html = 'Respond to your mentor. Use the following questions to help you get started:<ul><li>What is 1 thing that resonated with you? Why?</li><li>What is 1 thing you agree/disagree with? Why?</li><li>What are 2 clarifying questions you have about what they shared?</li></ul>'
where id in (271, 274);

/*
select * from canvas_widget_content where html ilike '%Your mentor shared their own experiences with strong culture%'
select * from canvas_widget_content where id between 268 and 278
*/