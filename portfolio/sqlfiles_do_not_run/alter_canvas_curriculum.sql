--We're making room for the featured image and additional text for the Portfolio.

ALTER TABLE canvas_curriculum
ADD COLUMN featured_image TEXT;

ALTER TABLE canvas_curriculum
ADD COLUMN secondary_description TEXT;