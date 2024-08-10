#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input_file output_file"
  exit 1
fi

input_file="$1"
output_file="$2"

# Extract URLs, remove duplicates, and save to the output file
grep -o 'https://xhamster\.com/videos/[^ \"]*' "$input_file" | sort | uniq > "$output_file"

echo "Processed URLs have been saved to $output_file"