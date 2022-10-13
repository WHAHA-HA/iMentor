alter table sms_invalid_response add column user_id INTEGER NOT NULL DEFAULT 0;
--ALTER TABLE sms_message ADD CONSTRAINT sms_message__user_id__fk FOREIGN KEY (user_id) REFERENCES iuser_user(id) ;

alter table sms_invalid_response add column from_phone CHARACTER(12) DEFAULT NULL;
alter table sms_invalid_response add column status CHARACTER(200) DEFAULT NULL;
--alter table sms_invalid_response drop column message_id;

