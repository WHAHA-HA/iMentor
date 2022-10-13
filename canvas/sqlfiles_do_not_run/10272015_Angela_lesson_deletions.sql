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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
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
where csc.parent_id in (
15
,18
,27
,24
,47
,35
,120
,123
)
	and csc.persona_id = 99880
);
--45 rows. 8 affected.

begin transaction;

delete from canvas_curriculum_copy
where parent_id in (
7
,12
,17
,22
,46
,47
,8
,13
)
	and persona_id = 99880;
--8 rows.

/*
select id, email, first_name, last_name, member_id, status from iuser_user
where
	first_name ilike 'Angela%'
	and last_name ilike 'Reed%'
	--and member_id = 1;
select id, email, first_name, last_name, member_id, status from iuser_user where email ilike 'SuejeanBlue@imentor.com'

select * from canvas_curriculum_copy where user_id = 149851 order by grade_id, unit_id, curriculum_number asc
select * from canvas_set_copy where user_id = 149851 and curriculum_id in (
51
,7583
,12595
,22016
,25302
,41888
,561
,1883
)

select * from canvas_set_copy where id = 27274
select partner_id from iuser_persona_partners where persona_id = 95521
select id, name from partners_partner where id = 2424
*/