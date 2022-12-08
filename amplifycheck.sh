#!/bin/bash

# Set the hostname or IP address of the NTP server to be tested
NTP_SERVER=1.1.1.1

# Set the maximum number of NTP server responses to receive before stopping the test
MAX_RESPONSES=5

# Set the number of seconds to wait for a response from the NTP server
RESPONSE_TIMEOUT=5

# Set the spoofed source address for the NTP requests
SPOOFED_SOURCE=2.2.2.2

# Set the NTP mode for the requests (e.g. mode 7 for monlist command)
NTP_MODE=7

# Set the NTP version for the requests (e.g. version 4 for NTPv4)
NTP_VERSION=4

# Send the NTP requests to the server and collect the responses
responses=$(ntpdc -n -c $NTP_MODE -v $NTP_VERSION -p $RESPONSE_TIMEOUT -s $SPOOFED_SOURCE $NTP_SERVER | grep "response" | wc -l)

# Check if the number of responses exceeds the maximum
if [ $responses -gt $MAX_RESPONSES ]; then
  echo "The NTP server is vulnerable to amplification attacks."
else
  echo "The NTP server is not vulnerable to amplification attacks."
fi
