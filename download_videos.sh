#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 urls_file output_directory"
  exit 1
fi

urls_file="$1"
output_directory="$2"

# Create output directory if it doesn't exist
mkdir -p "$output_directory"

# Read URLs from the file and download each one
while IFS= read -r url; do
  echo "Downloading: $url"
  yt-dlp -o "$output_directory/%(title)s.%(ext)s" "$url"
done < "$urls_file"

echo "All downloads completed."