--Use a JPG instead of a PDF for this infographic.

UPDATE canvas_widget_content
SET URL = '/new_platform/static/canvas/images/FAFSA_Infographic.jpg', content_type = 9
WHERE id IN (2149,2157,2163);

UPDATE canvas_widget_content_copy
SET URL = '/new_platform/static/canvas/images/FAFSA_Infographic.jpg', content_type = 9
WHERE parent_id IN (2149,2157,2163);