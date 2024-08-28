#!/bin/bash

# Get the script name without the directory
script_name=$(basename "$0")

# Check if the script received exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $script_name <hostname>"
  exit 1
fi

# Get the hostname from the argument
hostname=$1

# Resolve the hostname to the first IP address using the host command
ip_address=$(host "$hostname" | awk '/has address/ { print $4; exit }')

# Check if the host command succeeded and found an IP address
if [ -z "$ip_address" ]; then
  echo "Could not resolve hostname: $hostname"
  exit 1
fi

# Output the resolved IP address
#echo "The first IP address of $hostname is $ip_address"

# Make a curl request to ipinfo.io with the resolved IP address
curl_response=$(curl -s "https://ipinfo.io/$ip_address")

# Check if the curl command succeeded
if [ -z "$curl_response" ]; then
  echo "Failed to get information from ipinfo.io"
  exit 1
fi

# Output the curl response
#echo "Information from ipinfo.io for IP address $ip_address:"
echo "$curl_response"
