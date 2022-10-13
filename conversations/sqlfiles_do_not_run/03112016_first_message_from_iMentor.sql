--We add messages from iMentor occasionally to Conversations, eg to introduce the product to new users.

begin transaction;

INSERT INTO conversation
(user_id, recipient_user_id, received_by_server, sent_to_recipient, viewed_by_admin, data, word_count)
SELECT
	152132,
	iu.id,
	'3/11/16',
	NULL,
	'3/14/16',
	'Welcome to Conversations! This is your tool to exchange messages as a pair. New message notifications will appear on the Conversations icon at the top right of your screen. Click the chat icon to open Conversations, click the paperclip icon to attach files and click the paper airplane icon to send your message. If you want to learn more, click the “Need help” link near the search icon above.',
	69
FROM iuser_user AS iu
JOIN iuser_persona AS ip ON ip.user_id = iu.id
WHERE iu.member_id IN (1,191,196,233,245,244,246,237,231,195,247,236,234,197)
	AND ip.match_status = 'M'
	AND ip.status = 'A'
	AND iu.status = 'A';

--12002 rows. 12002 affected.

/*
SELECT
	COUNT(*)
FROM iuser_user AS iu
JOIN iuser_persona AS ip ON ip.user_id = iu.id
WHERE iu.member_id IN (1,191,196,233,245,244,246,237,231,195,247,236,234,197)
	AND ip.match_status = 'M'
	AND ip.status = 'A'
	AND iu.status = 'A';

select count(*) from conversation; --240
select * from conversation limit 50;
select * from conversation where recipient_user_id = 151865 order by id desc limit 10;
select * from conversation where recipient_user_id = 151937 order by id desc limit 10;
select * from conversation where recipient_user_id = 151826 order by id desc limit 10;

INSERT INTO conversation
(user_id, recipient_user_id, received_by_server, sent_to_recipient, viewed_by_admin, data, word_count)
SELECT
	152132,
	iu.id,
	'3/11/16',
	NULL,
	'3/14/16',
	'Welcome to Conversations! This is your tool to exchange messages as a pair. New message notifications will appear on the Conversations icon at the top right of your screen. Click the chat icon to open Conversations, click the paperclip icon to attach files and click the paper airplane icon to send your message. If you want to learn more, click the “Need help” link near the search icon above.',
	69
FROM iuser_user AS iu
JOIN iuser_persona AS ip ON ip.user_id = iu.id
WHERE iu.id = 151937
	AND ip.match_status = 'M'
	AND ip.status = 'A'
	AND iu.status = 'A';
*/