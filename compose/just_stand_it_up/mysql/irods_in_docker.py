from __future__ import print_function

import os
import psutil

def get_pids_executing_binary_file(binary_file_path):
    def get_exe(process):
        if psutil.version_info >= (2,0):
            return process.exe()
        return process.exe
    abspath = os.path.abspath(binary_file_path)
    pids = []
    for p in psutil.process_iter():
        try:
            if abspath == get_exe(p):
                print('process gids    =', p.gids())
                print('process cmdline =', p.cmdline())
                pids.append(p.pid)
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            pass
    return pids

if __name__ == '__main__':
    print('pids =', get_pids_executing_binary_file('/usr/sbin/irodsServer'))
