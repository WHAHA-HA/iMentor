# -*- coding: iso8859-15 -*-
import os,sys
import pprint

appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
projdir2 = os.path.abspath(os.path.join(appdir,'../..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)
    sys.path.append(projdir2)

from config.settings import APN_USE_SANDBOX,APN_CERT_FILE,FCM_API_KEY
from mobile_notifications.ios.apns import APNs,Payload
from mobile_notifications.android.fcm import FCMNotification
from mobile_notifications.models import PushDevice,PushNotification
from new_platform.utils.user_details import get_persona_obj_for_user
from auth import api, app

from config.project_globals import (Base,metadata,
    DBSession,get_scoped_session,ENV_TYPE)

apns = APNs(use_sandbox=APN_USE_SANDBOX, cert_file=APN_CERT_FILE, key_file=APN_CERT_FILE)
fcm = FCMNotification(api_key=FCM_API_KEY)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Push notifications to a phone, etc., from our back end. 
def send_push_notification(user_id,message,sound='default',testing=False):
    RUN_TEST=testing

    local_db_session = get_scoped_session()

    push_devices = local_db_session.query(PushDevice).filter(
        PushDevice.user_id == user_id).filter(
        PushDevice.active == True).all()

    if not push_devices:
        app.logger.debug("Tried to send a mobile push notification to user {0}, but no device token was registered for this user. Rejected, not crashing.".format(user_id))
        return

    for push_device in push_devices:
        # Don't send pushnots from dev to people's phones.
        if ENV_TYPE != 'Production' and not RUN_TEST:
            app.logger.exception("Not a crash: fake push notification to user {0} from DEV:{1}".format(push_device.user_id,message))

        elif push_device.device_type.lower() == 'ios':
            payload = Payload(alert=message, sound=sound, badge=push_device.badge)
            apns.gateway_server.send_notification(push_device.push_token, payload)
    
        elif push_device.device_type.lower() == 'android':
            results = fcm.notify_single_device(
                             registration_id=push_device.push_token,
                             message_body=message,
                             message_title=message,
                             message_icon=None,
                             sound=None,
                             condition=None,
                             collapse_key=None,
                             delay_while_idle=False,
                             time_to_live=None,
                             restricted_package_name=None,
                             low_priority=False,
                             dry_run=False,
                             data_message=None,
                             click_action=None,
                             badge=push_device.badge,
                             color=None,
                             tag=None,
                             body_loc_key=None,
                             body_loc_args=None,
                             title_loc_key=None,
                             title_loc_args=None)

            pprint.pprint(results)

            if results["failure"]==1 and results["results"][0]["error"] == "NotRegistered":
                local_db_session.query(PushDevice).filter(
                    PushDevice.id == push_device.id).update({'active':False},synchronize_session=False)
                app.logger.exception("Not a crash: just a note that user's push token is not registered according to Google. Marking as inactive. User: {0} token:{1}, return value from Google: {2}".format(push_device.user_id,push_device.push_token,pprint.pformat(results)))
                local_db_session.commit()
                local_db_session.begin()

                continue

        else:
            app.logger.exception("Unidentified device type for user {0}, {1}, not sending push notifications.".format(push_device.user_id,push_device.device_type))
            continue

        notif = PushNotification(
            push_device_id = push_device.id,
            message = message,
            badge_value = push_device.badge,
            sound = sound)
        
        local_db_session.add(notif)

        # Increment unseen count for this device (called a badge).
        push_device.badge += 1

        local_db_session.commit()
        local_db_session.begin()

    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Badges are actually counts for unseen notifications.
# User may have mroe than one device. Seen on one
# device means seen on all.
def reset_badge_numbers(user_id):
    local_db_session = get_scoped_session()

    local_db_session.query(PushDevice).filter(
        PushDevice.user_id == user_id).update(
        {'badge':1})
    local_db_session.commit()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# User may have more than one device.
# We can add devices, but we have no clue if we're replacing a device.
# We'll have to prompt a user for used devices at some later time,
# to be able to clean this up.

class WrongDeviceTypeException(Exception):
    pass

def add_device_token(user_id,token,device_type,notes):
    local_db_session = get_scoped_session()

    if device_type.lower() not in ('ios','android'):
        raise WrongDeviceTypeException("Device type much match 'iOS' or 'Android'. Rejected device registration for user {0}, crashing!".format(user_id))

    pdev = local_db_session.query(PushDevice).filter(
        PushDevice.user_id == user_id).filter(
        PushDevice.device_type == device_type).filter(
        PushDevice.push_token == token).first()

    if not pdev:
        pdev = PushDevice(
            user_id=user_id,
            persona_id=get_persona_obj_for_user(user_id,ignore_match_status=True).id,
            push_token=token,
            device_type=device_type,
            device_notes=notes # Hopefully something like "Samsung Galaxy S6"
            )

        local_db_session.add(pdev)

    local_db_session.commit()

if __name__ == "__main__":
    import pdb;pdb.set_trace()
    send_push_notification(151865,"Hey there...",testing=True)
    pass
