--We added italics to the additional resource for the survey.
UPDATE canvas_widget_content
SET html = 'Your mentee spent most of class learning about the purpose of surveys and taking our program survey. Are you curious about how surveys improve the quality of our program? Click <a href="https://learn.imentor.org/help/article/link/how-surveys-help-to-improve-our-program" target="_blank">here</a>.<p><p>After finishing the survey, your mentee was then able to read about your summer experiences from last week and respond.</p></p>'
WHERE id = 174;

UPDATE canvas_widget_content_copy
SET html = 'Your mentee spent most of class learning about the purpose of surveys and taking our program survey. Are you curious about how surveys improve the quality of our program? Click <a href="https://learn.imentor.org/help/article/link/how-surveys-help-to-improve-our-program" target="_blank">here</a>.<p><p>After finishing the survey, your mentee was then able to read about your summer experiences from last week and respond.</p></p>'
WHERE parent_id = 174;