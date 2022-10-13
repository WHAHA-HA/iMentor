UPDATE canvas_widget_content
SET html = 'Share a few thoughts with your mentee about their poem. What resonated with you? What would you like to learn more about? What are the similarities and differences you share?'
WHERE id = 653;

UPDATE canvas_widget_content_copy
SET html = 'Share a few thoughts with your mentee about their poem. What resonated with you? What would you like to learn more about? What are the similarities and differences you share?'
WHERE parent_id = 653;