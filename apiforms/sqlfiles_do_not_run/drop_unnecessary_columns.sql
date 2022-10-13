ALTER TABLE forms_section_answer
	DROP COLUMN IF EXISTS answer_char;
	
ALTER TABLE forms_section_answer
	DROP COLUMN IF EXISTS answer_bool;
	
ALTER TABLE forms_section_answer
	DROP COLUMN IF EXISTS answer_int;
	
ALTER TABLE forms_section_answer
	DROP COLUMN IF EXISTS answer_datetime;
	
ALTER TABLE forms_section_answer
	DROP COLUMN IF EXISTS is_from_query;