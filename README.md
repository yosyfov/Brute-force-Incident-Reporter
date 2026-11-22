# Simple Brute-force Detection Tool + AI Narration

A deterministic detection tool with an AI narrator.

## The scripts

A set of three scripts:

- **detect.sh** — analyses the log provided, counts the failed IP login attempts and shouts an alert for IPs which failed more than 5 times, alerting for a potential brute-force attack

- **evidence.sh** — prints evidence including the attacker IP, exact number of failed login attempts, the specific usernames which this IP targeted with timestamps of first and last login attempt, as well as indicating a successful login (Breach) from "IP" on "port num"

- **report.sh** — the part which connects the evidence.sh script to an LLM with a specific prompt to structure a response based on the data, combining all the information from the previous two scripts into a more reader friendly format with some generic mitigation strategies

## Requirements to run

Kali Linux, a small local model such as llama3.2 and the “jq” command.

Install the model runner and the model on your Linux machine, as well as the jq command:

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3.2
sudo apt install jq -y
```


## How to run and use the tool

- **detect.sh** — says if an attack happened
- **evidence.sh** — prints the facts
- **report.sh** — AI model writes an incident report

Point any of the scripts at the file with the logins, e.g.:

```bash
./report.sh fakelog
```



## Sample output for ./report.sh fakelog

**Incident Report**

**Summary:** Unauthorized SSH login attempt from a known malicious IP address.

**What Happened:** An attacker successfully logged in to the system using the credentials "admin" on multiple attempts, targeting usernames "oracle root test" from a known malicious IP address (185.199.108.153).

**Severity Rating:** High (8/10)

The attacker was able to successfully log in to the system using multiple attempts, indicating a level of sophistication and persistence. The use of a known malicious IP address and multiple usernames targeted increases the severity of the incident.

**Recommended Actions:**

1. Immediately revoke the "admin" username and any other credentials used by the attacker.
2. Block the IP address (185.199.108.153) from further login attempts.
3. Conduct a thorough investigation to determine the scope of the breach and identify any other potential vulnerabilities.
4. Implement additional security measures, such as two-factor authentication and IP whitelisting, to prevent similar incidents in the future.
5. Notify relevant stakeholders, including management and incident response teams, to ensure prompt action and containment.


## Limitations

- Does not work with a variety of file formats — only on Linux SSH log in its standard text format
- Does not work on any other log types
- Only useful for SSH-focused attacks, and assumes an attacker uses a single IP multiple times instead of spreading to hundreds of different ones to avoid detection
- The tool is on demand, meaning no live view of brute-force attacks

*The fakelog in this project is simulated data for demonstration purposes.*

