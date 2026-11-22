#!/bin/bash
logfile="$1"

# 1. Get the evidence block from the Rung 3 script
evidence=$(./evidence.sh "$logfile")

# 2. Write the analyst instruction and attach the evidence
prompt="You are a SOC analyst. Based on the evidence below from an authentication log, write a short incident report with: a one-line summary, what happened, a severity rating, and recommended actions.

EVIDENCE:
$evidence"

# 3. Send it to the local model, capture the reply
response=$(curl -s http://localhost:11434/api/generate \
  -d "$(jq -n --arg m "llama3.2" --arg p "$prompt" '{model:$m, prompt:$p, stream:false}')")

# 4. Pull just the report text out of the JSON that came back
echo "$response" | jq -r '.response'

