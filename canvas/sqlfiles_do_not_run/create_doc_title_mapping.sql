DROP TABLE IF EXISTS canvas_doc_title_mapping;

CREATE TABLE canvas_doc_title_mapping (
        id SERIAL NOT NULL, 
        orig_doc_id TEXT DEFAULT NULL UNIQUE,
        doc_title TEXT DEFAULT NULL
);


CREATE SEQUENCE canvas_doc_title_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE canvas_doc_title_mapping_id_seq OWNED BY canvas_doc_title_mapping.id;
ALTER TABLE ONLY canvas_doc_title_mapping ALTER COLUMN id SET DEFAULT nextval('canvas_doc_title_mapping_id_seq'::regclass);

insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('19WAxSZQIfFTsb9jlXQ_cTK5lJVwpNQD9bbGr1ib0nmI','Resume');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1O6hp78cI81Ti2zrSvqR81nUocYQXcRzY0pdorTuCEbw','Budget');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1U6aDkdDp125YznKo0qNorQKDg10Hkg9W5iwJFVVYp6Y', 'Public Service Announcement');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('14RioFiJfcL8HNu_DgubhfJyR_fyjCXLI3jKpMkVQw-c','Mentee LEAD');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1Bt6MpQGbG8KcwfnueyCxGxeUkJHkIK8HWODZmddrElA','11th-Grade SMART Goal');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1dV74vNQldV3esu583f7py_FajgKAusLFL9xB5g8A4PU','Mentor "I Am" Poster');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1ilaZ_qcd1ntSE18H50UfnfOR9FAZoiDI1_lO5zPPVs0','10th-Grade SMART Goal');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1JjHVIK8UPisOPbEoiF-fWLTMRaHx_fvWxrAmFTAGjZ8','Mentee "I Am" Poster');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1nLCLXFsKfs1nNhmbxA3-RXgyuus9KBQwp9117V3EBq4','11th-Grade SMART Goal');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1n-qea9eLVes9zrqiC6xG-1HwgGTcdbWWaRLoAL0OBic','12th-Grade SMART Goal');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1oWox_sCJBhq71xm3MB9ECftVhxw6bOGZAqk8TWzQf-k','Mentor LEAD');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1rT5j53TzWqJAebmdF1GO3zpaiVlmdBJnIA9ZI8U6C9Q','9th-Grade SMART Goal');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1Uk6E9OCX_OefYD9sFPHFrqHUZVFyOO6urMmcm-tdfg0','Cost Benefit Chart');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1vpiny6lJFaOAW4Pb_mDVwD9XB7BUR93NApXax0ILL1A','Mentee "I Am" Poster');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1e3v5uZqUzu0DX2ugll5vqTsO-6Qb8vlB5VtolYTO9NA','Backwards Mapping');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1gR1c_bG_uXGBdZc4oEpvpUhGD-SOEeOHUv3Nv_-I6fM','Scholarship List');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1kt_7iY8N8nBbm8g5jnReqKe6czyenAUuEebpFl2t0Vg','Campus Action Plan');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1ltAyhUJgg6yQIaf3l4nsqzag271wEJvMVeR0gArBCeA','Success Poster');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1U9MZ96bIh_aHammMxcDqaCEhD4blET0m484BCDkEJRU','KWL Chart');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1xnJ6-0c3MUypOaZzCE_pfTeeAdmiDOIRjxCNjl1eLUg','College Essay');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1XR7PL0WjtoVn5Z99GpaUDqu7bTIeDriWQMMxFDboM_s','College Study Plan');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1YUNYX3lyFBI1XFFEfT8pSQNSshBcdXzeQ1jsG2yTPBY','Best Fit');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('12DSH12ssE57i94c8kvrU3iPqx6nrkYEBwazaVJV2amU','Mentor College Fit Checklist');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1Hc2zIXwTIDBJcp1bVHR5dmy0G8oNKKxCgJToHxrL5Hw','Mentee College Fit Checklist');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values ('1u8F99YCvOV8QpMFhn-1aT4Oc-MREagO_VN0WDLUoYIs','College List Research');
insert into canvas_doc_title_mapping (orig_doc_id,doc_title) values (null,'Other Google Resource');
