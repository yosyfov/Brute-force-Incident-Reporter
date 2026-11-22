#!/bin/bash
logfile="$1"

# 1. Find the top attacker IP (most failed logins)
ip=$(grep "Failed password" "$logfile" | awk '{print $11}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# 2. Gather the facts about that IP
failures=$(grep "Failed password" "$logfile" | grep "$ip" | wc -l)
users=$(grep "Failed password" "$logfile" | grep "$ip" | awk '{print $9}' | sort | uniq | tr '\n' ' ')
first=$(grep "$ip" "$logfile" | grep "Failed" | head -n 1 | awk '{print $1, $2, $3}')
last=$(grep "$ip" "$logfile" | grep "Failed" | tail -n 1 | awk '{print $1, $2, $3}')
breach=$(grep "Accepted" "$logfile" | grep "$ip")

# 3. Print the evidence block
echo "=== EVIDENCE ==="
echo "Attacker IP: $ip"
echo "Failed attempts: $failures"
echo "Usernames targeted: $users"
echo "First attempt: $first"
echo "Last attempt: $last"
if [ -n "$breach" ]; then
    echo "BREACH: successful login from this IP -> $breach"
else
    echo "Breach: none"
fi
echo "================"

