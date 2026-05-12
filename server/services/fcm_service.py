import firebase_admin
from firebase_admin import credentials, messaging
import os

def _ensure_initialized():
    if not firebase_admin._apps:
        key_path = os.getenv('FIREBASE_CREDENTIALS', 'serviceAccountKey.json')
        if not os.path.exists(key_path):
            return False
        cred = credentials.Certificate(key_path)
        firebase_admin.initialize_app(cred)
    return True

_CATEGORY_TOPIC = {
    'Woreda': 'woreda_updates',
    'Culture': 'cultural_events',
    'News': 'woreda_updates',
}

def send_news_notification(article):
    if not _ensure_initialized():
        print('[FCM] Skipped: serviceAccountKey.json not found')
        return
    topic = _CATEGORY_TOPIC.get(article.category, 'woreda_updates')
    message = messaging.Message(
        notification=messaging.Notification(
            title=article.title,
            body=article.content[:100],
        ),
        topic=topic,
    )
    messaging.send(message)
