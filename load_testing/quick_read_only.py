from locust import HttpLocust, TaskSet, task


class UserBehavior(TaskSet):

    @task(1)
    def generic(self):
        self.client.get("/generic/user_info/")

    @task(1)
    def survey_link(self):
        self.client.get("/new_surveys/survey_link/")

    @task(1)
    def canvas(self):
        self.client.get("/canvas/presentation/")

    @task(1)
    def canvas(self):
        self.client.get("/conv/chat/")

    def login(self): 
        with self.client.post("/alt_login/", {"email":"staff_showcase@imentor.org", "password":"canvas"},
            catch_response=True) as response:
            if response.status_code in (200,201,300,301,302):
                response.success()

    def on_start(self):
        self.login()

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait=1000
    max_wait=5000
