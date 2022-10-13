--Staff Lesson 13.1.1 Updates

UPDATE canvas_curriculum
SET description = 'Academic Progress'
WHERE id = 20;

UPDATE canvas_curriculum_copy
SET description = 'Academic Progress'
WHERE parent_id = 20;

UPDATE canvas_set
SET description = 'Academic Progress'
WHERE id = 42;

UPDATE canvas_set_copy
SET description = 'Academic Progress'
WHERE parent_id = 42;

UPDATE canvas_widget_content
SET html = 'Welcome to your first lesson in the college program! To start, watch this video of iMentor pairs in college.<p><p>As you watch, consider the following:<ul><li>How do academic expectations differ between high school and college?</li><li>What habits or actions allowed the mentees in this video to succeed?</li><li>How do you want your mentor to support your academics this year?</li></ul></p></p>'
WHERE id = 281;

UPDATE canvas_widget_content_copy
SET html = 'Welcome to your first lesson in the college program! To start, watch this video of iMentor pairs in college.<p><p>As you watch, consider the following:<ul><li>How do academic expectations differ between high school and college?</li><li>What habits or actions allowed the mentees in this video to succeed?</li><li>How do you want your mentor to support your academics this year?</li></ul></p></p>'
WHERE parent_id = 281;

UPDATE canvas_widget_content
SET html = 'Follow the instructions in the article above to create a study plan using the template below.'
WHERE id = 286;

UPDATE canvas_widget_content_copy
SET html = 'Follow the instructions in the article above to create a study plan using the template below.'
WHERE parent_id = 286;