from marshmallow import Schema, fields, validate

class HeritageSchema(Schema):
    title     = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    content   = fields.Str(required=True, validate=validate.Length(min=10))
    era       = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    image_url = fields.Url(load_default=None, allow_none=True)
    video_url = fields.Url(load_default=None, allow_none=True)
    gallery   = fields.List(fields.Url(), load_default=list)
    audio_url = fields.Url(load_default=None, allow_none=True)

class DictionarySchema(Schema):
    kebena_word         = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    amharic_translation = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    english_translation = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    audio_url = fields.Url(load_default=None, allow_none=True)
    video_url = fields.Url(load_default=None, allow_none=True)
    image_url = fields.Url(load_default=None, allow_none=True)
    category  = fields.Str(load_default=None, validate=validate.Length(max=100))
    examples  = fields.List(fields.Str(), load_default=list)
    synonyms  = fields.List(fields.Str(), load_default=list)

class NewsSchema(Schema):
    title     = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    content   = fields.Str(required=True, validate=validate.Length(min=10))
    image_url = fields.Url(load_default=None, allow_none=True)
    video_url = fields.Url(load_default=None, allow_none=True)
    gallery   = fields.List(fields.Url(), load_default=list)
    category  = fields.Str(load_default='News',
                            validate=validate.OneOf(['Woreda', 'Culture', 'News']))

class EventSchema(Schema):
    title       = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    description = fields.Str(required=True, validate=validate.Length(min=10))
    location    = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    start_date  = fields.DateTime(required=True)
    end_date    = fields.DateTime(required=True)
    image_url   = fields.Url(load_default=None, allow_none=True)
    video_url   = fields.Url(load_default=None, allow_none=True)
    gallery     = fields.List(fields.Url(), load_default=list)

class HeroSchema(Schema):
    name          = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    title         = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    era           = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    birth_year    = fields.Str(load_default=None, allow_none=True)
    death_year    = fields.Str(load_default=None, allow_none=True)
    short_bio     = fields.Str(required=True, validate=validate.Length(min=10, max=500))
    full_story    = fields.Str(required=True, validate=validate.Length(min=50))
    legacy        = fields.Str(required=True, validate=validate.Length(min=20))
    bravery_quote = fields.Str(load_default=None, allow_none=True)
    image_url     = fields.Url(load_default=None, allow_none=True)
    category      = fields.Str(required=True,
                                validate=validate.OneOf(['Warrior', 'Scholar', 'Leader', 'Spiritual']))

class DidYouKnowSchema(Schema):
    emoji        = fields.Str(required=True, validate=validate.Length(min=1, max=10))
    label        = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    fact         = fields.Str(required=True, validate=validate.Length(min=10, max=600))
    detail       = fields.Str(required=True, validate=validate.Length(min=50))
    accent_color = fields.Str(required=True, validate=validate.Regexp(r'^#[0-9A-Fa-f]{6}$'))
    source       = fields.Str(load_default=None, allow_none=True)
    category     = fields.Str(required=True, validate=validate.Length(min=2, max=100))

heritage_schema   = HeritageSchema()
dictionary_schema = DictionarySchema()
news_schema       = NewsSchema()
event_schema      = EventSchema()
hero_schema       = HeroSchema()
dyk_schema        = DidYouKnowSchema()
