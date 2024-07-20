import requests
import os

# Directory to save images
stats_dir = "stats"
os.makedirs(stats_dir, exist_ok=True)

# Dictionary mapping image file names to API endpoints
image_api_endpoints = {
    "github_stats.svg": "https://github-readme-stats.vercel.app/api?username=RedHeadphone&show_icons=true&count_private=true&theme=github_dark&border_color=404040",
    "top_langs.svg": "https://github-readme-stats.vercel.app/api/top-langs/?username=RedHeadphone&layout=compact&langs_count=6&theme=github_dark&border_color=404040",
    "codeforces_stats.svg": "https://codeforces-readme-stats.vercel.app/api/card?username=RedHeadphone&theme=github_dark&force_username=true&border_color=404040",
    "leetcode_stats.svg": "https://leetcard.jacoblin.cool/redheadphone?theme=dark&font=Ubuntu&cache=14400&ext=contest&sheets=https://gist.githubusercontent.com/RedHeadphone/5e715e284c89cace8f5fa09f7fb930b8/raw/ec0be570f114124b1a2156a660d67baa0ab5639d/leetcode_stats_card.css",
}

def download_image(image_name, url):
    response = requests.get(url)
    if response.status_code == 200:
        with open(os.path.join(stats_dir, image_name), 'wb') as file:
            file.write(response.content)
    else:
        print(f"Failed to download {image_name} from {url}")

if __name__ == "__main__":
    for image_name, url in image_api_endpoints.items():
        download_image(image_name, url)
