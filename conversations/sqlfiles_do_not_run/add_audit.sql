alter table conversation add column obo_user_posted INTEGER DEFAULT NULL;
ALTER TABLE conversation ADD CONSTRAINT conversation__obo_user_posted__fk FOREIGN KEY (obo_user_posted) REFERENCES iuser_user(id) ;

alter table conversation_auto_save add column obo_user_posted INTEGER DEFAULT NULL;
ALTER TABLE conversation_auto_save ADD CONSTRAINT conversation_auto_save__obo_user_posted__fk FOREIGN KEY (obo_user_posted) REFERENCES iuser_user(id) ;
