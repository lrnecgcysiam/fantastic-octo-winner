#!/bin/bash

# Folder containing the downloaded HTML files
input_folder="eagle_japan_videos"

# Loop through each HTML file in the folder
for html_file in "$input_folder"/*.html
do
    # Define the JSON output file name
    json_file="${html_file%.html}.json"

    # Extract the div blocks that contain the class "thumb-list__item"
    divs=$(grep -oP '<div class="thumb-list__item video-thumb video-thumb--type-video"[^>]*>' "$html_file")

    # Initialize an empty JSON array
    json_data="[]"

    # Loop through each extracted div
    while IFS= read -r div; do
        # Extract attributes using grep and regex
        video_id=$(echo "$div" | grep -oP 'data-video-id="\K[^"]+')
        duration=$(echo "$div" | grep -oP 'data-trailer-exp=".*?&quot;duration&quot;:\K\d+')
        format=$(echo "$div" | grep -oP 'data-trailer-exp=".*?&quot;format&quot;:&quot;\K[^&]+')
        resolution=$(echo "$div" | grep -oP 'data-trailer-exp=".*?&quot;resolution&quot;:&quot;\K[^&]+')
        href=$(echo "$div" | grep -oP 'href="\K[^"]+')

        # Create a JSON object for the div
        json_object=$(jq -n \
            --arg video_id "$video_id" \
            --arg duration "$duration" \
            --arg format "$format" \
            --arg resolution "$resolution" \
            --arg href "$href" \
            '{video_id: $video_id, duration: $duration, format: $format, resolution: $resolution, href: $href}')

        # Add the JSON object to the JSON array
        json_data=$(echo "$json_data" | jq --argjson new_item "$json_object" '. += [$new_item]')
    done <<< "$divs"

    # Write the JSON data to a file
    echo "$json_data" > "$json_file"
    echo "Created: $json_file"

done

echo "All JSON files created."
