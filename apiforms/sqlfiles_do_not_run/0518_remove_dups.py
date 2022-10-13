# -*- coding: iso8859-15 -*-
import json
import pdb
import os,sys
import pprint
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship

from apiforms.models import AnswerCopy,UserResponse,QuestionCopy
from legacy_models.iuser import IuserUserAcademicField

rows = db.session.execute("""
SELECT 
    user_id,
    academicfield_id,
    COUNT(*)
FROM iuser_user_academic_fields
GROUP BY
    user_id,
    academicfield_id
HAVING COUNT(*) > 1;
""")
for row in rows:
    dups = IuserUserAcademicField.query.filter(
        IuserUserAcademicField.user_id == row[0]
        ).filter(IuserUserAcademicField.academicfield_id== row[1]
        ).all()
    dup_index = [d for d in dups]

    for d in range(1,len(dups)):
        IuserUserAcademicField.query.filter(
            IuserUserAcademicField.id == dup_index[d].id
            ).delete()

db.session.commit()
