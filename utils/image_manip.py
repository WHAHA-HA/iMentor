# -*- coding: iso8859-15 -*-
import pdb
import pprint
import copy
import os,sys
import errno
import random
import string
from datetime import datetime
appdir = os.path.abspath(os.path.dirname(__file__))
projdir = os.path.abspath(os.path.join(appdir,'..'))
if projdir not in sys.path:
    sys.path.append(appdir)
    sys.path.append(projdir)

from config.project_globals import db,Base,metadata,url_cache,DBSession
from config.settings import (ENV_TYPE,LOGIN_DISABLED,
    DEFAULT_TEST_USER_ID,UPLOAD_FOLDER,MAX_URL_CACHE_SECONDS,
    ALLOWED_FILE_TYPES)

#Import 'app' object from auth as well
from auth import api, app

from PIL import Image
from PIL.ExifTags import TAGS

def random_string(strlen):
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(strlen))

def fix_orientation(image_file):
    img = Image.open(image_file)
    tags = img._getexif()
    for t in tags:
        #print "{0}|{1}|{2}".format(TAGS[t],t,tags[t])

        '''
Thanks to http://sylvana.net/jpegcrop/exif_orientation.html

        Value	0th Row	0th Column
        1	top	left side
        2	top	right side
        3	bottom	right side
        4	bottom	left side
        5	left side	top
        6	right side	top
        7	right side	bottom
        8	left side	bottom

  1        2       3      4         5            6           7          8

888888  888888      88  88      8888888888  88                  88  8888888888
88          88      88  88      88  88      88  88          88  88      88  88
8888      8888    8888  8888    88          8888888888  8888888888          88
88          88      88  88
88          88  888888  888888
        '''
        if TAGS[t] == 'Orientation':
            if tags[t] == 1:
                out = img
            elif tags[t] == 2:
                out = img.transpose(Image.FLIP_LEFT_RIGHT)
            elif tags[t] == 3:
                out = img.rotate(180) # degrees counter-clockwise
            elif tags[t] == 4:
                out = img.transpose(Image.FLIP_TOP_BOTTOM)
            elif tags[t] == 5:
                out = img.transpose(Image.FLIP_TOP_BOTTOM).rotate(-90) # degrees counter-clockwise
            elif tags[t] == 6:
                out = img.rotate(-90) # degrees counter-clockwise
            elif tags[t] == 7:
                out = img.transpose(Image.FLIP_TOP_BOTTOM).rotate(90) # degrees counter-clockwise
            elif tags[t] == 8:
                out = img.rotate(90) # degrees counter-clockwise
            random_name = os.path.dirname(image_file) + '/' + random_string(20) + '.png'
            out.save(random_name)
            return random_name
   

# Credit to https://gist.github.com/sigilioso/2957026
def resize_and_crop(img_path, modified_path, size, crop_type='top'):
    """
    Resize and crop an image to fit the specified size.

    args:
        img_path: path for the image to resize.
        modified_path: path to store the modified image.
        size: `(width, height)` tuple.
        crop_type: can be 'top', 'middle' or 'bottom', depending on this
            value, the image will cropped getting the 'top/left', 'midle' or
            'bottom/rigth' of the image to fit the size.
    raises:
        Exception: if can not open the file in img_path of there is problems
            to save the image.
        ValueError: if an invalid `crop_type` is provided.
    """
    # If height is higher we resize vertically, if not we resize horizontally
    img = Image.open(img_path)
    # Get current and desired ratio for the images
    img_ratio = img.size[0] / float(img.size[1])
    ratio = size[0] / float(size[1])
    #The image is scaled/cropped vertically or horizontally depending on the ratio
    if ratio > img_ratio:
        img = img.resize((size[0], size[0] * img.size[1] / img.size[0]),
                Image.ANTIALIAS)
        # Crop in the top, middle or bottom
        if crop_type == 'top':
            box = (0, 0, img.size[0], size[1])
        elif crop_type == 'middle':
            box = (0, (img.size[1] - size[1]) / 2, img.size[0], (img.size[1] + size[1]) / 2)
        elif crop_type == 'bottom':
            box = (0, img.size[1] - size[1], img.size[0], img.size[1])
        else :
            raise ValueError('ERROR: invalid value for crop_type')
        img = img.crop(box)
    elif ratio < img_ratio:
        img = img.resize((size[1] * img.size[0] / img.size[1], size[1]),
                Image.ANTIALIAS)
        # Crop in the top, middle or bottom
        if crop_type == 'top':
            box = (0, 0, size[0], img.size[1])
        elif crop_type == 'middle':
            box = ((img.size[0] - size[0]) / 2, 0, (img.size[0] + size[0]) / 2, img.size[1])
        elif crop_type == 'bottom':
            box = (img.size[0] - size[0], 0, img.size[0], img.size[1])
        else :
            raise ValueError('ERROR: invalid value for crop_type')
        img = img.crop(box)
    else :
        img = img.resize((size[0], size[1]),
                Image.ANTIALIAS)
        # If the scale is the same, we do not need to crop
    img.save(modified_path)


if __name__ == "__main__":
    pdb.set_trace()
    newfile = fix_orientation('/home/gloriajw/Pictures/20140329_123154.jpg')
    newfile = fix_orientation('/home/gloriajw/Pictures/20140305_211522.jpg')

    random_name = os.path.dirname(newfile) + '/' + random_string(20) + '.png'
    resize_and_crop(newfile, random_name, (128,128), crop_type='top')
    
