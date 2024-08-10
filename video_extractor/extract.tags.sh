#!/bin/bash

# Read HTML file
html_content=$(<page_1.html)

# Extract tags with specified class attribute using grep
target_tags=$(echo "$html_content" | grep -o '<a class="video-thumb__image-container role-pop thumb-image-container">.*</a>')

# Write extracted tags to a new text file
echo "$target_tags" > page_1.tags.txt

echo "Tags extracted and saved to page_1.tags.txt"