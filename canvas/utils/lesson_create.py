import pprint
from create_pc_lesson import make_pc_curriculum
from create_mentee_lesson import make_mentee_curriculum
from create_mentor_lesson import make_mentor_curriculum
from config.project_globals import Base,metadata,DBSession,get_scoped_session

# Order is very important.
local_db_session = get_scoped_session()
p_results = make_pc_curriculum(local_db_session)
e_results = make_mentee_curriculum(local_db_session,p_results['curriculum_id'])
r_results = make_mentor_curriculum(local_db_session,e_results['curriculum_id'],e_results)
# One giant commit at the very end.
local_db_session.commit()

pprint.pprint(r_results)
