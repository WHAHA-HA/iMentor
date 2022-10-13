--We add messages from iMentor occasionally to Conversations, eg to introduce the product to new users.

INSERT INTO conversation
(user_id, persona_id, recipient_user_id, recipient_persona_id, received_by_server, sent_to_recipient, admin_last_viewed, data, word_count, sequence)
SELECT
	152132,
	74918,
	iu.id,
	ip.id,
	'12/9/16',
	NULL,
	'12/9/16',
	'Welcome to Conversations! This is your tool to exchange messages as a pair. New message notifications will appear on the Conversations icon at the top right of your screen. Click the chat icon to open Conversations, click the paperclip icon to attach files and click the paper airplane icon to send your message. If you want to learn more, click the “Need help” link near the search icon above.',
	69,
        1
FROM iuser_user AS iu
JOIN iuser_persona AS ip ON ip.user_id = iu.id
        WHERE NOT EXISTS (SELECT * FROM conversation where user_id = iu.id);

