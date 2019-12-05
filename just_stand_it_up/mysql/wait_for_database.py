from __future__ import print_function

import socket
import time

seconds = 0
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

while True:
    try:
        s.connect(('localhost', 3306))
        break
    except:
        time.sleep(1)
        seconds += 1

s.close()

print('MySQL took approximately {0} seconds to fully start'.format(seconds))
