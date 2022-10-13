alter table canvas_set_copy add column obo_user_posted INTEGER DEFAULT NULL;
ALTER TABLE canvas_set_copy ADD CONSTRAINT canvas_set_copy__obo_user_posted__fk FOREIGN KEY (obo_user_posted) REFERENCES iuser_user(id) ;

alter table canvas_content_user_response add column obo_user_posted INTEGER DEFAULT NULL;
ALTER TABLE canvas_content_user_response ADD CONSTRAINT canvas_content_user_response__obo_user_posted__fk FOREIGN KEY (obo_user_posted) REFERENCES iuser_user(id) ;

alter table canvas_content_user_response add column response_datetime TIMESTAMP DEFAULT NULL;

alter table canvas_content_user_response_history add column obo_user_posted INTEGER DEFAULT NULL;
-- Don't fk or index anything in history.
