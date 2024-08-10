#!/bin/bash

# Read HTML file
html_content=$(<page_2.extraction.html)

# Use grep to find URLs starting with https://www.tiktok.com/@rin_kiseki/video/
video_links=$(echo "$html_content" | grep -o 'https://xhamster.com/videos/[^ \"]*')

# Save video links to a new file
echo "$video_links" > page_2_urls.txt
echo "Video links extracted and saved to page_2_urls.txt"% 