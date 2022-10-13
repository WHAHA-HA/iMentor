-- As of postgresql 9.1, changing varchar to text will retain the field values. I heart postgres.
alter table sms_invalid_response alter column response type text;

