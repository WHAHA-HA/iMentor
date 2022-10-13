# -*- coding: iso8859-15 -*-
import os,sys
import re
import pdb
import pprint
import traceback
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata

#Import 'app' object from auth as well
from auth import api, app

from flask import  current_app, request, redirect, render_template

from sqlalchemy import (BigInteger, Boolean, Column, Date, DateTime,
    Float, ForeignKey, Index, Integer, Numeric, SmallInteger,
    String, Table, Text, Time, text, DATE, func, UniqueConstraint)
from sqlalchemy.dialects.postgresql.base import INET, TSVECTOR
from sqlalchemy.sql.expression import func, or_, not_, and_
from sqlalchemy.orm import relationship
from legacy_models.member import MemberMember
from legacy_models.partners import PartnersPartner
from legacy_models.iuser import IuserUser,IuserPersona,USERTYPE_MAP
from new_platform.utils.user_details import (get_persona_obj_for_user,
    get_latest_mentee_user_for_mentor, get_latest_mentor_user_for_mentee,
    get_partners_for_user)
from new_platform.utils.roles import Role
from google_services.gdrive import create_gdoc_copy

# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Canvas App and Widget Constants
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
CANVAS_TYPE_INTERIM_LESSON = 1
CANVAS_TYPE_OPENING_LESSON = 2
CANVAS_TYPE_CLOSING_LESSON = 3

CANVAS_TYPES = {
    CANVAS_TYPE_INTERIM_LESSON:'Interim Lesson',
    CANVAS_TYPE_OPENING_LESSON:'Opening Lesson',
    CANVAS_TYPE_CLOSING_LESSON:'Closing Lesson',
    }

APP_TYPE_WRITING = 1
APP_TYPE_PRESENTATION = 2

APP_TYPES = {
    APP_TYPE_WRITING:'Writing',
    APP_TYPE_PRESENTATION:'Presentation',
    }

# Widget Content Types
WIDGET_CONTENT_AUDIO        = 1
WIDGET_CONTENT_YOUTUBE      = 2
WIDGET_CONTENT_VIMEO        = 3
WIDGET_CONTENT_TED          = 4
WIDGET_CONTENT_PREZI        = 5
WIDGET_CONTENT_GDOC         = 6
WIDGET_CONTENT_MDOC         = 7
WIDGET_CONTENT_PDF          = 8
WIDGET_CONTENT_IMAGE        = 9
WIDGET_CONTENT_LINK         = 10
WIDGET_CONTENT_HTML         = 11
WIDGET_CONTENT_PLAINTEXT    = 12
WIDGET_CONTENT_GIST         = 13
WIDGET_CONTENT_SOUNDCLOUD   = 14
WIDGET_CONTENT_UPLOADED_FILE = 15 # User-provided file of any type, uploaded to our system.

WIDGET_CONTENT_MAP = {
    WIDGET_CONTENT_AUDIO:None,
    WIDGET_CONTENT_YOUTUBE:'canvas/youtube.embed',
    WIDGET_CONTENT_VIMEO:'canvas/vimeo.embed',
    WIDGET_CONTENT_TED:'canvas/ted.embed',
    WIDGET_CONTENT_PREZI:'canvas/prezi.embed',
    WIDGET_CONTENT_GDOC:'canvas/google.embed',
    WIDGET_CONTENT_MDOC:None,
    WIDGET_CONTENT_PDF:None,
    WIDGET_CONTENT_IMAGE:None,
    WIDGET_CONTENT_LINK:None,
    WIDGET_CONTENT_HTML:None,
    WIDGET_CONTENT_PLAINTEXT:None,
    WIDGET_CONTENT_GIST:None,
    WIDGET_CONTENT_SOUNDCLOUD:'canvas/soundcloud.embed',
    WIDGET_CONTENT_UPLOADED_FILE:None,
    }

# Widget Content Response Types
WIDGET_CRESPONSE_FREEFORM_TEXT = 1
WIDGET_CRESPONSE_HTML          = 2
WIDGET_CRESPONSE_MULT_CHOICE   = 3
WIDGET_CRESPONSE_SINGLE_CHOICE = 4
WIDGET_CRESPONSE_INTEGER_ENTRY = 5
WIDGET_CRESPONSE_SELECTION_FROM_TABLE = 6
WIDGET_CRESPONSE_FILE_UPLOAD = 7

# Widget Content Obj Positions
BELOW = 0
ABOVE = 1

# Visibity flag name for Widget Content Copies:
IS_VISIBLE='is_visible'

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Canvas Data Models:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Glossary:
#
# Curriculum: The topmost thing in this hierarchy. Has a type, which right
# now is only LESSON.
# An inactive, un-schedulable Curriculum has a null grade and unit.
# A new copy is created for each user.
#
# Canvas Set: A set of Canvas Apps that are expected to be viewed together, in succession,
# and started and ended in some date range. A new copy will be created for each individual 
# user.
#
# Canvas App: A particular type of Canvas application, that has a fixed styling.
# Consider these like the fixed Question Types inthe Forms Application.
# More than one of the same Canvas App can appear in the same user "viewing" (set).
#
#   For example: User could see this for week 1 when they log in:
#   Canvas Set: Date range: Sept 1st to Sept 6th, Description: Week 1
#   Canvas App: Presentation: Week 1, lesson 1 of 2
#   Canvas App: Presentation: Week 1, lesson 2 of 2
#   Canvas App: Writer: Week 1 writing exercise between mentor and mentee
#
#   Apps are visible one app at a time, scrolling up and out of sight as the user completes them.
#
# Widget: A well defined "container" of a Canvas App, with a fixed styling, usually
# containing one set of functionality for that app.
# 
#   Example:
#     The Presentation Canvas App will have a viewable widget and a response widget.
#
# Widget Content: Individual content types, also with fixed styling, which are rendered 
# in a widget in any order. Order is determined by ordinal field in the DB.
#
#     Example: 
#       Link, Video, Audio rendered in the Viewer Widget portion of the Presentation App
#       for week 1 lession 2 of 2.
# 

# Roles
from legacy_models.iuser import (BASIC_USER,
    E_MEMBER_ADMIN,MEMBER_ADMIN,REGIONAL_ADMIN,PARTNER_ADMIN,MENTOR,
    MENTEE,SUPER_ADMIN)

class GradeInfo(Base, db.Model):
    __tablename__ = 'canvas_grade_info'
    id = Column(Integer, primary_key=True, nullable=False)
    grade_number = Column(Integer, nullable=False, default=0)
    description = Column(Text, nullable=True, default=None)

class UnitInfo(Base, db.Model):
    __tablename__ = 'canvas_unit_info'
    id = Column(Integer, primary_key=True, nullable=False)
    unit_number = Column(Integer, nullable=False, default=0)
    description = Column(Text, nullable=True, default=None)
    featured_image = Column(Text, nullable=True, default=None)
    secondary_description = Column(Text, nullable=True, default=None)

# Curricula can be done out of order, meaning that the start date may not
# be enforced. 
# The convention we are following is one Curriculum record per lesson,
# and one Canvas Set record per user role, corresponding to the curriculum record.
# So typically we'll have one Curriculum record per week, three Canvas Set records
# per week (one per role).
class Curriculum(Base, db.Model):
    __tablename__ = 'canvas_curriculum'
    id = Column(Integer, primary_key=True, nullable=False)
    # See Canvas types, above.
    canvas_type = Column(Integer, nullable=False, default=0)
    curriculum_number = Column(Integer, nullable=True, default=None)
    # Canvas range should probably be a whole school year, for example.
    start_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    end_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    # null grade and unit means it should not be scheduled (isn't live).
    grade_id = Column(Integer, ForeignKey(GradeInfo.id), nullable=True)
    unit_id = Column(Integer, ForeignKey(UnitInfo.id), nullable=True)
    # optional: if not set, curriculum is global.
    member_id = Column(Integer, ForeignKey(MemberMember.id), nullable=True)
    description = Column(Text, nullable=True, default=None)
    grade = relationship(GradeInfo, foreign_keys=[grade_id])
    unit = relationship(UnitInfo, foreign_keys=[unit_id])
    active = Column(Boolean, nullable=False, default=True)
    featured_image = Column(Text, nullable=True, default=None)
    secondary_description = Column(Text, nullable=True, default=None)

class CanvasSet(Base, db.Model):
    __tablename__ = 'canvas_set'
    id = Column(Integer, primary_key=True, nullable=False)
    # See roles from iuser model, above. This is only one value, these cannot be "OR"ed.
    role = Column(Integer, nullable=False, default=0)
    curriculum_id = Column(Integer, ForeignKey(Curriculum.id), nullable=False, default=0)
    created_datetime = Column(DateTime, nullable=False, default=datetime.now)
    # Canvas set ranges span smaller periods such as days/weeks.
    start_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    end_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    description = Column(Text, nullable=True, default=None)
    active = Column(Boolean, nullable=False, default=True)
    curriculum = relationship(Curriculum, foreign_keys=[curriculum_id])

class CanvasApp(Base, db.Model):
    __tablename__ = 'canvas_app'
    id = Column(Integer, primary_key=True, nullable=False)
    canvas_set_id = Column(Integer, ForeignKey(CanvasSet.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Writer, Presentation, etc.
    app_type = Column(Integer, nullable=False)
    # There can be more than one of the same app visible for a session.
    n_of_total = Column(Integer, nullable=False, default=0)
    # Total number of these types of apps visible for this set.
    # Example: Presentation App for Week 1 has 4 app records.
    # n_of_total and total for each related record would be 1 of 4, 2 of 4, etc.
    total = Column(Integer, nullable=False, default=0)
    description = Column(Text, nullable=True, default=None)
    active = Column(Boolean, nullable=False, default=True)
    canvas_set = relationship(CanvasSet, foreign_keys=[canvas_set_id])

class Widget(Base, db.Model):
    __tablename__ = 'canvas_widget'
    id = Column(Integer, primary_key=True, nullable=False)
    canvas_app_id = Column(Integer, ForeignKey(CanvasApp.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    active = Column(Boolean, nullable=False, default=True)
    canvas_app = relationship(CanvasApp, foreign_keys=[canvas_app_id])

class WidgetContent(Base, db.Model):
    __tablename__ = 'canvas_widget_content'
    id = Column(Integer, primary_key=True, nullable=False)
    widget_id = Column(Integer, ForeignKey(Widget.id), nullable=False, default=0)
    # See above widget content types
    content_type = Column(Integer, nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Usually only one of these is set
    filename = Column(String(200), nullable=True, default=None)
    url = Column(String(200), nullable=True, default=None)
    html = Column(Text, nullable=True, default=None)
    plain_text = Column(Text, nullable=True, default=None)
    active = Column(Boolean, nullable=False, default=True)
    widget = relationship(Widget, foreign_keys=[widget_id])

# Response markers are "attached" to a previous content type obj, which
# is usually the question prompt.
# Response markers mark places where we are expecting user responses that
# may not have happened yet.
class WidgetContentResponseMarker(Base, db.Model):
    __tablename__ = 'canvas_widget_content_response_marker'
    id = Column(Integer, primary_key=True, nullable=False)
    widget_content_id = Column(Integer, ForeignKey(WidgetContent.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Position = position relative to the previous content object: (above/below)
    position = Column(Integer, nullable=False, default=0)
    # See response types, above.
    response_type = Column(Integer, nullable=False, default=0)
    active = Column(Boolean, nullable=False, default=True)

# Marker references do just that: reference response markers
# and the corresponding responses.
# The reference can be read-only or read-write, allowing someone
# else to change the response.
# The ordinal can/will be completely different when another user sees 
# the reference in their own content.
class WidgetContentMarkerReference(Base, db.Model):
    __tablename__ = 'canvas_widget_content_marker_reference'
    id = Column(Integer, primary_key=True, nullable=False)
    # Response marker and response marker reference will have matching widget content ids.
    widget_content_id = Column(Integer, ForeignKey(WidgetContent.id), nullable=False, default=0)
    # This is the ID of the referenced Response Marker.
    # It's not a foreign key so that it can be created before the marker exists.
    other_marker_id = Column(Integer, nullable=False, default=0)
    read_only = Column(Boolean, nullable=False, default=True)
    ordinal = Column(Integer, nullable=False, default=0)
    # Position = position relative to the previous content object: (above/below)
    position = Column(Integer, nullable=False, default=0)
    active = Column(Boolean, nullable=False, default=True)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Data model copies
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class CurriculumCopy(Base, db.Model):
    # There is a one-to-one mapping between curriculum and canvas set.
    __tablename__ = 'canvas_curriculum_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(Curriculum.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    # See Canvas types, above.
    canvas_type = Column(Integer, nullable=False, default=0)
    curriculum_number = Column(Integer, nullable=True, default=None)
    # Curriculum range should probably be a whole school year, for example.
    start_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    end_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    description = Column(Text, nullable=True, default=None)
    # null grade and unit means it should not be scheduled (isn't live).
    grade_id = Column(Integer, ForeignKey(GradeInfo.id), nullable=True)
    unit_id = Column(Integer, ForeignKey(UnitInfo.id), nullable=True)
    grade = relationship(GradeInfo, foreign_keys=[grade_id])
    unit = relationship(UnitInfo, foreign_keys=[unit_id])
    __table_args__ = (UniqueConstraint('parent_id', 'user_id','matched_user_id'),)

class CanvasSetCopy(Base, db.Model):
    # There is a one-to-one mapping between curriculum and canvas set.
    __tablename__ = 'canvas_set_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(CanvasSet.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    curriculum_id = Column(Integer, ForeignKey(CurriculumCopy.id), nullable=False, default=0)
    # See roles from iuser model, above. This is only one value, these cannot be "OR"ed.
    role = Column(Integer, nullable=False, default=0)
    created_datetime = Column(DateTime, nullable=False, default=datetime.now)
    start_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    end_datetime = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    user_started = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    last_viewed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    admin_last_viewed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    user_completed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    user_first_completed = Column(DateTime(timezone=False), nullable=True, default=None) # UTC
    obo_user_posted = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    description = Column(Text, nullable=True, default=None)
    curriculum_user_copy = relationship(CurriculumCopy, foreign_keys=[curriculum_id])
    obo_user = relationship(IuserUser, foreign_keys=[obo_user_posted])
    user = relationship(IuserUser, foreign_keys=[user_id])
    __table_args__ = (UniqueConstraint('parent_id', 'user_id','matched_user_id'),)

class CanvasAppCopy(Base, db.Model):
    __tablename__ = 'canvas_app_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(CanvasApp.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    canvas_set_id = Column(Integer, ForeignKey(CanvasSetCopy.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Writer, Presentation, etc.
    app_type = Column(Integer, nullable=False)
    # There can be more than one of the same app visible for a session.
    n_of_total = Column(Integer, nullable=False, default=0)
    # Total number of these types of apps visible for this set.
    # Example: Presentation App for Week 1 has 4 app records.
    # n_of_total and total for each related record would be 1 of 4, 2 of 4, etc.
    total = Column(Integer, nullable=False, default=0)
    description = Column(Text, nullable=True, default=None)
    canvas_set_user_copy = relationship(CanvasSetCopy, foreign_keys=[canvas_set_id])

class WidgetCopy(Base, db.Model):
    __tablename__ = 'canvas_widget_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(Widget.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    canvas_app_id = Column(Integer, ForeignKey(CanvasAppCopy.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    canvas_app_user_copy = relationship(CanvasAppCopy, foreign_keys=[canvas_app_id])

class WidgetContentCopy(Base, db.Model):
    __tablename__ = 'canvas_widget_content_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(WidgetContent.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    widget_id = Column(Integer, ForeignKey(WidgetCopy.id), nullable=False, default=0)
    # This could be marked as not visible for some users/classes.
    is_visible = Column(Boolean, nullable=False, default=True)
    # See above widget content types
    content_type = Column(Integer, nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Usually only one of these is set
    filename = Column(String(200), nullable=True, default=None)
    url = Column(String(200), nullable=True, default=None)
    html = Column(Text, nullable=True, default=None)
    # Only if collaborating edit links between users.
    orig_doc_id = Column(Text, nullable=True, default=None)
    new_doc_id = Column(Text, nullable=True, default=None)
    plain_text = Column(Text, nullable=True, default=None)
    widget_user_copy = relationship(WidgetCopy, foreign_keys=[widget_id])
    parent = relationship(WidgetContent, foreign_keys=[parent_id])

# Response markers are "attached" to a previous content type obj, which
# is usually the question prompt.
# Response markers mark places where we are expecting user responses that
# may not have happened yet.
class WidgetContentResponseMarkerCopy(Base, db.Model):
    __tablename__ = 'canvas_widget_content_response_marker_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(WidgetContentResponseMarker.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    widget_content_id = Column(Integer, ForeignKey(WidgetContentCopy.id), nullable=False, default=0)
    ordinal = Column(Integer, nullable=False, default=0)
    # Position = position relative to the previous content object: (above/below)
    position = Column(Integer, nullable=False, default=0)
    # See response types, above.
    response_type = Column(Integer, nullable=False, default=0)
    widget_content_user_copy = relationship(WidgetContentCopy, foreign_keys=[widget_content_id])

# Marker references do just that: reference response markers
# and the corresponding responses.
# The reference can be read-only or read-write, allowing someone
# else to change the response.
# The ordinal can/will be completely different when another user sees 
# the reference in their own content.
class WidgetContentMarkerReferenceCopy(Base, db.Model):
    # Sorry for the really long table names. It's the only way to make it all make sense.
    __tablename__ = 'canvas_widget_content_marker_reference_copy'
    id = Column(Integer, primary_key=True, nullable=False)
    parent_id = Column(Integer, ForeignKey(WidgetContentMarkerReference.id), nullable=False, default=0)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    # Response marker and response marker reference will have matching widget content ids.
    widget_content_id = Column(Integer, ForeignKey(WidgetContentCopy.id), nullable=False, default=0)
    # This is the ID of the referenced Response Marker Copy.
    # It's not a foreign key so that it can be created before the marker exists.
    other_marker_id = Column(Integer, nullable=False, default=0)
    read_only = Column(Boolean, nullable=False, default=True)
    ordinal = Column(Integer, nullable=False, default=0)
    # Position = position relative to the previous content object: (above/below)
    position = Column(Integer, nullable=False, default=0)
    widget_content_copy = relationship(WidgetContentCopy, foreign_keys=[widget_content_id])


class WidgetContentUserResponse(Base, db.Model):
    __tablename__ = 'canvas_content_user_response'
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=False, default=0)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    marker_id = Column(Integer, ForeignKey(WidgetContentResponseMarkerCopy.id), nullable=False, default=0)
    # In case there is more than one response for the same content record.
    ordinal = Column(Integer, nullable=False, default=0)
    # Only one of these will be set by the user. We translate HTML to text and store it here.
    response_html = Column(Text, nullable=True, default=None)
    response_text = Column(Text, nullable=True, default=None)
    response_url = Column(Text, nullable=True, default=None)
    response_id = Column(Integer, nullable=True, default=None) # selected ID of choice questions.
    external_table_id = Column(Integer, nullable=True, default=None)
    words = Column(Integer, nullable=False, default=0)
    chars = Column(Integer, nullable=False, default=0)
    obo_user_posted = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    response_datetime = Column(DateTime, nullable=False, default=datetime.utcnow) # UTC
    widget_content_marker_user_copy = relationship(WidgetContentResponseMarkerCopy, foreign_keys=[marker_id])
    user = relationship(IuserUser, foreign_keys=[user_id])
    obo_user = relationship(IuserUser, foreign_keys=[obo_user_posted])


class WidgetContentUserResponseHistory(Base, db.Model):
    __tablename__ = 'canvas_content_user_response_history'
    # Used for debugging purposes.
    id = Column(Integer, primary_key=True, nullable=False)
    user_id = Column(Integer, nullable=False, default=0)
    persona_id = Column(Integer, nullable=False, default=0)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    marker_id = Column(Integer, nullable=False, default=0)
    # In case there is more than one response for the same content record.
    ordinal = Column(Integer, nullable=False, default=0)
    # Only one of these will be set by the user. We translate HTML to text and store it here.
    response_html = Column(Text, nullable=True, default=None)
    response_text = Column(Text, nullable=True, default=None)
    response_url = Column(Text, nullable=True, default=None)
    response_id = Column(Integer, nullable=True, default=None) # selected ID of choice questions.
    external_table_id = Column(Integer, nullable=True, default=None)
    words = Column(Integer, nullable=False, default=0)
    chars = Column(Integer, nullable=False, default=0)
    added_datetime = Column(DateTime, nullable=False, default=datetime.utcnow)
    original_response_id = Column(Integer, nullable=False, default=0)
    new_response_id = Column(Integer, nullable=False, default=0)
    obo_user_posted = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)

class PartnersSessionCurriculum(Base,db.Model):
    __tablename__ = 'partners_session_curriculum'
    id = Column(Integer, primary_key=True, nullable=False)
    curr_id = Column(Integer, ForeignKey(Curriculum.id), nullable=False, default=0)
    p_session_id = Column(Integer, ForeignKey('partners_session.id'), nullable=False, default=0)
    p_session = relationship(u'PartnersSession', foreign_keys=[p_session_id])
    curr = relationship(Curriculum, foreign_keys=[curr_id])
    __table_args__ = (UniqueConstraint('curr_id', 'p_session_id'),)

class DocTitleMapping(Base,db.Model):
    __tablename__ = 'canvas_doc_title_mapping'
    id = Column(Integer, primary_key=True, nullable=False)
    orig_doc_id = Column(Text, nullable=True, default=None, unique=True)
    doc_title = Column(Text, nullable=True, default=None)

# Flags allow overrides for certains lessons and students/classes.
# See Flag Names, above
class FlaggedLesson(Base,db.Model):
    __tablename__ = 'canvas_flagged_lesson'
    id = Column(Integer, primary_key=True, nullable=False)
    # Null user_id means apply this to everyone in the partner site (class)
    user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    matched_user_id = Column(Integer, ForeignKey(IuserUser.id), nullable=True, default=None)
    matched_persona_id = Column(Integer, ForeignKey(IuserPersona.id), nullable=True, default=None)
    parent_curriculum_id = Column(Integer, ForeignKey(Curriculum.id), nullable=False, default=0)
    partner_site_id = Column(Integer, ForeignKey(PartnersPartner.id), nullable=False, default=0)
    parent_widget_content_id = Column(Integer, ForeignKey(WidgetContent.id), nullable=False, default=0)
    flag_name = Column(String(50), nullable=False, default='NOT SET')
    flag_bool_value = Column(Boolean, nullable=False, default=False)
    __table_args__ = (UniqueConstraint('user_id', 'parent_curriculum_id','partner_site_id','parent_widget_content_id','flag_name'),)
