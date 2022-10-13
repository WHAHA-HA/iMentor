--We create a table for careers and another for occupations, then relate those two tables.

CREATE TABLE utils_career (
	id integer NOT NULL PRIMARY KEY,
	name VARCHAR NOT NULL DEFAULT 'NULL' UNIQUE
	);

CREATE SEQUENCE utils_career_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER SEQUENCE utils_career_id_seq OWNED BY utils_career.id;

ALTER TABLE ONLY utils_career ALTER COLUMN id SET DEFAULT nextval('utils_career_id_seq'::regclass);

CREATE TABLE utils_occupation (
	id integer NOT NULL PRIMARY KEY,
	career_id integer NOT NULL DEFAULT 0,
	name VARCHAR NOT NULL DEFAULT 'NULL' UNIQUE
	);

CREATE SEQUENCE utils_occupation_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER SEQUENCE utils_occupation_id_seq OWNED BY utils_occupation.id;

ALTER TABLE ONLY utils_occupation ALTER COLUMN id SET DEFAULT nextval('utils_occupation_id_seq'::regclass);

ALTER TABLE ONLY utils_occupation ADD CONSTRAINT utils_occupation_career_id FOREIGN KEY (career_id) REFERENCES utils_career(id);
    
--We now add values to these tables.

INSERT INTO utils_career (id, name) VALUES (1, 'Athletics');
INSERT INTO utils_career (id, name) VALUES (2, 'Arts & Entertainment');
INSERT INTO utils_career (id, name) VALUES (3, 'Business');
INSERT INTO utils_career (id, name) VALUES (4, 'Communications');
INSERT INTO utils_career (id, name) VALUES (5, 'Education');
INSERT INTO utils_career (id, name) VALUES (6, 'Engineering');
INSERT INTO utils_career (id, name) VALUES (7, 'Government');
INSERT INTO utils_career (id, name) VALUES (8, 'Healthcare');
INSERT INTO utils_career (id, name) VALUES (9, 'Human Services');
INSERT INTO utils_career (id, name) VALUES (10, 'International');
INSERT INTO utils_career (id, name) VALUES (11, 'Law & Public Policy');
INSERT INTO utils_career (id, name) VALUES (12, 'Non-Profit & Social Services');
INSERT INTO utils_career (id, name) VALUES (13, 'Sciences');
INSERT INTO utils_career (id, name) VALUES (14, 'Technology');
INSERT INTO utils_career (id, name) VALUES (15, 'Trades / Vocations');

INSERT INTO utils_occupation (id, career_id, name) VALUES (1, 1, 'Athlete');
INSERT INTO utils_occupation (id, career_id, name) VALUES (2, 1, 'Coach');
INSERT INTO utils_occupation (id, career_id, name) VALUES (3, 1, 'Physical Trainer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (4, 1, 'Sports Medicine');
INSERT INTO utils_occupation (id, career_id, name) VALUES (5, 2, 'Actor / Actress');
INSERT INTO utils_occupation (id, career_id, name) VALUES (6, 2, 'Broadcasting (Radio/Television)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (7, 2, 'Culinary Arts / Chef');
INSERT INTO utils_occupation (id, career_id, name) VALUES (8, 2, 'Dancer / Choreographer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (9, 2, 'Fashion/Textile Art');
INSERT INTO utils_occupation (id, career_id, name) VALUES (10, 2, 'Film/Video/Television');
INSERT INTO utils_occupation (id, career_id, name) VALUES (11, 2, 'Fine Arts/Visual Arts/Graphic Design');
INSERT INTO utils_occupation (id, career_id, name) VALUES (12, 2, 'Hospitality / Tourism');
INSERT INTO utils_occupation (id, career_id, name) VALUES (13, 2, 'Hotel / Restaurant Management');
INSERT INTO utils_occupation (id, career_id, name) VALUES (14, 2, 'Interior Design');
INSERT INTO utils_occupation (id, career_id, name) VALUES (15, 2, 'Musician / Singer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (16, 2, 'Photography');
INSERT INTO utils_occupation (id, career_id, name) VALUES (17, 2, 'Restaurant, Hotel & Cruise Personnel');
INSERT INTO utils_occupation (id, career_id, name) VALUES (18, 2, 'Theatrical Arts (writing/directing/production)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (19, 2, 'Tourism & Hospitality');
INSERT INTO utils_occupation (id, career_id, name) VALUES (20, 2, 'Entertainment Business (sports management, record labels, etc.)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (21, 3, 'Accounting');
INSERT INTO utils_occupation (id, career_id, name) VALUES (22, 3, 'Advertising');
INSERT INTO utils_occupation (id, career_id, name) VALUES (23, 3, 'Clerical / Office Management');
INSERT INTO utils_occupation (id, career_id, name) VALUES (24, 3, 'Consulting');
INSERT INTO utils_occupation (id, career_id, name) VALUES (25, 3, 'Entrepreneurship/Small Business Owner');
INSERT INTO utils_occupation (id, career_id, name) VALUES (26, 3, 'Finance');
INSERT INTO utils_occupation (id, career_id, name) VALUES (27, 3, 'Human Resources');
INSERT INTO utils_occupation (id, career_id, name) VALUES (28, 3, 'Insurance');
INSERT INTO utils_occupation (id, career_id, name) VALUES (29, 3, 'Investor / Stockbroker');
INSERT INTO utils_occupation (id, career_id, name) VALUES (30, 3, 'Management / Front Office');
INSERT INTO utils_occupation (id, career_id, name) VALUES (31, 3, 'Manufacturing / Production');
INSERT INTO utils_occupation (id, career_id, name) VALUES (32, 3, 'Marketing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (33, 3, 'Real Estate');
INSERT INTO utils_occupation (id, career_id, name) VALUES (34, 3, 'Retail / Wholesale');
INSERT INTO utils_occupation (id, career_id, name) VALUES (35, 3, 'Retail Sales / Management');
INSERT INTO utils_occupation (id, career_id, name) VALUES (36, 3, 'Sales');
INSERT INTO utils_occupation (id, career_id, name) VALUES (37, 4, 'Event Planning & Hospitality');
INSERT INTO utils_occupation (id, career_id, name) VALUES (38, 4, 'Events Planning / Events Coordinator');
INSERT INTO utils_occupation (id, career_id, name) VALUES (39, 4, 'Journalism');
INSERT INTO utils_occupation (id, career_id, name) VALUES (40, 4, 'Literary / Academic Writing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (41, 4, 'Public Relations');
INSERT INTO utils_occupation (id, career_id, name) VALUES (42, 4, 'Publishing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (43, 5, 'Adult Education');
INSERT INTO utils_occupation (id, career_id, name) VALUES (44, 5, 'Arts Education/Therapy/Administration');
INSERT INTO utils_occupation (id, career_id, name) VALUES (45, 5, 'College / University Professor');
INSERT INTO utils_occupation (id, career_id, name) VALUES (46, 5, 'College Residency Advisor');
INSERT INTO utils_occupation (id, career_id, name) VALUES (47, 5, 'Financial Aid Coordinator');
INSERT INTO utils_occupation (id, career_id, name) VALUES (48, 5, 'Guidance Counseling');
INSERT INTO utils_occupation (id, career_id, name) VALUES (49, 5, 'Higher Education Administration (Admissions Officer / Development Officer)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (50, 5, 'Museums/Libraries (Collections)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (51, 5, 'Private tutor / Instructor (Example: SAT Test Prep)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (52, 5, 'School Administration (Principal, Superintendent, etc.)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (53, 5, 'School Psychology');
INSERT INTO utils_occupation (id, career_id, name) VALUES (54, 5, 'School Social Work');
INSERT INTO utils_occupation (id, career_id, name) VALUES (55, 5, 'Science Education & Science Illustration');
INSERT INTO utils_occupation (id, career_id, name) VALUES (56, 5, 'Special Education');
INSERT INTO utils_occupation (id, career_id, name) VALUES (57, 5, 'Teacher');
INSERT INTO utils_occupation (id, career_id, name) VALUES (58, 5, 'Teaching');
INSERT INTO utils_occupation (id, career_id, name) VALUES (59, 6, 'Architecture');
INSERT INTO utils_occupation (id, career_id, name) VALUES (60, 6, 'Bioengineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (61, 6, 'Civil Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (62, 6, 'Electrical Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (63, 6, 'Environmental Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (64, 6, 'Industrial Design');
INSERT INTO utils_occupation (id, career_id, name) VALUES (65, 6, 'Industrial Engineering & Operations Research');
INSERT INTO utils_occupation (id, career_id, name) VALUES (66, 6, 'Landscape Architecture');
INSERT INTO utils_occupation (id, career_id, name) VALUES (67, 6, 'Mechanical Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (68, 6, 'Nuclear Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (69, 7, 'Aerospace/Defense');
INSERT INTO utils_occupation (id, career_id, name) VALUES (70, 7, 'Avionics / Aviation');
INSERT INTO utils_occupation (id, career_id, name) VALUES (71, 7, 'Civil Service (Post Office, Motor Vehicles, etc.)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (72, 7, 'Energy / Utilities');
INSERT INTO utils_occupation (id, career_id, name) VALUES (73, 7, 'Government-International Relations / Consulate');
INSERT INTO utils_occupation (id, career_id, name) VALUES (74, 7, 'Judicial');
INSERT INTO utils_occupation (id, career_id, name) VALUES (75, 7, 'Lobbying/Labor Relations');
INSERT INTO utils_occupation (id, career_id, name) VALUES (76, 7, 'Lobbyist');
INSERT INTO utils_occupation (id, career_id, name) VALUES (77, 7, 'Military/Armed Forces and Defense');
INSERT INTO utils_occupation (id, career_id, name) VALUES (78, 7, 'Politics, Political Parties, Legislative Branch (Federal and State)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (79, 7, 'Public Health');
INSERT INTO utils_occupation (id, career_id, name) VALUES (80, 7, 'Public Policy/Advocacy/Think Tanks');
INSERT INTO utils_occupation (id, career_id, name) VALUES (81, 7, 'Security/Intelligence (Federal)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (82, 7, 'Urban & Regional Planning');
INSERT INTO utils_occupation (id, career_id, name) VALUES (83, 8, 'Alternative/Complementary Medicine');
INSERT INTO utils_occupation (id, career_id, name) VALUES (84, 8, 'Audiology & Speech Pathology/Communicative Disorders');
INSERT INTO utils_occupation (id, career_id, name) VALUES (85, 8, 'Chiropractic');
INSERT INTO utils_occupation (id, career_id, name) VALUES (86, 8, 'Dental Hygienist / Assistant');
INSERT INTO utils_occupation (id, career_id, name) VALUES (87, 8, 'Dentist');
INSERT INTO utils_occupation (id, career_id, name) VALUES (88, 8, 'Gerontology & Aging');
INSERT INTO utils_occupation (id, career_id, name) VALUES (89, 8, 'Health Management, Policy & Consulting');
INSERT INTO utils_occupation (id, career_id, name) VALUES (90, 8, 'Medical Doctor');
INSERT INTO utils_occupation (id, career_id, name) VALUES (91, 8, 'Medical Office Assistance (Records / Support / Insurance)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (92, 8, 'Mental Health / Social Services');
INSERT INTO utils_occupation (id, career_id, name) VALUES (93, 8, 'Nursing / Nurse Practitioner');
INSERT INTO utils_occupation (id, career_id, name) VALUES (94, 8, 'Nutrition & Dietetics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (95, 8, 'Occupational Therapy');
INSERT INTO utils_occupation (id, career_id, name) VALUES (96, 8, 'Optometry / Ophthalmology');
INSERT INTO utils_occupation (id, career_id, name) VALUES (97, 8, 'Pharmaceutical Sales');
INSERT INTO utils_occupation (id, career_id, name) VALUES (98, 8, 'Pharmacy');
INSERT INTO utils_occupation (id, career_id, name) VALUES (99, 8, 'Physical Therapy');
INSERT INTO utils_occupation (id, career_id, name) VALUES (100, 8, 'Physician Assistant');
INSERT INTO utils_occupation (id, career_id, name) VALUES (101, 8, 'Podiatric Medicine');
INSERT INTO utils_occupation (id, career_id, name) VALUES (102, 8, 'Psychology / Psychiatry');
INSERT INTO utils_occupation (id, career_id, name) VALUES (103, 8, 'Radiology / Imaging');
INSERT INTO utils_occupation (id, career_id, name) VALUES (104, 8, 'Recreation/Sports Medicine');
INSERT INTO utils_occupation (id, career_id, name) VALUES (105, 8, 'Rehab Counseling');
INSERT INTO utils_occupation (id, career_id, name) VALUES (106, 8, 'Surgeon');
INSERT INTO utils_occupation (id, career_id, name) VALUES (107, 8, 'Veterinary Medicine');
INSERT INTO utils_occupation (id, career_id, name) VALUES (108, 9, 'Airline Personnel');
INSERT INTO utils_occupation (id, career_id, name) VALUES (109, 9, 'Career Planning Resources');
INSERT INTO utils_occupation (id, career_id, name) VALUES (110, 9, 'Childcare Worker / Youth Services Worker');
INSERT INTO utils_occupation (id, career_id, name) VALUES (111, 9, 'Fire Fighter / Emergency Medical Service / Ambulance');
INSERT INTO utils_occupation (id, career_id, name) VALUES (112, 10, 'Translation & Interpretation');
INSERT INTO utils_occupation (id, career_id, name) VALUES (113, 11, 'International Law');
INSERT INTO utils_occupation (id, career_id, name) VALUES (114, 11, 'Law Enforcement and Criminal Justice');
INSERT INTO utils_occupation (id, career_id, name) VALUES (115, 11, 'Lawyer – Corporate');
INSERT INTO utils_occupation (id, career_id, name) VALUES (116, 11, 'Lawyer – Government');
INSERT INTO utils_occupation (id, career_id, name) VALUES (117, 11, 'Lawyer – Public Defender /Public Interest');
INSERT INTO utils_occupation (id, career_id, name) VALUES (118, 11, 'Paralegal / Legal Secretary');
INSERT INTO utils_occupation (id, career_id, name) VALUES (119, 12, 'Community Relations Manager');
INSERT INTO utils_occupation (id, career_id, name) VALUES (120, 12, 'Human Rights Worker');
INSERT INTO utils_occupation (id, career_id, name) VALUES (121, 12, 'Non-profit Development / Fundraising / Grant Writing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (122, 12, 'Non-profit Programming');
INSERT INTO utils_occupation (id, career_id, name) VALUES (123, 12, 'Religious Service');
INSERT INTO utils_occupation (id, career_id, name) VALUES (124, 12, 'Social Worker / Social Services / Mental Health Worker');
INSERT INTO utils_occupation (id, career_id, name) VALUES (125, 12, 'Volunteer Manager / Recruitment Manager');
INSERT INTO utils_occupation (id, career_id, name) VALUES (126, 13, 'Animal Science/Zoology & Marine Science');
INSERT INTO utils_occupation (id, career_id, name) VALUES (127, 13, 'Archaeologist');
INSERT INTO utils_occupation (id, career_id, name) VALUES (128, 13, 'Astronomer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (129, 13, 'Bioinformatics/Biostatistics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (130, 13, 'Biotechnology/Pharmaceuticals');
INSERT INTO utils_occupation (id, career_id, name) VALUES (131, 13, 'Botany/Forestry/Horticulture/Agriculture');
INSERT INTO utils_occupation (id, career_id, name) VALUES (132, 13, 'Chemistry/Chemical Engineering');
INSERT INTO utils_occupation (id, career_id, name) VALUES (133, 13, 'Environmental Science');
INSERT INTO utils_occupation (id, career_id, name) VALUES (134, 13, 'Forensic Science');
INSERT INTO utils_occupation (id, career_id, name) VALUES (135, 13, 'Genetics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (136, 13, 'Genetics/Microbiology');
INSERT INTO utils_occupation (id, career_id, name) VALUES (137, 13, 'Library Sciences');
INSERT INTO utils_occupation (id, career_id, name) VALUES (138, 13, 'Library/Information Services');
INSERT INTO utils_occupation (id, career_id, name) VALUES (139, 13, 'Materials Science');
INSERT INTO utils_occupation (id, career_id, name) VALUES (140, 13, 'Meteorology');
INSERT INTO utils_occupation (id, career_id, name) VALUES (141, 13, 'Physics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (142, 13, 'Research');
INSERT INTO utils_occupation (id, career_id, name) VALUES (143, 13, 'Robotics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (144, 13, 'Statistics/Mathematics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (145, 14, 'Computer / Help Desk Support');
INSERT INTO utils_occupation (id, career_id, name) VALUES (146, 14, 'Computer Hardware Engineer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (147, 14, 'Computer Programmer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (148, 14, 'Computer Science');
INSERT INTO utils_occupation (id, career_id, name) VALUES (149, 14, 'Computer Security Specialist');
INSERT INTO utils_occupation (id, career_id, name) VALUES (150, 14, 'Computer Software Engineer');
INSERT INTO utils_occupation (id, career_id, name) VALUES (151, 14, 'Computer Technician');
INSERT INTO utils_occupation (id, career_id, name) VALUES (152, 14, 'Database Administrators');
INSERT INTO utils_occupation (id, career_id, name) VALUES (153, 14, 'Electronics');
INSERT INTO utils_occupation (id, career_id, name) VALUES (154, 14, 'Internet / New Media (Business Development)');
INSERT INTO utils_occupation (id, career_id, name) VALUES (155, 14, 'Network and Systems Administrators');
INSERT INTO utils_occupation (id, career_id, name) VALUES (156, 14, 'Technical Writing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (157, 14, 'Telecommunications');
INSERT INTO utils_occupation (id, career_id, name) VALUES (158, 14, 'Video/Computer Game Design');
INSERT INTO utils_occupation (id, career_id, name) VALUES (159, 14, 'Website Design');
INSERT INTO utils_occupation (id, career_id, name) VALUES (160, 15, 'Automotive / Motor vehicles');
INSERT INTO utils_occupation (id, career_id, name) VALUES (161, 15, 'Building /Grounds maintenance');
INSERT INTO utils_occupation (id, career_id, name) VALUES (162, 15, 'Carpentry');
INSERT INTO utils_occupation (id, career_id, name) VALUES (163, 15, 'Construction');
INSERT INTO utils_occupation (id, career_id, name) VALUES (164, 15, 'Electrician');
INSERT INTO utils_occupation (id, career_id, name) VALUES (165, 15, 'Installation / Maintenance / Repair');
INSERT INTO utils_occupation (id, career_id, name) VALUES (166, 15, 'Laboratory / Pathology Services');
INSERT INTO utils_occupation (id, career_id, name) VALUES (167, 15, 'Plumbing');
INSERT INTO utils_occupation (id, career_id, name) VALUES (168, 15, 'Tailor / Garment Repair');
INSERT INTO utils_occupation (id, career_id, name) VALUES (169, 15, 'Transportation');
INSERT INTO utils_occupation (id, career_id, name) VALUES (170, 15, 'Waste management services');
