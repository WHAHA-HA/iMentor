begin transaction;

--We create indexes on the columns relevant to Conversations.

CREATE INDEX conversation_user_id_idx ON conversation (user_id);
CREATE INDEX conversation_recipient_user_id_idx ON conversation (recipient_user_id);
CREATE INDEX conversation_received_by_server_idx ON conversation (received_by_server);
CREATE INDEX conversation_sent_to_recipient_idx ON conversation (sent_to_recipient);
CREATE INDEX conversation_admin_last_viewed_idx ON conversation (admin_last_viewed);
CREATE INDEX conversation_persona_id_idx ON conversation (persona_id);
CREATE INDEX conversation_recipient_persona_id_idx ON conversation (recipient_persona_id);

CREATE INDEX conversation_auto_save_user_id_idx ON conversation_auto_save (user_id);
CREATE INDEX conversation_auto_save_recipient_user_id_idx ON conversation_auto_save (recipient_user_id);
CREATE INDEX conversation_auto_save_received_by_server_idx ON conversation_auto_save (received_by_server);