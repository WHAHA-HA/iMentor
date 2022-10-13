update mentee_readiness_school set school_attendance=0 where school_attendance is null;
alter table mentee_readiness_school alter column school_attendance set not null;

