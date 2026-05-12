from marshmallow import Schema, fields, validate


class HeritageSchema(Schema):
    title      = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    title_am   = fields.Str(load_default=None, allow_none=True)
    title_om   = fields.Str(load_default=None, allow_none=True)
    content    = fields.Str(required=True, validate=validate.Length(min=10))
    content_am = fields.Str(load_default=None, allow_none=True)
    content_om = fields.Str(load_default=None, allow_none=True)
    era        = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    era_am     = fields.Str(load_default=None, allow_none=True)
    era_om     = fields.Str(load_default=None, allow_none=True)
    image_url  = fields.Url(load_default=None, allow_none=True)
    video_url  = fields.Url(load_default=None, allow_none=True)
    gallery    = fields.List(fields.Url(), load_default=list)
    audio_url  = fields.Url(load_default=None, allow_none=True)


class DictionarySchema(Schema):
    kebena_word         = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    amharic_translation = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    english_translation = fields.Str(required=True, validate=validate.Length(min=1, max=200))
    oromo_translation   = fields.Str(load_default=None, allow_none=True)
    audio_url   = fields.Url(load_default=None, allow_none=True)
    video_url   = fields.Url(load_default=None, allow_none=True)
    image_url   = fields.Url(load_default=None, allow_none=True)
    category    = fields.Str(load_default=None, validate=validate.Length(max=100))
    examples    = fields.List(fields.Str(), load_default=list)
    examples_am = fields.List(fields.Str(), load_default=list)
    examples_om = fields.List(fields.Str(), load_default=list)
    synonyms    = fields.List(fields.Str(), load_default=list)


class NewsSchema(Schema):
    title      = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    title_am   = fields.Str(load_default=None, allow_none=True)
    title_om   = fields.Str(load_default=None, allow_none=True)
    content    = fields.Str(required=True, validate=validate.Length(min=10))
    content_am = fields.Str(load_default=None, allow_none=True)
    content_om = fields.Str(load_default=None, allow_none=True)
    image_url  = fields.Url(load_default=None, allow_none=True)
    video_url  = fields.Url(load_default=None, allow_none=True)
    gallery    = fields.List(fields.Url(), load_default=list)
    category   = fields.Str(load_default='News',
                             validate=validate.OneOf(['Woreda', 'Culture', 'News']))


class EventSchema(Schema):
    title          = fields.Str(required=True, validate=validate.Length(min=3, max=200))
    title_am       = fields.Str(load_default=None, allow_none=True)
    title_om       = fields.Str(load_default=None, allow_none=True)
    description    = fields.Str(required=True, validate=validate.Length(min=10))
    description_am = fields.Str(load_default=None, allow_none=True)
    description_om = fields.Str(load_default=None, allow_none=True)
    location       = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    location_am    = fields.Str(load_default=None, allow_none=True)
    location_om    = fields.Str(load_default=None, allow_none=True)
    start_date     = fields.DateTime(required=True)
    end_date       = fields.DateTime(required=True)
    image_url      = fields.Url(load_default=None, allow_none=True)
    video_url      = fields.Url(load_default=None, allow_none=True)
    gallery        = fields.List(fields.Url(), load_default=list)


class HeroSchema(Schema):
    name             = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    name_am          = fields.Str(load_default=None, allow_none=True)
    name_om          = fields.Str(load_default=None, allow_none=True)
    title            = fields.Str(required=True, validate=validate.Length(min=2, max=200))
    title_am         = fields.Str(load_default=None, allow_none=True)
    title_om         = fields.Str(load_default=None, allow_none=True)
    era              = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    era_am           = fields.Str(load_default=None, allow_none=True)
    era_om           = fields.Str(load_default=None, allow_none=True)
    birth_year       = fields.Str(load_default=None, allow_none=True)
    death_year       = fields.Str(load_default=None, allow_none=True)
    short_bio        = fields.Str(required=True, validate=validate.Length(min=10, max=500))
    short_bio_am     = fields.Str(load_default=None, allow_none=True)
    short_bio_om     = fields.Str(load_default=None, allow_none=True)
    full_story       = fields.Str(required=True, validate=validate.Length(min=50))
    full_story_am    = fields.Str(load_default=None, allow_none=True)
    full_story_om    = fields.Str(load_default=None, allow_none=True)
    legacy           = fields.Str(required=True, validate=validate.Length(min=20))
    legacy_am        = fields.Str(load_default=None, allow_none=True)
    legacy_om        = fields.Str(load_default=None, allow_none=True)
    bravery_quote    = fields.Str(load_default=None, allow_none=True)
    bravery_quote_am = fields.Str(load_default=None, allow_none=True)
    bravery_quote_om = fields.Str(load_default=None, allow_none=True)
    image_url        = fields.Url(load_default=None, allow_none=True)
    category         = fields.Str(required=True,
                                   validate=validate.OneOf(['Warrior', 'Scholar', 'Leader', 'Spiritual']))


class DidYouKnowSchema(Schema):
    emoji        = fields.Str(required=True, validate=validate.Length(min=1, max=10))
    label        = fields.Str(required=True, validate=validate.Length(min=2, max=100))
    label_am     = fields.Str(load_default=None, allow_none=True)
    label_om     = fields.Str(load_default=None, allow_none=True)
    fact         = fields.Str(required=True, validate=validate.Length(min=10, max=600))
    fact_am      = fields.Str(load_default=None, allow_none=True)
    fact_om      = fields.Str(load_default=None, allow_none=True)
    detail       = fields.Str(required=True, validate=validate.Length(min=50))
    detail_am    = fields.Str(load_default=None, allow_none=True)
    detail_om    = fields.Str(load_default=None, allow_none=True)
    accent_color = fields.Str(required=True, validate=validate.Regexp(r'^#[0-9A-Fa-f]{6}$'))
    source       = fields.Str(load_default=None, allow_none=True)
    source_am    = fields.Str(load_default=None, allow_none=True)
    source_om    = fields.Str(load_default=None, allow_none=True)
    category     = fields.Str(required=True, validate=validate.Length(min=2, max=100))


heritage_schema   = HeritageSchema()
dictionary_schema = DictionarySchema()
news_schema       = NewsSchema()
event_schema      = EventSchema()
hero_schema       = HeroSchema()
dyk_schema        = DidYouKnowSchema()
