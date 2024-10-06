#!/bin/bash

# Directory to save images
stats_dir="stats"
mkdir -p "$stats_dir"

# Associative array mapping image file names to API endpoints
declare -A image_api_endpoints=(
    ["github_stats.svg"]="https://github-readme-stats.vercel.app/api?username=RedHeadphone&show_icons=true&hide=contribs&theme=github_dark&border_color=30363d"
    ["top_langs.svg"]="https://github-readme-stats.vercel.app/api/top-langs/?username=RedHeadphone&layout=compact&langs_count=6&theme=github_dark&border_color=30363d&size_weight=0.5&count_weight=0.5&hide=css"
    ["codeforces_stats.svg"]="https://codeforces-readme-stats.vercel.app/api/card?username=redheadphone&theme=github_dark&force_username=true&border_color=30363d"
    ["leetcode_stats.svg"]="https://leetcard.jacoblin.cool/redheadphone?theme=dark&font=noto_sans&ext=contest&sheets=https://gist.githubusercontent.com/RedHeadphone/5e715e284c89cace8f5fa09f7fb930b8/raw/164541033f8ae34e5ef6789c0d1ee627ece80f01/leetcode_stats_card.css"
)

# Function to download an image
download_image() {
    local image_name="$1"
    local url="$2"
    local temp_file="$(mktemp)" # Create a temporary file

    # Download the image into the temporary file
    http_code=$(curl -o "$temp_file" -s -w "%{http_code}" "$url")
    
    if [ "$http_code" == "200" ]; then
        mv "$temp_file" "${stats_dir}/${image_name}" # Move the temp file to the final destination
    else
        echo "Failed to download ${image_name} from ${url}. HTTP status: $http_code"
        rm -f "$temp_file" # Delete the temporary file
    fi
}

# Main loop to download all images
for image_name in "${!image_api_endpoints[@]}"; do
    download_image "$image_name" "${image_api_endpoints[$image_name]}"
done
