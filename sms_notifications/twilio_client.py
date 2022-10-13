# -*- coding: iso8859-15 -*-
import os,sys
import traceback
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.settings import ENV_TYPE
from config.project_globals import app 
from twilio.rest import TwilioRestClient
 
from config.settings import TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, \
        TWILIO_PHONE_NUMBER

 
class TwilioClient(object):
    def __init__(self): 
        self.client = TwilioRestClient(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

    def send_message(self, recipient, sender, body):
        '''
        Returns SID or error. Stubbed for DEV testing, since we only have a prod key.
        '''
        if ENV_TYPE == 'Production':
            try:
                message = self.client.messages.create( \
                    body=body, to=recipient, \
                    from_=TWILIO_PHONE_NUMBER)
                return message.sid,None
            except:
               return None,traceback.format_exc()

        else:
            app.logger.warning("Testing Twilio in Dev, not crashing. This is what we would have sent: to: {0} from: {1} body: {2}".format(
                recipient,TWILIO_PHONE_NUMBER,body))
            return "FAKE_SID",None

if __name__ == "__main__":
    # change this phone to a verified recipient phone num
    # if sending via trial account
    recipient_phone = '+1xxxxxxxxxx'
    recipient_phone = '8675309'
    sid = TwilioClient().send_message(recipient_phone, TWILIO_PHONE_NUMBER,\
            'Testing out python to Twilio client!')
    print sid
