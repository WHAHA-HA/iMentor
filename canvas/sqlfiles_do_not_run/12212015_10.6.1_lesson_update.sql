--10.6.1 Lesson Update

begin transaction;

UPDATE canvas_widget_content
SET html = 'Your mentor has a “why”, too! Tell your mentor what you want to know about the “why” in their life. For example, how has their “why” affected their career or personal life?'
WHERE id IN (1189, 1196, 1204);

UPDATE canvas_widget_content_copy
SET html = 'Your mentor has a “why”, too! Tell your mentor what you want to know about the “why” in their life. For example, how has their “why” affected their career or personal life?'
WHERE parent_id IN (1189, 1196, 1204);

/*
select html from canvas_widget_content where id in (1189, 1196, 1204)
select html from canvas_widget_content limit 25
select distinct html from canvas_widget_content_copy where parent_id in (1189, 1196, 1204)
select html from canvas_widget_content_copy limit 25
*/