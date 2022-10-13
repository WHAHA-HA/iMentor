--We're making it possible to hide cards, which is important, as the curriculum changes.

ALTER TABLE canvas_widget_content
ADD COLUMN is_visible BOOLEAN NOT NULL DEFAULT TRUE;

/*
ALTER TABLE canvas_widget_content
DROP COLUMN is_visible;
*/