-- Init to epoch time of '1'
DELETE FROM safety_check_tracking;
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (1,1,1);
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (2,1,1);
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (3,1,1);
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (1,2,1);
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (2,2,1);
INSERT INTO safety_check_tracking (app,frequency,epoch_time_last_checked) values (3,2,1);
