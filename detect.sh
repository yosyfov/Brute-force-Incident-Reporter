#!/bin/bash
logfile="$1"

awk '/Failed password/ {count[$11]++} END {for (ip in count) if (count[ip] > 5) print "[ALERT]", ip, "had", count[ip], "failed logins - possible brute-force"}' "$logfile"
