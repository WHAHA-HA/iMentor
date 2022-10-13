begin transaction;

WITH updated_links AS (
	select
		cwc.id as "widget_content_id",
		cwc.html as "original_html",
		regexp_replace(cwc.html, 'learn.imentor.org', 'staff.imentor.org', 'g') as "new_html"
	from canvas_set as cs
	join canvas_app as ca on ca.canvas_set_id = cs.id
	join canvas_widget as cw on cw.canvas_app_id = ca.id
	join canvas_widget_content as cwc on cwc.widget_id = cw.id
	where cwc.html ilike '%learn.imentor.org%'
		and cs.role = 1
    )
UPDATE canvas_widget_content AS cwc
SET html = ul.new_html
FROM updated_links AS ul
WHERE cwc.id = ul.widget_content_id;
--310 rows. 310 affected.

begin transaction;

WITH updated_links AS (
	select
		cwcc.id as "widget_content_id",
		cwcc.html as "original_html",
		regexp_replace(cwcc.html, 'learn.imentor.org', 'staff.imentor.org', 'g') as "new_html"
	from canvas_set_copy as csc
	join canvas_app_copy as cac on cac.canvas_set_id = csc.id
	join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
	join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
	where cwcc.html ilike '%learn.imentor.org%'
		and csc.role = 1
    )
UPDATE canvas_widget_content_copy AS cwcc
SET html = ul.new_html
FROM updated_links AS ul
WHERE cwcc.id = ul.widget_content_id;
--9075 rows. 9075 affected.

/*
select
	cwc.id,
	cwc.html as "original_html",
	regexp_replace(cwc.html, 'learn.imentor.org', 'staff.imentor.org', 'g') as "new_html"
from canvas_set as cs
join canvas_app as ca on ca.canvas_set_id = cs.id
join canvas_widget as cw on cw.canvas_app_id = ca.id
join canvas_widget_content as cwc on cwc.widget_id = cw.id
where cwc.html ilike '%learn.imentor.org%'
	and cs.role = 1

select
	cwcc.id,
	cwcc.html as "original_html",
	regexp_replace(cwcc.html, 'learn.imentor.org', 'staff.imentor.org', 'g') as "new_html"
from canvas_set_copy as csc
join canvas_app_copy as cac on cac.canvas_set_id = csc.id
join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
where cwcc.html ilike '%learn.imentor.org%'
	and csc.role = 1

select id, url from canvas_widget_content where url ilike '%learn.imentor.org%'
select id, url from canvas_widget_content_copy where url ilike '%learn.imentor.org%'

select html from canvas_widget_content where id = 1
<img src="/new_platform/static/canvas/images/read_old.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It exposes them to program goals, expectations, and common vocabulary they will experience throughout the program: PC, Mentor, Mentee, Relationship, Goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Explain a summary of the iMentor program</li><li>Set specific goals for this year</li><li>Describe the role of the PC</li><li>Describe the role of the Mentor</li><li>Describe the role of the Mentee</li><li>Illustrate the different relationships that exist between the PC, the Mentee, and the Mentor</li></ul></p></p>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/1111---building-relationships---welcome-to-imentor" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/read_old.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It exposes them to program goals, expectations, and common vocabulary they will experience throughout the program: PC, Mentor, Mentee, Relationship, Goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Explain a summary of the iMentor program</li><li>Set specific goals for this year</li><li>Describe the role of the PC</li><li>Describe the role of the Mentor</li><li>Describe the role of the Mentee</li><li>Illustrate the different relationships that exist between the PC, the Mentee, and the Mentor</li></ul></p></p>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/1111---building-relationships---welcome-to-imentor" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/read_old.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It exposes them to program goals, expectations, and common vocabulary they will experience throughout the program: PC, Mentor, Mentee, Relationship, Goals.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Explain a summary of the iMentor program</li><li>Set specific goals for this year</li><li>Describe the role of the PC</li><li>Describe the role of the Mentor</li><li>Describe the role of the Mentee</li><li>Illustrate the different relationships that exist between the PC, the Mentee, and the Mentor</li></ul></p></p>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/1111---building-relationships---welcome-to-imentor" target="_blank">here</a>.

select html from canvas_widget_content where id = 3239
<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://staff.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://staff.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.

select html from canvas_widget_content_copy where id = 1
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It familiarizes them with program goals, expectations, and common vocabulary they will use throughout the program.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define what a mentor is</li><li>Articulate the goals and purpose of the program</li><li>Describe the role of program participants:<ul style="list-style-type: circle"><li>mentee</li><li>mentor</li><li>staff</li></ul><li>Illustrate the purpose of the program and different relationships that exist between program staff, mentee, and mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/building-relationships-refresh-and-reconnect-10" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It familiarizes them with program goals, expectations, and common vocabulary they will use throughout the program.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define what a mentor is</li><li>Articulate the goals and purpose of the program</li><li>Describe the role of program participants:<ul style="list-style-type: circle"><li>mentee</li><li>mentor</li><li>staff</li></ul><li>Illustrate the purpose of the program and different relationships that exist between program staff, mentee, and mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/building-relationships-refresh-and-reconnect-10" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />This lesson introduces new mentees to the iMentor program. It familiarizes them with program goals, expectations, and common vocabulary they will use throughout the program.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Define what a mentor is</li><li>Articulate the goals and purpose of the program</li><li>Describe the role of program participants:<ul style="list-style-type: circle"><li>mentee</li><li>mentor</li><li>staff</li></ul><li>Illustrate the purpose of the program and different relationships that exist between program staff, mentee, and mentor</li></ul></p></p><b>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/building-relationships-refresh-and-reconnect-10" target="_blank">here</a>.

select html from canvas_widget_content_copy where id = 1860550
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />By utilizing an asset-based approach, this lesson will ask mentees to consider what they've done so far that might make it onto their resume, i.e. good grades, extracurricular activities, community involvement, etc.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create a first draft of their resume</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/career-exploration-and-college-readiness-starting-my-resume" target="_blank">here</a>.</b>
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />By utilizing an asset-based approach, this lesson will ask mentees to consider what they've done so far that might make it onto their resume, i.e. good grades, extracurricular activities, community involvement, etc.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Create a first draft of their resume</li></ul></p></p><b>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/career-exploration-and-college-readiness-starting-my-resume" target="_blank">here</a>.</b>

select html from canvas_widget_content_copy where id = 1875389
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In the final lesson, mentees will write a thank you card to their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Appreciate each other and staff member.</li><li>Create a thank you card to their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://learn.imentor.org/help/article/link/thank-you-9" target="_blank">here</a>.</b>
<img src="/new_platform/static/canvas/images/remember.png" style="float:right;" />In the final lesson, mentees will write a thank you card to their mentors.<p><p>At the end of this lesson, mentees will be able to:<ul><li>Appreciate each other and staff member.</li><li>Create a thank you card to their mentors.</li></ul></p></p><b>For the complete lesson, click <a href="https://staff.imentor.org/help/article/link/thank-you-9" target="_blank">here</a>.</b>

select html from canvas_widget_content_copy where id = 54469
<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://learn.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.
<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />Display the following slideshow to facilitate the lesson. For instructions on editing the slideshow, click <a href="https://staff.imentor.org/help/article/link/editing-slide-presentations" target="_blank">here</a>.
*/