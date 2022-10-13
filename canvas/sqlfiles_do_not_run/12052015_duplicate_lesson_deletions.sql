begin transaction;

delete from canvas_widget_content_marker_reference_copy where id in (
select
	cwcmrc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_content_user_response where id in (
select
	ccur.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_widget_content_response_marker_copy where id in (
select
	cwcrmc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_widget_content_response_marker_copy where id in (
select
	cwcrmc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_widget_content_copy where id in (
select
	cwcc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_widget_copy where id in (
select
	cwc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_app_copy where id in (
select
	cac.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
delete from canvas_set_copy where id in (
select
	csc.id
from canvas_set_copy as csc
join canvas_curriculum_copy as ccc on ccc.id = csc.curriculum_id
left outer join canvas_app_copy as cac on cac.canvas_set_id = csc.id
left outer join canvas_widget_copy as cwc on cwc.canvas_app_id = cac.id
left outer join canvas_widget_content_copy as cwcc on cwcc.widget_id = cwc.id
left outer join canvas_widget_content_response_marker_copy as cwcrmc on cwcrmc.widget_content_id = cwcc.id
left outer join canvas_widget_content_marker_reference_copy as cwcmrc on cwcmrc.widget_content_id = cwcc.id
left outer join canvas_content_user_response as ccur on ccur.marker_id = cwcrmc.id
where csc.id in (
107315,
15711,
8893,
64173,
68638,
106780,
90370,
99192,
62868,
18089,
14720,
6544,
107333,
7141
)
);
--1 row. 1 affected.

delete from canvas_curriculum_copy
where id in (
108188,
15992,
9051,
64992,
69482,
107651,
91216,
100055,
63681,
18411,
14967
);
--1 row. 1 affected.

update canvas_set_copy
set end_datetime = '2015-11-09 15:10:59'
where id = 64172;
--1 row. 1 affected.

update canvas_set_copy
set end_datetime = '2016-05-01 16:16:00'
where id = 107332;
--1 row. 1 affected.

update canvas_curriculum_copy
set end_datetime = '2016-05-01 16:16:00'
where id = 108184;
--1 row. 1 affected.

/*
select
	user_id,
	persona_id,
	parent_id,
	count(*)
from canvas_curriculum_copy
group by
	user_id,
	persona_id,
	parent_id
having count(*) > 1;

select
	user_id,
	persona_id,
	parent_id,
	count(*)
from canvas_set_copy
group by
	user_id,
	persona_id,
	parent_id
having count(*) > 1;

select * from canvas_curriculum_copy where user_id = 159254 and parent_id = 30
select * from canvas_set_copy where curriculum_id in (14968,14967)
select * from canvas_set_copy where user_id = 154269 and parent_id = 26
select * from canvas_curriculum_copy where id = 7280
select email, member_id from iuser_user where id = 179170
select * from canvas_content_user_response where user_id = 155417
select * from canvas_set_copy where user_id = 179170 order by end_datetime desc

rollback
commit

affected user ids for canvas_curriculum_copy:
173507
155417
156522
160551
177593
171487
176637
180711
180654
136158
159254

affected user ids for canvas_set_copy:
164974
179170
154269
*/