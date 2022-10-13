from datetime import datetime
from generic_utils.JSON_messages import MasterErrorCodes as MECodes

'''
Roles are handled here, and are treated like static content. 
Groups will be handled in the data model, and are considered dynamic.
'''
class RBACRoles(object):
        '''
        Roles never change, nor are they added/removed.
        (but I left numeric gaps in case new ones need to be added)

        Roles are linear, hierarchical bitmasks, and probably should remain
        this way for simplicity.
        '''
        student = 2
        teacher = 8
        pc = 32
        manager = 128
        rsuper = 512
        role_dict = {
            student:'Student',
            teacher:'Teacher',
            pc:'PC',
            manager:'Manager',
            rsuper:'Super User',
            }

        def __init__(self):
                self.all_roles = self.student | self.teacher | self.pc | self.manager | self.rsuper
                self.parent = {self.student:self.teacher,
                                self.teacher:self.pc,
                                self.pc:self.manager,
                                self.manager:self.rsuper,
                                self.rsuper:None}
                self.child = dict([(y,x) for x,y in self.parent.items() if y])
                keys = sorted(self.parent.keys())
                self.child[keys[0]] = None

        def return_parent_role(self,role_id):
                return self.parent[role_id]

        def return_child_role(self,role_id):
                return self.child[role_id]

        def role_name_lookup(self,role_name):
                return getattr(self,role_name,0)

        # Role checking is "this role or higher" logic.
        def is_at_least_super(self,role):
            check_roles = self.rsuper
            return (role & check_roles) > 0

        def is_at_least_manager(self,role):
            check_roles = (self.rsuper | self.manager)
            return (role & check_roles) > 0

        def is_at_least_pc(self,role):
            check_roles = (self.rsuper | self.manager | self.pc)
            return (role & check_roles) > 0

        def is_at_least_teacher(self,role):
            check_roles = (self.rsuper | self.manager | self.pc | self.teacher)
            return (role & check_roles) > 0

        def is_at_least_student(self,role):
            check_roles = (self.rsuper | self.manager | self.pc | self.teacher | self.student)
            return (role & check_roles) > 0

        # Role checking for exact role.
        def is_super(self,role):
            check_roles = self.rsuper
            return (role & check_roles) > 0

        def is_manager(self,role):
            check_roles = self.manager
            return (role & check_roles) > 0

        def is_pc(self,role):
            check_roles = self.pc
            return (role & check_roles) > 0

        def is_teacher(self,role):
            check_roles = self.teacher
            return (role & check_roles) > 0

        def is_student(self,role):
            check_roles = self.student
            return (role & check_roles) > 0

