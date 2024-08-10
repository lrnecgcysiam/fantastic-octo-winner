#!/bin/bash

# Base URL
base_url="https://xhamster.com/users/eagle_japan/videos/"

# Folder to save the HTML files
output_folder="eagle_japan_videos"

# Create the folder if it doesn't exist
mkdir -p "$output_folder"

# Loop through the pages from 1 to 83
for i in {1..83}
do
    # Construct the full URL for each page
    url="${base_url}${i}"

    # Define the output filename
    output_file="${output_folder}/page_${i}.html"

    # Download the page and save it to the output file
    wget -q -O "$output_file" "$url"

    echo "Downloaded: $url -> $output_file"
done

echo "All pages downloaded."
