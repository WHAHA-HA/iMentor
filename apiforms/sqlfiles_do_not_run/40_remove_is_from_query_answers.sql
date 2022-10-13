DELETE FROM forms_answer_dependency_copy WHERE dependent_on_answer_id_for_question_id IN (SELECT id FROM forms_section_answer_copy WHERE is_from_query = TRUE);
DELETE FROM forms_section_answer_copy * WHERE is_from_query = TRUE;
DELETE FROM forms_answer_dependency WHERE dependent_on_answer_id_for_question_id IN (SELECT id FROM forms_section_answer WHERE is_from_query = TRUE);
DELETE FROM forms_section_answer * WHERE is_from_query = TRUE;