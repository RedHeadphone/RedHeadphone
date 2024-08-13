#!/bin/bash

# Directory to save images
stats_dir="stats"
mkdir -p "$stats_dir"

# Associative array mapping image file names to API endpoints
declare -A image_api_endpoints=(
    ["github_stats.svg"]="https://github-readme-stats.vercel.app/api?username=RedHeadphone&show_icons=true&hide=contribs&theme=github_dark&border_color=30363d"
    ["top_langs.svg"]="https://github-readme-stats.vercel.app/api/top-langs/?username=RedHeadphone&layout=compact&langs_count=6&theme=github_dark&border_color=30363d"
    ["codeforces_stats.svg"]="https://codeforces-readme-stats.vercel.app/api/card?username=redheadphone&theme=github_dark&force_username=true&border_color=30363d"
    ["leetcode_stats.svg"]="https://leetcard.jacoblin.cool/redheadphone?theme=dark&font=noto_sans&ext=contest&sheets=https://gist.githubusercontent.com/RedHeadphone/5e715e284c89cace8f5fa09f7fb930b8/raw/6b4681ebf1b7e2943d0b3ed60251a31939562296/leetcode_stats_card.css"
)

# Function to download an image
download_image() {
    local image_name="$1"
    local url="$2"
    curl -o "${stats_dir}/${image_name}" -s -w "%{http_code}" "${url}" | {
        read -r http_code
        if [ "$http_code" != "200" ]; then
            echo "Failed to download ${image_name} from ${url}"
        fi
    }
}

# Main loop to download all images
for image_name in "${!image_api_endpoints[@]}"; do
    download_image "$image_name" "${image_api_endpoints[$image_name]}"
done
