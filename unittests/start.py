#!/usr/bin/env python
import sys
import nose

if __name__ == '__main__':
    sys.path.append('./modules/')
    sys.path.append('./webdrivers/')
    print (sys.argv)
    nose.run()
else:
    print('Do not run this way. use runtests.sh or runtests.ps1 script')
