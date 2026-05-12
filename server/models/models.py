from extensions import db
from datetime import datetime


class Heritage(db.Model):
    __tablename__ = 'heritage_table'
    id         = db.Column(db.Integer, primary_key=True)
    title      = db.Column(db.String(200), nullable=False)
    content    = db.Column(db.Text, nullable=False)
    era        = db.Column(db.String(100), nullable=False)
    image_url  = db.Column(db.String(500))
    video_url  = db.Column(db.String(500))
    gallery    = db.Column(db.JSON, default=list)
    audio_url  = db.Column(db.String(500))
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id, 'title': self.title, 'content': self.content,
            'era': self.era, 'image_url': self.image_url,
            'video_url': self.video_url, 'gallery': self.gallery or [],
            'audio_url': self.audio_url,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class Dictionary(db.Model):
    __tablename__ = 'dictionary_table'
    id                  = db.Column(db.Integer, primary_key=True)
    kebena_word         = db.Column(db.String(200), nullable=False, index=True)
    amharic_translation = db.Column(db.String(200), nullable=False)
    english_translation = db.Column(db.String(200), nullable=False)
    audio_url           = db.Column(db.String(500))
    video_url           = db.Column(db.String(500))
    image_url           = db.Column(db.String(500))
    category            = db.Column(db.String(100))
    examples            = db.Column(db.JSON, default=list)
    synonyms            = db.Column(db.JSON, default=list)
    updated_at          = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id, 'kebena_word': self.kebena_word,
            'amharic_translation': self.amharic_translation,
            'english_translation': self.english_translation,
            'audio_url': self.audio_url, 'video_url': self.video_url,
            'image_url': self.image_url, 'category': self.category,
            'examples': self.examples or [], 'synonyms': self.synonyms or [],
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class News(db.Model):
    __tablename__ = 'news_table'
    id         = db.Column(db.Integer, primary_key=True)
    title      = db.Column(db.String(200), nullable=False)
    content    = db.Column(db.Text, nullable=False)
    image_url  = db.Column(db.String(500))
    video_url  = db.Column(db.String(500))
    gallery    = db.Column(db.JSON, default=list)
    category   = db.Column(db.String(50), nullable=False, default='News')
    timestamp  = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id, 'title': self.title, 'content': self.content,
            'image_url': self.image_url, 'video_url': self.video_url,
            'gallery': self.gallery or [], 'category': self.category,
            'timestamp': self.timestamp.isoformat(),
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class Admin(db.Model):
    __tablename__ = 'admins'
    id            = db.Column(db.Integer, primary_key=True)
    username      = db.Column(db.String(80), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)


class Event(db.Model):
    __tablename__ = 'events_table'
    id          = db.Column(db.Integer, primary_key=True)
    title       = db.Column(db.String(200), nullable=False)
    description = db.Column(db.Text, nullable=False)
    location    = db.Column(db.String(200), nullable=False)
    start_date  = db.Column(db.DateTime, nullable=False)
    end_date    = db.Column(db.DateTime, nullable=False)
    image_url   = db.Column(db.String(500))
    video_url   = db.Column(db.String(500))
    gallery     = db.Column(db.JSON, default=list)

    def to_dict(self):
        return {
            'id': self.id, 'title': self.title,
            'description': self.description, 'location': self.location,
            'start_date': self.start_date.isoformat(),
            'end_date': self.end_date.isoformat(),
            'image_url': self.image_url, 'video_url': self.video_url,
            'gallery': self.gallery or [],
        }


class Hero(db.Model):
    """Kebena historical heroes — warriors, scholars, spiritual leaders."""
    __tablename__ = 'heroes_table'
    id             = db.Column(db.Integer, primary_key=True)
    name           = db.Column(db.String(200), nullable=False)
    title          = db.Column(db.String(200), nullable=False)   # Imam, Sheikh, Garad…
    era            = db.Column(db.String(100), nullable=False)
    birth_year     = db.Column(db.String(20))
    death_year     = db.Column(db.String(20))
    short_bio      = db.Column(db.String(500), nullable=False)   # 1-2 sentence summary
    full_story     = db.Column(db.Text, nullable=False)          # full narrative
    legacy         = db.Column(db.Text, nullable=False)          # lesson for this generation
    bravery_quote  = db.Column(db.String(500))
    image_url      = db.Column(db.String(500))
    category       = db.Column(db.String(100), nullable=False)   # Warrior|Scholar|Leader|Spiritual
    updated_at     = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id, 'name': self.name, 'title': self.title,
            'era': self.era, 'birth_year': self.birth_year,
            'death_year': self.death_year, 'short_bio': self.short_bio,
            'full_story': self.full_story, 'legacy': self.legacy,
            'bravery_quote': self.bravery_quote, 'image_url': self.image_url,
            'category': self.category,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class DidYouKnow(db.Model):
    """Curated cultural facts for the home screen carousel."""
    __tablename__ = 'did_you_know_table'
    id           = db.Column(db.Integer, primary_key=True)
    emoji        = db.Column(db.String(10), nullable=False)
    label        = db.Column(db.String(100), nullable=False)     # e.g. "Coffee Culture"
    fact         = db.Column(db.String(600), nullable=False)     # short teaser
    detail       = db.Column(db.Text, nullable=False)            # full detail page body
    accent_color = db.Column(db.String(20), nullable=False)      # hex e.g. "#6B3A2A"
    source       = db.Column(db.String(300))                     # historical/academic source
    category     = db.Column(db.String(100), nullable=False)
    updated_at   = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id, 'emoji': self.emoji, 'label': self.label,
            'fact': self.fact, 'detail': self.detail,
            'accent_color': self.accent_color, 'source': self.source,
            'category': self.category,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }
