#!/usr/bin/env python
import subprocess
import sys
import re
import time
import logging

log = logging.getLogger(__file__)
logging.basicConfig(
    level=logging.INFO
)

pat = sys.argv[1]
regex = re.compile(pat)
cmd = sys.argv[2:]


while True:
    log.info("Executing {cmd}".format(cmd=cmd))
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, error) = proc.communicate()
    log.info(
        "{cmd} output: \n {output}".format(cmd=cmd, output=output)
    )
    if regex.search(output):
        log.info("Pattern found in output")
        sys.exit(0)
    else:
        log.info(
            "Pattern '{pat}' not found, sleeping for 1s and trying again".format(pat=pat)
        )
        time.sleep(1)

