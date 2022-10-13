--10.4.1 updates

begin transaction;

update canvas_widget_content
set html = 'This lesson introduces the importance of reflection as a part of the growth and learning process.<p><p>In this lesson, mentees will:<ul><li>Read an article to define "reflection", identify its role and significance in the learning process, and discuss different methods of reflecting</li><li>Identify and discuss its role in the program and their relationship with their mentor</li><li>Reflect in Conversations</li></ul></p></p>'
where id = 1741;

update canvas_widget_content
set html = 'If you need a refresher on what Conversations is and how you should use it, please watch the video below:'
where id in (1747, 1752);

update canvas_widget_content
set url = 'https://vimeo.com/156582313'
where id in (1748, 1753);

update canvas_widget_content
set html = 'Now that you’ve shared the importance of reflecting with your mentor, let’s share an actual reflection with your mentor  in Conversations.<ol><li>What is something you’ve excelled at this year?</li><li>What did you do to get really good at this thing?</li><li>Can you apply similar strategies to something you are currently struggling with?</li></ol><p><p>Note: You can access Conversations through the icon at the top right of your screen.</p></p>'
where id in (1749, 1754);

update canvas_widget_content
set html = 'This lesson is all about reflection: what it is, why it is important, and what role it can play in your relationship. Learn more about reflection and the iMentor curriculum <a href=“https://learn.imentor.org/help/article/link/reflection-and-the-imentor-curriculum” target=“_blank”>here</a>.<p><p>Your mentee discussed the role of reflection in learning before writing write a reflection in <a href=“http://learn.imentor.org/help/article/link/welcome-to-conversations” target=“_blank”>Conversations</a>.</p></p>'
where id = 1755;

update canvas_widget_content
set html = 'If you haven’t already, open Conversations and read and respond to your mentee’s reflection before moving on with the rest of this lesson.<p><p>Note: You can access Conversations through the icon on the top right of your screen.</p></p>'
where id = 1756;

/*
select id, url, html from canvas_widget_content where id between 1741 and 1759
*/