--We're making room for the featured image and additional text for the Portfolio.

ALTER TABLE canvas_unit_info
ADD COLUMN featured_image TEXT;

ALTER TABLE canvas_unit_info
ADD COLUMN secondary_description TEXT;