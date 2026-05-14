"""
Telegram Bot Webhook Service
─────────────────────────────
Receives channel_post updates from Telegram and saves them as News articles.
"""
import os
import requests
from datetime import datetime
from extensions import db
from models.models import News
from services.fcm_service import send_news_notification

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


def get_file_url(file_id: str) -> str | None:
    """Get a downloadable URL for a Telegram file."""
    if not BOT_TOKEN:
        return None
    resp = requests.get(f'{BASE_URL}/getFile', params={'file_id': file_id})
    data = resp.json()
    if data.get('ok'):
        file_path = data['result']['file_path']
        return f'https://api.telegram.org/file/bot{BOT_TOKEN}/{file_path}'
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
        image_url = get_file_url(largest['file_id'])

    # Handle video thumbnail
    video = post.get('video')
    if video and not image_url:
        thumb = video.get('thumbnail') or video.get('thumb')
        if thumb:
            image_url = get_file_url(thumb['file_id'])

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
