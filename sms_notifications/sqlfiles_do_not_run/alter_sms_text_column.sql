--We ensure that messages are not limited to 160 characters, since the carrier will break the message apart as necessary.

begin transaction;

ALTER TABLE sms_message ALTER COLUMN text TYPE TEXT;