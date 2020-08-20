#!/usr/bin/python3

import os
import signal
import sys
from supervisor.childutils import listener

supervisor_pid = 1

if os.path.exists('/tmp/supervisord.pid'):
    with open('/tmp/supervisord.pid', 'r') as f:
        supervisor_pid = int(f.read())

def signal_handler(signum, frame):
    sys.exit(0)

signal.signal(signal.SIGTERM, signal_handler)
signal.signal(signal.SIGQUIT, signal_handler)

# if any process transitions to FATAL state we ask supervisord to exit
while True:
    headers, body = listener.wait(sys.stdin, sys.stdout)

    try:
        if headers['eventname'] == 'PROCESS_STATE_FATAL':
            os.kill(supervisor_pid, signal.SIGTERM)
    except Exception as e:
        listener.fail(sys.stdout)
        sys.exit(1)
    else:
        listener.ok(sys.stdout)
