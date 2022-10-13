--The migration of data from the original sms_invalid_response table to the new one didn't map the phone numbers correctly.

begin transaction;

WITH original_phone_numbers AS (
	SELECT DISTINCT
		sir.id,
		sir.from_phone,
		sm.to_phone
	FROM sms_invalid_response AS sir
	JOIN sms_message AS sm ON sm.recipient_id = sir.user_id
	WHERE sir.from_phone != sm.to_phone
	ORDER BY sir.id ASC
	)
UPDATE sms_invalid_response AS sir
SET from_phone = opn.to_phone
FROM original_phone_numbers AS opn
WHERE sir.id = opn.id;
--130 rows. 130 affected.

DELETE FROM sms_invalid_response * WHERE from_phone = '65029';
--3 rows. 3 affected.

/*
select
	sir.from_phone,
	sm.to_phone
from sms_invalid_response as sir
join sms_message as sm on sm.recipient_id = sir.user_id

select * from sms_invalid_response where from_phone = '65029'
select * from sms_message
*/