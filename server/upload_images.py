"""
Kebena Heritage — Image Upload Script
======================================
1. Drop your real Kebena photos into the  my_kebena_photos/  folder
2. Rename them to match the article they belong to (see PHOTO_MAP below)
3. Run:  python3 upload_images.py

The script will:
  - Log in as admin automatically
  - Upload each photo to the correct heritage article
  - Print the live URL stored in the database
"""
import os, sys, requests

BASE_URL  = 'http://localhost:8001'
USERNAME  = 'admin'
PASSWORD  = 'kebena@admin2025'
PHOTO_DIR = os.path.join(os.path.dirname(__file__), 'my_kebena_photos')

# ── Map filename  →  heritage article ID ─────────────────────────────────────
# Rename your photos to these exact filenames before running the script.
# Supported formats: .jpg  .jpeg  .png  .webp
ALLOWED_EXTS = {'jpg', 'jpeg', 'png', 'webp', 'gif', 'bmp', 'tiff', 'heic'}

# ── Map base name (no extension)  →  heritage article ID ─────────────────────
# Just name your photo file with the base name below — any extension works.
# e.g.  founding.jpg  /  founding.jpeg  /  founding.png  all work.
PHOTO_MAP = {
    'founding':        9,   # The Founding of the Kebena Kingdom
    'garad_hassan':    10,  # Garad Hassan Enjamo — The Great Warrior Chief
    'affoo_language':  11,  # The Affoo Language — A Living Heritage
    'trade_routes':    12,  # Kebena Trade Routes and the Akaki River Economy
    'governance':      15,  # Traditional Kebena Governance
    'coffee_ceremony': 16,  # The Kebena Coffee Ceremony Tradition
    'imperial_era':    13,  # The Kebena and the Imperial Era
    'woreda_2023':     14,  # Establishment of Kebena Special Woreda
    'woreda':          14,
    'oget':            9,
    'seera':           15,
    'community':       14,
}


def login():
    res = requests.post(f'{BASE_URL}/api/v1/auth/login',
                        json={'username': USERNAME, 'password': PASSWORD})
    res.raise_for_status()
    return res.json()['access_token']


def upload(token, article_id, filepath):
    headers = {'Authorization': f'Bearer {token}'}
    with open(filepath, 'rb') as f:
        ext  = filepath.rsplit('.', 1)[-1].lower()
        mime = 'image/jpeg' if ext in ('jpg', 'jpeg') else f'image/{ext}'
        res  = requests.post(
            f'{BASE_URL}/api/v1/heritage/{article_id}/upload-image',
            headers=headers,
            files={'image': (os.path.basename(filepath), f, mime)},
        )
    return res


def main():
    if not os.path.isdir(PHOTO_DIR):
        print(f'✗  Folder not found: {PHOTO_DIR}')
        sys.exit(1)

    # Build a lookup: base_name -> actual filepath (any allowed extension)
    available = {}
    for f in os.listdir(PHOTO_DIR):
        parts = f.rsplit('.', 1)
        if len(parts) == 2 and parts[1].lower() in ALLOWED_EXTS:
            base = parts[0].lower()
            available[base] = os.path.join(PHOTO_DIR, f)

    to_upload = {}
    for base_name, article_id in PHOTO_MAP.items():
        if base_name.lower() in available:
            to_upload[base_name] = (article_id, available[base_name.lower()])
        else:
            print(f'  –  skipping  {base_name}.*  (not found in my_kebena_photos/)')

    if not to_upload:
        print('\n  No matching photos found. Add images to:')
        print(f'  {PHOTO_DIR}')
        print('\n  Expected base names (any extension):')
        for base, aid in PHOTO_MAP.items():
            print(f'    {base:<25} → article id {aid}')
        sys.exit(0)

    print(f'\nLogging in as {USERNAME}...')
    try:
        token = login()
        print('\u2713  Authenticated\n')
    except Exception as e:
        print(f'\u2717  Login failed: {e}')
        sys.exit(1)

    for base_name, (article_id, path) in to_upload.items():
        fname = os.path.basename(path)
        print(f'  Uploading  {fname}  → article {article_id} ...', end=' ', flush=True)
        try:
            res = upload(token, article_id, path)
            if res.status_code == 200:
                print(f'\u2713  {res.json()["image_url"]}')
            else:
                print(f'\u2717  HTTP {res.status_code}: {res.text}')
        except Exception as e:
            print(f'\u2717  {e}')

    print('\n\u2705  Done. Restart the app to see your images.')


if __name__ == '__main__':
    main()
