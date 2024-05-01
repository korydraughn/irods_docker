from __future__ import print_function

import sys
import socket
import time

if len(sys.argv) < 3:
    print('Remote hostname or ip was not provided.')
    print('Usage: {0} <hostname-or-ip> <port>'.format(sys.argv[0]))
    sys.exit(1)

hostname = sys.argv[1]
port = sys.argv[2]
seconds = 0
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

while True:
    try:
        s.connect((hostname, port))
        break
    except:
        print('Failed to connect to remote host. Sleeping for one second ...')
        time.sleep(1)
        seconds += 1

s.close()

print('Remote host took approximately {0} seconds to accept connections.'.format(seconds))

