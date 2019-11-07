#!/bin/bash
# Give file with not reachable IPs as args to get corresponding MAC

cat $1 | grep -f mac.txt | awk '{print($2,"\t", $4)}' | sed -e 's\(\\g; s\)\\g'