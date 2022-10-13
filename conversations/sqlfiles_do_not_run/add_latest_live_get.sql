-- alter table conversation_latest_poll drop column latest_live_get_timestamp;
alter table conversation_latest_poll add column latest_live_get_timestamp BIGINT NOT NULL DEFAULT EXTRACT (EPOCH FROM now() at time zone 'utc');
