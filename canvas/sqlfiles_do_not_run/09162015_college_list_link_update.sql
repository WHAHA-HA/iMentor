--We updated the links to the List page of the College Checklist.

UPDATE canvas_widget_content
SET html = 'Now review your mentee''s college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE id = 451;

UPDATE canvas_widget_content
SET html = 'Today, you will be finishing your college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE id = 489;

UPDATE canvas_widget_content
SET html = 'Today, you will be finishing your college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE id = 490;

UPDATE canvas_widget_content_copy
SET html = 'Now review your mentee''s college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE parent_id = 451;

UPDATE canvas_widget_content_copy
SET html = 'Today, you will be finishing your college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE parent_id = 489;

UPDATE canvas_widget_content_copy
SET html = 'Today, you will be finishing your college list <a href="/cchklist/list/" target="_blank">here</a>.'
WHERE parent_id = 490;