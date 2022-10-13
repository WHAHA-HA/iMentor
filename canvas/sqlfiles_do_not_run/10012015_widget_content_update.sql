--Update a text error

UPDATE canvas_widget_content
SET html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share what you are most looking forward to this year.</li></ul>'
WHERE html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share you what are most looking forward to this year.</li></ul>';
--2 rows.

UPDATE canvas_widget_content_copy
SET html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share what you are most looking forward to this year.</li></ul>'
WHERE html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share you what are most looking forward to this year.</li></ul>';
--2192 rows.

/*
select * from canvas_widget_content where html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share you what are most looking forward to this year.</li></ul>'
select * from canvas_widget_content_copy where html = '<ul><li>Respond to your mentee and ask clarifying questions.</li><li>Share highlights from your summer. Be sure to answer your mentee’s questions. Remember to lead by example and provide clear details.</li><li>Share you what are most looking forward to this year.</li></ul>'
*/