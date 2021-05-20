from __future__ import print_function

import sys
import socket
import time

if len(sys.argv) == 1:
    print('Oracle hostname was not provided.')
    sys.exit(1)

hostname = sys.argv[1]
seconds = 0
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

while True:
    try:
        s.connect((sys.argv[1], 1521))
        break
    except:
        time.sleep(1)
        seconds += 1

s.close()

print('Oracle took approximately {0} seconds to fully start'.format(seconds))
