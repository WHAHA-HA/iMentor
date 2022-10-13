begin transaction;

--9.8.1 Mentee Lesson

update canvas_widget_content
set html = 'Take a moment to use Conversations and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?'
where id in (3150, 3152);

--11.7.1 Mentee Lesson

update canvas_widget_content
set html = 'Take a moment to use Conversations and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?<p><p>Note: Conversations is available through the icon in the top right corner of this page.</p></p>'
where id in (2510, 2513);

--12.6.1 Staff and Mentee Lesson

update canvas_widget_content
set html = '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson will help mentees identify which standardized test they need to take, when they need to take it, and how to acquire prep support if they haven''t already.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Compare and contrast SAT vs ACT</li><li>Register for ACT or SAT (optional)</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/exam-prep" target="_blank">here</a>.</b>'
where id = 2468;

update canvas_widget_content
set html = 'Take a moment to use Conversations and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?<p><p>Note: Conversations is available through the icon in the top right corner of this page.</p></p>'
where id in (2472, 2477);

--12.7.1 Staff and Mentee Lesson

update canvas_widget_content
set html = '<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces mentees to strategies for how to be successful in college.<p><p>In this lesson, mentees will:<ul><li>Read and discuss an article that describes nine tips for succeeding in college</li><li>Apply their understanding of the strategies to create definitions, taglines, and images to help them and their peers retain the information</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/succeeding-in-college" target="_blank">here</a>.</b>'
where id = 2680;

update canvas_widget_content
set html = 'Take a moment to use Conversations and reflect on all you’ve accomplished. Can you pick out your favorite moment from each unit?<p><p>Note: Conversations is available through the icon in the top right corner of this page.</p></p>'
where id in (2684, 2689);

/*
select id, url, html from canvas_widget_content where html ilike '%Can you pick out your favorite moment from each unit?%'
select id, url, html from canvas_widget_content where html ilike '%This lesson introduces mentees to strategies for how to be successful in college.%'
select id, url, html from canvas_widget_content where id between 2680 and 2700
*/