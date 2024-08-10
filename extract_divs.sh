#!/bin/bash

# Folder containing the downloaded HTML files
input_folder="eagle_japan_videos"

# Loop through each HTML file in the folder
for html_file in "$input_folder"/*.html
do
    # Define the output file name (original name with _video_list appended)
    output_file="${html_file%.html}_video_list.html"

    # Extract the div with id="video-list" and all its child divs
    sed -n '/<div id="video-list"/,/<\/div>/p' "$html_file" > "$output_file"

    echo "Created: $output_file"

done

echo "All video list files created."
