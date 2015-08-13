#!/usr/bin/env python
import os
import subprocess
import sys
import re
import time
import logging

log = logging.getLogger(__file__)
logging.basicConfig(
    level=logging.INFO
)

node_count = int(sys.argv[1])
zk_count = int(sys.argv[2])

def is_role(name):
    return os.path.exists("/opt/mapr/roles/{name}".format(**locals()))


if is_role("zookeeper"):
    # start the zookeeper service
    subprocess.check_call(["service", "mapr-zookeeper", "start"])

if zk_count == 1:
    status_pat = "Mode: standalone"
else:
    status_pat = "(leader|follower)"

# wait for zookeepers to be ready
subprocess.check_call(
    ["/opt/mapr/server/scripts/waitfor.py", status_pat, "clush", "-g", "zk", "service", "mapr-zookeeper", "qstatus"]
)

# If this node is not a CLDB node, wait for CLDB to cluster
if not is_role("cldb"):
    subprocess.check_call(
        ["/opt/mapr/server/scripts/waitfor.py", "ServerID", "maprcli", "node", "cldbmaster"]
    )

# Start warden
subprocess.check_call(["service", "mapr-warden", "start"])


# wait for cluster to come up
cmd = ["maprcli", "node", "list", "-columns", "hostname"]
while True:
    log.info("Executing {cmd}".format(cmd=cmd))
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, error) = proc.communicate()
    up_count = len(output.splitlines()[1:])
    if up_count >= node_count:
        log.info("Cluster up")
        sys.exit(0)
    else:
        log.info("Only {up_count} of {count} nodes up, sleeping for 1s")
        time.sleep(1)
        
        
