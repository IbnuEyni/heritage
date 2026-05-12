from extensions import db
from datetime import datetime

_SUPPORTED_LANGS = {'en', 'am', 'om'}


def _loc(obj, field, lang):
    """Return the localized value for field, falling back to English."""
    if lang and lang != 'en' and lang in _SUPPORTED_LANGS:
        val = getattr(obj, f'{field}_{lang}', None)
        if val:
            return val
    return getattr(obj, field)


class Heritage(db.Model):
    __tablename__ = 'heritage_table'
    id         = db.Column(db.Integer, primary_key=True)
    title      = db.Column(db.String(200), nullable=False)
    title_am   = db.Column(db.String(200))
    title_om   = db.Column(db.String(200))
    content    = db.Column(db.Text, nullable=False)
    content_am = db.Column(db.Text)
    content_om = db.Column(db.Text)
    era        = db.Column(db.String(100), nullable=False)
    era_am     = db.Column(db.String(100))
    era_om     = db.Column(db.String(100))
    image_url  = db.Column(db.String(500))
    video_url  = db.Column(db.String(500))
    gallery    = db.Column(db.JSON, default=list)
    audio_url  = db.Column(db.String(500))
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self, lang='en'):
        return {
            'id': self.id,
            'title':      _loc(self, 'title', lang),
            'content':    _loc(self, 'content', lang),
            'era':        _loc(self, 'era', lang),
            'image_url':  self.image_url,
            'video_url':  self.video_url,
            'gallery':    self.gallery or [],
            'audio_url':  self.audio_url,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class Dictionary(db.Model):
    __tablename__ = 'dictionary_table'
    id                  = db.Column(db.Integer, primary_key=True)
    kebena_word         = db.Column(db.String(200), nullable=False, index=True)
    amharic_translation = db.Column(db.String(200), nullable=False)
    english_translation = db.Column(db.String(200), nullable=False)
    oromo_translation   = db.Column(db.String(200))
    audio_url           = db.Column(db.String(500))
    video_url           = db.Column(db.String(500))
    image_url           = db.Column(db.String(500))
    category            = db.Column(db.String(100))
    examples            = db.Column(db.JSON, default=list)
    examples_am         = db.Column(db.JSON, default=list)
    examples_om         = db.Column(db.JSON, default=list)
    synonyms            = db.Column(db.JSON, default=list)
    updated_at          = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self, lang='en'):
        examples = _loc(self, 'examples', lang) or self.examples or []
        return {
            'id': self.id,
            'kebena_word':         self.kebena_word,
            'amharic_translation': self.amharic_translation,
            'english_translation': self.english_translation,
            'oromo_translation':   self.oromo_translation,
            'audio_url':  self.audio_url,
            'video_url':  self.video_url,
            'image_url':  self.image_url,
            'category':   self.category,
            'examples':   examples,
            'synonyms':   self.synonyms or [],
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class News(db.Model):
    __tablename__ = 'news_table'
    id         = db.Column(db.Integer, primary_key=True)
    title      = db.Column(db.String(200), nullable=False)
    title_am   = db.Column(db.String(200))
    title_om   = db.Column(db.String(200))
    content    = db.Column(db.Text, nullable=False)
    content_am = db.Column(db.Text)
    content_om = db.Column(db.Text)
    image_url  = db.Column(db.String(500))
    video_url  = db.Column(db.String(500))
    gallery    = db.Column(db.JSON, default=list)
    category   = db.Column(db.String(50), nullable=False, default='News')
    timestamp  = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self, lang='en'):
        return {
            'id': self.id,
            'title':      _loc(self, 'title', lang),
            'content':    _loc(self, 'content', lang),
            'image_url':  self.image_url,
            'video_url':  self.video_url,
            'gallery':    self.gallery or [],
            'category':   self.category,
            'timestamp':  self.timestamp.isoformat(),
            'updated_at': self.updated_at.isoformat() if self.updated_at else None,
        }


class Admin(db.Model):
    __tablename__ = 'admins'
    id            = db.Column(db.Integer, primary_key=True)
    username      = db.Column(db.String(80), unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)


class Event(db.Model):
    __tablename__ = 'events_table'
    id             = db.Column(db.Integer, primary_key=True)
    title          = db.Column(db.String(200), nullable=False)
    title_am       = db.Column(db.String(200))
    title_om       = db.Column(db.String(200))
    description    = db.Column(db.Text, nullable=False)
    description_am = db.Column(db.Text)
    description_om = db.Column(db.Text)
    location       = db.Column(db.String(200), nullable=False)
    location_am    = db.Column(db.String(200))
    location_om    = db.Column(db.String(200))
    start_date     = db.Column(db.DateTime, nullable=False)
    end_date       = db.Column(db.DateTime, nullable=False)
    image_url      = db.Column(db.String(500))
    video_url      = db.Column(db.String(500))
    gallery        = db.Column(db.JSON, default=list)

    def to_dict(self, lang='en'):
        return {
            'id': self.id,
            'title':       _loc(self, 'title', lang),
            'description': _loc(self, 'description', lang),
            'location':    _loc(self, 'location', lang),
            'start_date':  self.start_date.isoformat(),
            'end_date':    self.end_date.isoformat(),
            'image_url':   self.image_url,
            'video_url':   self.video_url,
            'gallery':     self.gallery or [],
        }


class Hero(db.Model):
    __tablename__ = 'heroes_table'
    id              = db.Column(db.Integer, primary_key=True)
    name            = db.Column(db.String(200), nullable=False)
    name_am         = db.Column(db.String(200))
    name_om         = db.Column(db.String(200))
    title           = db.Column(db.String(200), nullable=False)
    title_am        = db.Column(db.String(200))
    title_om        = db.Column(db.String(200))
    era             = db.Column(db.String(100), nullable=False)
    era_am          = db.Column(db.String(100))
    era_om          = db.Column(db.String(100))
    birth_year      = db.Column(db.String(20))
    death_year      = db.Column(db.String(20))
    short_bio       = db.Column(db.String(500), nullable=False)
    short_bio_am    = db.Column(db.String(500))
    short_bio_om    = db.Column(db.String(500))
    full_story      = db.Column(db.Text, nullable=False)
    full_story_am   = db.Column(db.Text)
    full_story_om   = db.Column(db.Text)
    legacy          = db.Column(db.Text, nullable=False)
    legacy_am       = db.Column(db.Text)
    legacy_om       = db.Column(db.Text)
    bravery_quote   = db.Column(db.String(500))
    bravery_quote_am = db.Column(db.String(500))
    bravery_quote_om = db.Column(db.String(500))
    image_url       = db.Column(db.String(500))
    category        = db.Column(db.String(100), nullable=False)
    updated_at      = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self, lang='en'):
        return {
            'id': self.id,
            'name':          _loc(self, 'name', lang),
            'title':         _loc(self, 'title', lang),
            'era':           _loc(self, 'era', lang),
            'birth_year':    self.birth_year,
            'death_year':    self.death_year,
            'short_bio':     _loc(self, 'short_bio', lang),
            'full_story':    _loc(self, 'full_story', lang),
            'legacy':        _loc(self, 'legacy', lang),
            'bravery_quote': _loc(self, 'bravery_quote', lang),
            'image_url':     self.image_url,
            'category':      self.category,
            'updated_at':    self.updated_at.isoformat() if self.updated_at else None,
        }


class DidYouKnow(db.Model):
    __tablename__ = 'did_you_know_table'
    id           = db.Column(db.Integer, primary_key=True)
    emoji        = db.Column(db.String(10), nullable=False)
    label        = db.Column(db.String(100), nullable=False)
    label_am     = db.Column(db.String(100))
    label_om     = db.Column(db.String(100))
    fact         = db.Column(db.String(600), nullable=False)
    fact_am      = db.Column(db.String(600))
    fact_om      = db.Column(db.String(600))
    detail       = db.Column(db.Text, nullable=False)
    detail_am    = db.Column(db.Text)
    detail_om    = db.Column(db.Text)
    accent_color = db.Column(db.String(20), nullable=False)
    source       = db.Column(db.String(300))
    source_am    = db.Column(db.String(300))
    source_om    = db.Column(db.String(300))
    category     = db.Column(db.String(100), nullable=False)
    updated_at   = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    def to_dict(self, lang='en'):
        return {
            'id': self.id,
            'emoji':        self.emoji,
            'label':        _loc(self, 'label', lang),
            'fact':         _loc(self, 'fact', lang),
            'detail':       _loc(self, 'detail', lang),
            'accent_color': self.accent_color,
            'source':       _loc(self, 'source', lang),
            'category':     self.category,
            'updated_at':   self.updated_at.isoformat() if self.updated_at else None,
        }
