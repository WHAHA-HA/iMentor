drop table if exists file_upload_allow_list;
drop sequence if exists file_upload_allow_list_id_seq;

CREATE TABLE file_upload_allow_list (
        id SERIAL NOT NULL,
        file_extension VARCHAR(30) unique not null default 'Not Set',
        PRIMARY KEY (id)
);

CREATE SEQUENCE file_upload_allow_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE file_upload_allow_list_id_seq OWNED BY file_upload_allow_list.id;
ALTER TABLE ONLY file_upload_allow_list ALTER COLUMN id SET DEFAULT nextval('file_upload_allow_list_id_seq'::regclass);

INSERT INTO file_upload_allow_list (file_extension) values ('.accdb');
INSERT INTO file_upload_allow_list (file_extension) values ('.accde');
INSERT INTO file_upload_allow_list (file_extension) values ('.accdr');
INSERT INTO file_upload_allow_list (file_extension) values ('.accdt');
INSERT INTO file_upload_allow_list (file_extension) values ('.ade');
INSERT INTO file_upload_allow_list (file_extension) values ('.adp');
INSERT INTO file_upload_allow_list (file_extension) values ('.bmp');
INSERT INTO file_upload_allow_list (file_extension) values ('.csv');
INSERT INTO file_upload_allow_list (file_extension) values ('.doc');
INSERT INTO file_upload_allow_list (file_extension) values ('.docm');
INSERT INTO file_upload_allow_list (file_extension) values ('.docx');
INSERT INTO file_upload_allow_list (file_extension) values ('.dotm');
INSERT INTO file_upload_allow_list (file_extension) values ('.dotx');
INSERT INTO file_upload_allow_list (file_extension) values ('.gif');
INSERT INTO file_upload_allow_list (file_extension) values ('.htm');
INSERT INTO file_upload_allow_list (file_extension) values ('.html');
INSERT INTO file_upload_allow_list (file_extension) values ('.ical');
INSERT INTO file_upload_allow_list (file_extension) values ('.icl');
INSERT INTO file_upload_allow_list (file_extension) values ('.jpeg');
INSERT INTO file_upload_allow_list (file_extension) values ('.jpg');
INSERT INTO file_upload_allow_list (file_extension) values ('.key');
INSERT INTO file_upload_allow_list (file_extension) values ('.mp3');
INSERT INTO file_upload_allow_list (file_extension) values ('.mp4');
INSERT INTO file_upload_allow_list (file_extension) values ('.numbers');
INSERT INTO file_upload_allow_list (file_extension) values ('.odb');
INSERT INTO file_upload_allow_list (file_extension) values ('.odf');
INSERT INTO file_upload_allow_list (file_extension) values ('.odg');
INSERT INTO file_upload_allow_list (file_extension) values ('.odp');
INSERT INTO file_upload_allow_list (file_extension) values ('.ods');
INSERT INTO file_upload_allow_list (file_extension) values ('.odt');
INSERT INTO file_upload_allow_list (file_extension) values ('.pages');
INSERT INTO file_upload_allow_list (file_extension) values ('.pdf');
INSERT INTO file_upload_allow_list (file_extension) values ('.png');
INSERT INTO file_upload_allow_list (file_extension) values ('.potx');
INSERT INTO file_upload_allow_list (file_extension) values ('.ppam');
INSERT INTO file_upload_allow_list (file_extension) values ('.ppsm');
INSERT INTO file_upload_allow_list (file_extension) values ('.ppsx');
INSERT INTO file_upload_allow_list (file_extension) values ('.ppt');
INSERT INTO file_upload_allow_list (file_extension) values ('.pptm');
INSERT INTO file_upload_allow_list (file_extension) values ('.pptx');
INSERT INTO file_upload_allow_list (file_extension) values ('.psd');
INSERT INTO file_upload_allow_list (file_extension) values ('.rtf');
INSERT INTO file_upload_allow_list (file_extension) values ('.txt');
INSERT INTO file_upload_allow_list (file_extension) values ('.vcf');
INSERT INTO file_upload_allow_list (file_extension) values ('.xlam');
INSERT INTO file_upload_allow_list (file_extension) values ('.xls');
INSERT INTO file_upload_allow_list (file_extension) values ('.xlsb');
INSERT INTO file_upload_allow_list (file_extension) values ('.xlsm');
INSERT INTO file_upload_allow_list (file_extension) values ('.xlsx');
INSERT INTO file_upload_allow_list (file_extension) values ('.xltm');
INSERT INTO file_upload_allow_list (file_extension) values ('.xltx');
INSERT INTO file_upload_allow_list (file_extension) values ('.xml');
