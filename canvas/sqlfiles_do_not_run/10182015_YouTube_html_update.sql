UPDATE canvas_widget_content
SET html = '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.'
WHERE id = 294;

UPDATE canvas_widget_content_copy
SET html = '<img src="/new_platform/static/canvas/images/display.png" style="float:right;" />If YouTube is unavailable to be streamed at your school, use the below video, which is streamed from Vimeo.'
WHERE parent_id = 294;