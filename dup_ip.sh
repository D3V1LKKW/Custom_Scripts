#!/bin/bash

# Get the script name without the directory
script_name=$(basename "$0")

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $script_name input_filename"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "$1: File not found!"
    exit 1
fi

# File containing the IP addresses
input_file=$1

# Use awk to find duplicate IPs and print them
echo "Checking for duplicate IPs..."
awk '
{
    count[$0]++
}
END {
    for (ip in count) {
        if (count[ip] > 1) {
            print ip " appears " count[ip] " times"
        }
    }
}' "$input_file"

# Ask the user if they want to remove duplicates
read -p "Do you want to remove duplicate IPs? (yes/no): " answer

# Convert answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [ "$answer" = "yes" ]; then
    # Ask for the output filename
    read -p "Enter the output filename: " output_file

    # Remove duplicate IPs and save the output to the specified file
    echo "Removing duplicate IPs and saving the output to $output_file..."
    awk '!seen[$0]++' "$input_file" > "$output_file"
    echo "Output saved to $output_file"
else
    echo "No changes made."
fi

