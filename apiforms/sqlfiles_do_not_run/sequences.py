sequ = """
CREATE SEQUENCE %(table)s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE %(table)s_id_seq OWNED BY %(table)s.id;

ALTER TABLE ONLY %(table)s ALTER COLUMN id SET DEFAULT nextval('%(table)s_id_seq'::regclass);

ALTER TABLE ONLY %(table)s
    ADD CONSTRAINT %(table)s_pkey PRIMARY KEY (id);

    """

tables = [
    'forms_form', 
    'forms_form_member_site', 
    'forms_form_role_can_modify', 
    'forms_form_role_can_answer', 
    'forms_section', 
    'forms_section_question', 
    'forms_section_answer', 
    'forms_answer_dependency', 
    'forms_form_copy', 
    'forms_form_role_can_modify_copy', 
    'forms_section_copy', 
    'forms_section_question_copy', 
    'forms_section_answer_copy', 
    'forms_answer_dependency_copy', 
    'forms_section_user_response' 
    ]

for table in tables:
    print sequ % {'table':table}

