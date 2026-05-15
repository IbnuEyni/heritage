"""
Telegram Bot Webhook Service
─────────────────────────────
Receives channel_post updates from Telegram and saves them as News articles.
Images are downloaded and stored locally for permanent access.
"""
import os
import uuid
import logging
import requests
from datetime import datetime
from flask import current_app
from extensions import db
from models.models import News
from services.fcm_service import send_news_notification

logger = logging.getLogger(__name__)

BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN', '')
CHANNEL_ID = os.getenv('TELEGRAM_CHANNEL_ID', '')  # e.g. @kebena_news or -100xxxxx

BASE_URL = f'https://api.telegram.org/bot{BOT_TOKEN}'


def setup_webhook(app_url: str):
    """Register the webhook URL with Telegram."""
    webhook_url = f'{app_url}/api/v1/telegram/webhook'
    resp = requests.post(f'{BASE_URL}/setWebhook', json={'url': webhook_url})
    return resp.json()


def remove_webhook():
    """Remove the webhook (useful for debugging with polling)."""
    resp = requests.post(f'{BASE_URL}/deleteWebhook')
    return resp.json()


def _get_upload_dir() -> str:
    """Get the news upload directory, creating it if needed."""
    upload_dir = os.path.join(current_app.root_path, 'uploads', 'news')
    os.makedirs(upload_dir, exist_ok=True)
    return upload_dir


def download_and_save_file(file_id: str) -> str | None:
    """Download a file from Telegram and save it locally. Returns the relative URL path."""
    if not BOT_TOKEN:
        return None
    try:
        # Get file path from Telegram
        resp = requests.get(f'{BASE_URL}/getFile', params={'file_id': file_id})
        data = resp.json()
        if not data.get('ok'):
            return None

        file_path = data['result']['file_path']
        download_url = f'https://api.telegram.org/file/bot{BOT_TOKEN}/{file_path}'

        # Download the file
        file_resp = requests.get(download_url, timeout=30)
        if file_resp.status_code != 200:
            return None

        # Determine extension
        ext = os.path.splitext(file_path)[1] or '.jpg'
        filename = f"{uuid.uuid4().hex}{ext}"

        # Save to uploads/news/
        upload_dir = _get_upload_dir()
        save_path = os.path.join(upload_dir, filename)
        with open(save_path, 'wb') as f:
            f.write(file_resp.content)

        logger.info(f'Saved Telegram image: {filename}')
        return f'/uploads/news/{filename}'
    except Exception as e:
        logger.error(f'Failed to download Telegram file: {e}')
        return None


def _extract_category(text: str) -> str:
    """Extract category from hashtags in the message, default to 'News'."""
    category_map = {
        '#announcement': 'Announcement',
        '#event': 'Event',
        '#culture': 'Culture',
        '#development': 'Development',
        '#education': 'Education',
        '#sports': 'Sports',
    }
    lower = text.lower()
    for tag, cat in category_map.items():
        if tag in lower:
            return cat
    return 'News'


def _clean_text(text: str) -> str:
    """Remove hashtags from the display text."""
    lines = text.split('\n')
    cleaned = [l for l in lines if not l.strip().startswith('#')]
    return '\n'.join(cleaned).strip()


def process_channel_post(update: dict) -> News | None:
    """
    Process a Telegram channel_post update and save as News.
    Returns the created News object or None if skipped.
    """
    post = update.get('channel_post') or update.get('edited_channel_post')
    if not post:
        return None

    text = post.get('text') or post.get('caption') or ''
    if not text.strip():
        return None

    # Parse title (first line) and content (rest)
    lines = text.strip().split('\n', 1)
    title = lines[0].strip()
    content = lines[1].strip() if len(lines) > 1 else title

    # Clean hashtags from content
    category = _extract_category(text)
    title = _clean_text(title)
    content = _clean_text(content)

    if not title:
        return None

    # Handle photo
    image_url = None
    photos = post.get('photo')
    if photos:
        # Get the largest photo
        largest = max(photos, key=lambda p: p.get('file_size', 0))
        image_url = download_and_save_file(largest['file_id'])

    # Handle video thumbnail
    video = post.get('video')
    if video and not image_url:
        thumb = video.get('thumbnail') or video.get('thumb')
        if thumb:
            image_url = download_and_save_file(thumb['file_id'])

    # Create News entry
    article = News(
        title=title,
        content=content,
        image_url=image_url,
        category=category,
        timestamp=datetime.utcfromtimestamp(post['date']),
    )
    db.session.add(article)
    db.session.commit()

    # Send push notification
    send_news_notification(article)

    return article
