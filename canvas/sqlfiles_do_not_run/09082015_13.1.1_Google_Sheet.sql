--We're updating the URL to the 13.1.1 Google Sheet to use the "sharing" link, which allows us to create a personalized copy.

UPDATE canvas_widget_content
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE id = 287;

UPDATE canvas_widget_content_copy
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE parent_id = 287;

UPDATE canvas_widget_content
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE id = 346;

UPDATE canvas_widget_content_copy
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE parent_id = 346;

UPDATE canvas_widget_content
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE id = 357;

UPDATE canvas_widget_content_copy
SET url = 'https://docs.google.com/spreadsheets/d/1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s/edit?usp=sharing'
WHERE parent_id = 357;