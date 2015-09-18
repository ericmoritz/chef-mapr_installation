#!/usr/bin/env bash
for node in $*; do
    echo Node: ${node}
    echo 'srvr' | nc -w 1 $node 5181
    echo
done
