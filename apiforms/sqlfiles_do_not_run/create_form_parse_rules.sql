-- for the id_str_both parse options below.
-- PARSE_ID = 1
-- PARSE_STR = 2
-- PARSE_BOTH = 3

-- for the parse_status.
-- NOT_PARSED = 1
-- COMPLETED = 2
-- ERROR = 3

-- naming weird rules will help us identify them.

CREATE TABLE forms_user_response_parse_rule (
	id SERIAL NOT NULL, 
	match_create_table_fields_json VARCHAR(1000) DEFAULT NULL, 
	update_tables_fields_json VARCHAR(1000) NOT NULL DEFAULT '', 
	where_tables_fields_json VARCHAR(1000) NOT NULL DEFAULT '', 
        overwrite_values BOOLEAN DEFAULT True,
	for_question_type INTEGER NOT NULL DEFAULT 0, 
	optional_name VARCHAR(100) DEFAULT NULL, 
	PRIMARY KEY (id)
);

CREATE TABLE forms_user_response_parse_map (
	id SERIAL NOT NULL, 
	master_question_id INTEGER NOT NULL DEFAULT 0, 
	parse_rule INTEGER NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	FOREIGN KEY(master_question_id) REFERENCES forms_section_question (id),
	FOREIGN KEY(parse_rule) REFERENCES forms_user_response_parse_rule (id)
);

-- There will be one record per error. 
-- Upon success, there should only be one record.
CREATE TABLE forms_user_response_parse_status (
	id SERIAL NOT NULL, 
	form_copy_id INTEGER NOT NULL DEFAULT 0, 
	user_response_id_if_error INTEGER DEFAULT NULL,
	status INTEGER NOT NULL DEFAULT 0, 
	error_string VARCHAR(1000) DEFAULT NULL, 
	last_parse_datetime TIMESTAMP DEFAULT NULL,
	PRIMARY KEY (id), 
	FOREIGN KEY(form_copy_id) REFERENCES forms_form_copy (id)
);

insert into forms_user_response_parse_rule (update_tables_fields_json,where_tables_fields_json,optional_name) values ('{"iuser_user":{"address1":"address","city":"city","state":"state_id","zip_code":"zipcode"}}','{"iuser_user":{"id":"~current_user"}}',"home address");
