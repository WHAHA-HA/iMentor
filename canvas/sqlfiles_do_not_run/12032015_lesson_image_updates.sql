begin transaction;

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/10.5.1.jpg'
WHERE id = 105;

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/10.5.2.jpg'
WHERE id = 106;

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/12.5.3.jpg'
WHERE id = 101;

UPDATE canvas_curriculum
SET featured_image = '/new_platform/static/canvas/images/11.5.1.jpg'
WHERE id = 92;

/*
select * from canvas_curriculum where id in (102,103)
select * from canvas_unit_info where id = 6
*/