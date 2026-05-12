import os
import json
import urllib.request
import urllib.parse
from functools import wraps
from datetime import datetime

from flask import (Blueprint, render_template, request, redirect,
                   url_for, session, flash, jsonify)
from werkzeug.security import check_password_hash
from werkzeug.utils import secure_filename
from googletrans import Translator

from extensions import db
from models.models import Admin, Heritage, News, Hero, Dictionary, Event, DidYouKnow

admin_bp = Blueprint('admin', __name__,
                     template_folder='templates',
                     url_prefix='/admin')

ALLOWED = {'png', 'jpg', 'jpeg', 'webp', 'gif'}
_translator = Translator()


def _mymemory_translate(text, src='en', dest='om-ET'):
    """MyMemory free API — supports Oromo (om-ET).
    Splits text into <=500 char chunks on sentence boundaries to stay
    within the free tier limit, then joins the results.
    """
    # Split into sentences (split on . ! ? followed by space or newline)
    import re
    sentences = re.split(r'(?<=[.!?])\s+', text.strip())

    chunks, current = [], ''
    for sentence in sentences:
        # If a single sentence exceeds 500 chars, hard-split it
        if len(sentence) > 490:
            for i in range(0, len(sentence), 490):
                chunks.append(sentence[i:i+490])
        elif len(current) + len(sentence) + 1 > 490:
            if current:
                chunks.append(current.strip())
            current = sentence
        else:
            current = (current + ' ' + sentence).strip() if current else sentence
    if current:
        chunks.append(current.strip())

    translated_parts = []
    for chunk in chunks:
        url = (
            'https://api.mymemory.translated.net/get'
            f'?q={urllib.parse.quote(chunk)}&langpair={src}|{dest}'
        )
        with urllib.request.urlopen(url, timeout=12) as r:
            data = json.loads(r.read())
        if data.get('responseStatus') != 200:
            raise RuntimeError(data.get('responseDetails', 'MyMemory error'))
        translated_parts.append(data['responseData']['translatedText'])

    return ' '.join(translated_parts)


def _allowed(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED


def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if not session.get('admin_id'):
            return redirect(url_for('admin.login'))
        return f(*args, **kwargs)
    return decorated


def _save_upload(file, subfolder='heritage'):
    from flask import current_app
    import socket
    if not file or not file.filename or not _allowed(file.filename):
        return None
    upload_dir = os.path.join(current_app.root_path, 'uploads', subfolder)
    os.makedirs(upload_dir, exist_ok=True)
    filename = secure_filename(file.filename)
    file.save(os.path.join(upload_dir, filename))
    lan_ip = socket.gethostbyname(socket.gethostname())
    host = request.host_url.rstrip('/').replace('localhost', lan_ip).replace('127.0.0.1', lan_ip)
    return f"{host}/uploads/{subfolder}/{filename}"


# ── Auto-translate API (used by admin forms via JS) ──────────────────────────

@admin_bp.post('/translate')
@login_required
def translate():
    body = request.get_json(silent=True) or {}
    text = (body.get('text') or '').strip()
    dest = (body.get('dest') or 'am').strip()
    if not text:
        return jsonify({'error': 'text is required'}), 400
    if dest not in ('am', 'om', 'en'):
        return jsonify({'error': 'dest must be am, om, or en'}), 400
    try:
        if dest == 'om':
            translated = _mymemory_translate(text, src='en', dest='om-ET')
        else:
            # googletrans handles long text but chunk at 4500 chars to be safe
            if len(text) > 4500:
                import re
                sentences = re.split(r'(?<=[.!?])\s+', text.strip())
                chunks, current = [], ''
                for s in sentences:
                    if len(current) + len(s) + 1 > 4500:
                        if current: chunks.append(current.strip())
                        current = s
                    else:
                        current = (current + ' ' + s).strip() if current else s
                if current: chunks.append(current.strip())
                translated = ' '.join(
                    _translator.translate(c, dest=dest).text for c in chunks
                )
            else:
                translated = _translator.translate(text, dest=dest).text
        return jsonify({'translated': translated})
    except Exception as e:
        return jsonify({'error': str(e)}), 502


# ── Auth ──────────────────────────────────────────────────────────────────────

@admin_bp.get('/login')
def login():
    if session.get('admin_id'):
        return redirect(url_for('admin.dashboard'))
    return render_template('admin/login.html')


@admin_bp.post('/login')
def login_post():
    admin = Admin.query.filter_by(username=request.form['username']).first()
    if not admin or not check_password_hash(admin.password_hash, request.form['password']):
        flash('Invalid credentials', 'error')
        return redirect(url_for('admin.login'))
    session['admin_id'] = admin.id
    session['admin_username'] = admin.username
    return redirect(url_for('admin.dashboard'))


@admin_bp.get('/logout')
def logout():
    session.clear()
    return redirect(url_for('admin.login'))


# ── Dashboard ─────────────────────────────────────────────────────────────────

@admin_bp.get('/')
@login_required
def dashboard():
    counts = {
        'heritage':   Heritage.query.count(),
        'news':       News.query.count(),
        'heroes':     Hero.query.count(),
        'dictionary': Dictionary.query.count(),
        'events':     Event.query.count(),
        'did_you_know': DidYouKnow.query.count(),
    }
    return render_template('admin/dashboard.html', counts=counts)


# ── Heritage ──────────────────────────────────────────────────────────────────

@admin_bp.get('/heritage')
@login_required
def heritage_list():
    items = Heritage.query.order_by(Heritage.era).all()
    return render_template('admin/heritage.html', items=items)


@admin_bp.get('/heritage/new')
@login_required
def heritage_new():
    return render_template('admin/heritage_form.html', item=None)


@admin_bp.post('/heritage/new')
@login_required
def heritage_create():
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'heritage') or f.get('image_url') or None
    item = Heritage(
        title=f['title'], content=f['content'], era=f['era'],
        title_am=f.get('title_am') or None,
        title_om=f.get('title_om') or None,
        content_am=f.get('content_am') or None,
        content_om=f.get('content_om') or None,
        era_am=f.get('era_am') or None,
        era_om=f.get('era_om') or None,
        image_url=image_url,
        video_url=f.get('video_url') or None,
        audio_url=f.get('audio_url') or None,
    )
    db.session.add(item)
    db.session.commit()
    flash('Heritage article created.', 'success')
    return redirect(url_for('admin.heritage_list'))


@admin_bp.get('/heritage/<int:id>/edit')
@login_required
def heritage_edit(id):
    item = Heritage.query.get_or_404(id)
    return render_template('admin/heritage_form.html', item=item)


@admin_bp.post('/heritage/<int:id>/edit')
@login_required
def heritage_update(id):
    item = Heritage.query.get_or_404(id)
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'heritage') or f.get('image_url') or item.image_url
    item.title = f['title']
    item.content = f['content']
    item.era = f['era']
    item.title_am = f.get('title_am') or None
    item.title_om = f.get('title_om') or None
    item.content_am = f.get('content_am') or None
    item.content_om = f.get('content_om') or None
    item.era_am = f.get('era_am') or None
    item.era_om = f.get('era_om') or None
    item.image_url = image_url
    item.video_url = f.get('video_url') or None
    item.audio_url = f.get('audio_url') or None
    db.session.commit()
    flash('Heritage article updated.', 'success')
    return redirect(url_for('admin.heritage_list'))


@admin_bp.post('/heritage/<int:id>/delete')
@login_required
def heritage_delete(id):
    db.session.delete(Heritage.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.heritage_list'))


# ── News ──────────────────────────────────────────────────────────────────────

@admin_bp.get('/news')
@login_required
def news_list():
    items = News.query.order_by(News.timestamp.desc()).all()
    return render_template('admin/news.html', items=items)


@admin_bp.get('/news/new')
@login_required
def news_new():
    return render_template('admin/news_form.html', item=None)


@admin_bp.post('/news/new')
@login_required
def news_create():
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'news') or f.get('image_url') or None
    item = News(
        title=f['title'], content=f['content'],
        title_am=f.get('title_am') or None,
        title_om=f.get('title_om') or None,
        content_am=f.get('content_am') or None,
        content_om=f.get('content_om') or None,
        category=f.get('category', 'News'),
        image_url=image_url,
        video_url=f.get('video_url') or None,
    )
    db.session.add(item)
    db.session.commit()
    flash('News article created.', 'success')
    return redirect(url_for('admin.news_list'))


@admin_bp.get('/news/<int:id>/edit')
@login_required
def news_edit(id):
    item = News.query.get_or_404(id)
    return render_template('admin/news_form.html', item=item)


@admin_bp.post('/news/<int:id>/edit')
@login_required
def news_update(id):
    item = News.query.get_or_404(id)
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'news') or f.get('image_url') or item.image_url
    item.title = f['title']
    item.content = f['content']
    item.title_am = f.get('title_am') or None
    item.title_om = f.get('title_om') or None
    item.content_am = f.get('content_am') or None
    item.content_om = f.get('content_om') or None
    item.category = f.get('category', 'News')
    item.image_url = image_url
    item.video_url = f.get('video_url') or None
    db.session.commit()
    flash('News article updated.', 'success')
    return redirect(url_for('admin.news_list'))


@admin_bp.post('/news/<int:id>/delete')
@login_required
def news_delete(id):
    db.session.delete(News.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.news_list'))


# ── Heroes ────────────────────────────────────────────────────────────────────

@admin_bp.get('/heroes')
@login_required
def heroes_list():
    items = Hero.query.order_by(Hero.era).all()
    return render_template('admin/heroes.html', items=items)


@admin_bp.get('/heroes/new')
@login_required
def heroes_new():
    return render_template('admin/heroes_form.html', item=None)


@admin_bp.post('/heroes/new')
@login_required
def heroes_create():
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'heroes') or f.get('image_url') or None
    item = Hero(
        name=f['name'], title=f['title'], era=f['era'],
        name_am=f.get('name_am') or None,
        name_om=f.get('name_om') or None,
        title_am=f.get('title_am') or None,
        title_om=f.get('title_om') or None,
        era_am=f.get('era_am') or None,
        era_om=f.get('era_om') or None,
        birth_year=f.get('birth_year') or None,
        death_year=f.get('death_year') or None,
        short_bio=f['short_bio'],
        short_bio_am=f.get('short_bio_am') or None,
        short_bio_om=f.get('short_bio_om') or None,
        full_story=f['full_story'],
        full_story_am=f.get('full_story_am') or None,
        full_story_om=f.get('full_story_om') or None,
        legacy=f['legacy'],
        legacy_am=f.get('legacy_am') or None,
        legacy_om=f.get('legacy_om') or None,
        bravery_quote=f.get('bravery_quote') or None,
        bravery_quote_am=f.get('bravery_quote_am') or None,
        bravery_quote_om=f.get('bravery_quote_om') or None,
        image_url=image_url,
        category=f['category'],
    )
    db.session.add(item)
    db.session.commit()
    flash('Hero created.', 'success')
    return redirect(url_for('admin.heroes_list'))


@admin_bp.get('/heroes/<int:id>/edit')
@login_required
def heroes_edit(id):
    item = Hero.query.get_or_404(id)
    return render_template('admin/heroes_form.html', item=item)


@admin_bp.post('/heroes/<int:id>/edit')
@login_required
def heroes_update(id):
    item = Hero.query.get_or_404(id)
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'heroes') or f.get('image_url') or item.image_url
    item.name = f['name']
    item.title = f['title']
    item.era = f['era']
    item.name_am = f.get('name_am') or None
    item.name_om = f.get('name_om') or None
    item.title_am = f.get('title_am') or None
    item.title_om = f.get('title_om') or None
    item.era_am = f.get('era_am') or None
    item.era_om = f.get('era_om') or None
    item.birth_year = f.get('birth_year') or None
    item.death_year = f.get('death_year') or None
    item.short_bio = f['short_bio']
    item.short_bio_am = f.get('short_bio_am') or None
    item.short_bio_om = f.get('short_bio_om') or None
    item.full_story = f['full_story']
    item.full_story_am = f.get('full_story_am') or None
    item.full_story_om = f.get('full_story_om') or None
    item.legacy = f['legacy']
    item.legacy_am = f.get('legacy_am') or None
    item.legacy_om = f.get('legacy_om') or None
    item.bravery_quote = f.get('bravery_quote') or None
    item.bravery_quote_am = f.get('bravery_quote_am') or None
    item.bravery_quote_om = f.get('bravery_quote_om') or None
    item.image_url = image_url
    item.category = f['category']
    db.session.commit()
    flash('Hero updated.', 'success')
    return redirect(url_for('admin.heroes_list'))


@admin_bp.post('/heroes/<int:id>/delete')
@login_required
def heroes_delete(id):
    db.session.delete(Hero.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.heroes_list'))


# ── Dictionary ────────────────────────────────────────────────────────────────

@admin_bp.get('/dictionary')
@login_required
def dictionary_list():
    items = Dictionary.query.order_by(Dictionary.kebena_word).all()
    return render_template('admin/dictionary.html', items=items)


@admin_bp.get('/dictionary/new')
@login_required
def dictionary_new():
    return render_template('admin/dictionary_form.html', item=None)


@admin_bp.post('/dictionary/new')
@login_required
def dictionary_create():
    f = request.form
    item = Dictionary(
        kebena_word=f['kebena_word'],
        amharic_translation=f['amharic_translation'],
        english_translation=f['english_translation'],
        oromo_translation=f.get('oromo_translation') or None,
        category=f.get('category') or None,
        audio_url=f.get('audio_url') or None,
        image_url=f.get('image_url') or None,
        examples=[l.strip() for l in f.get('examples', '').splitlines() if l.strip()],
        examples_am=[l.strip() for l in f.get('examples_am', '').splitlines() if l.strip()],
        examples_om=[l.strip() for l in f.get('examples_om', '').splitlines() if l.strip()],
        synonyms=[l.strip() for l in f.get('synonyms', '').splitlines() if l.strip()],
    )
    db.session.add(item)
    db.session.commit()
    flash('Word added.', 'success')
    return redirect(url_for('admin.dictionary_list'))


@admin_bp.get('/dictionary/<int:id>/edit')
@login_required
def dictionary_edit(id):
    item = Dictionary.query.get_or_404(id)
    return render_template('admin/dictionary_form.html', item=item)


@admin_bp.post('/dictionary/<int:id>/edit')
@login_required
def dictionary_update(id):
    item = Dictionary.query.get_or_404(id)
    f = request.form
    item.kebena_word = f['kebena_word']
    item.amharic_translation = f['amharic_translation']
    item.english_translation = f['english_translation']
    item.oromo_translation = f.get('oromo_translation') or None
    item.category = f.get('category') or None
    item.audio_url = f.get('audio_url') or None
    item.image_url = f.get('image_url') or None
    item.examples = [l.strip() for l in f.get('examples', '').splitlines() if l.strip()]
    item.examples_am = [l.strip() for l in f.get('examples_am', '').splitlines() if l.strip()]
    item.examples_om = [l.strip() for l in f.get('examples_om', '').splitlines() if l.strip()]
    item.synonyms = [l.strip() for l in f.get('synonyms', '').splitlines() if l.strip()]
    db.session.commit()
    flash('Word updated.', 'success')
    return redirect(url_for('admin.dictionary_list'))


@admin_bp.post('/dictionary/<int:id>/delete')
@login_required
def dictionary_delete(id):
    db.session.delete(Dictionary.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.dictionary_list'))


# ── Events ────────────────────────────────────────────────────────────────────

@admin_bp.get('/events')
@login_required
def events_list():
    items = Event.query.order_by(Event.start_date).all()
    return render_template('admin/events.html', items=items)


@admin_bp.get('/events/new')
@login_required
def events_new():
    return render_template('admin/events_form.html', item=None)


@admin_bp.post('/events/new')
@login_required
def events_create():
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'events') or f.get('image_url') or None
    item = Event(
        title=f['title'], description=f['description'],
        title_am=f.get('title_am') or None,
        title_om=f.get('title_om') or None,
        description_am=f.get('description_am') or None,
        description_om=f.get('description_om') or None,
        location=f['location'],
        location_am=f.get('location_am') or None,
        location_om=f.get('location_om') or None,
        start_date=datetime.fromisoformat(f['start_date']),
        end_date=datetime.fromisoformat(f['end_date']),
        image_url=image_url,
        video_url=f.get('video_url') or None,
    )
    db.session.add(item)
    db.session.commit()
    flash('Event created.', 'success')
    return redirect(url_for('admin.events_list'))


@admin_bp.get('/events/<int:id>/edit')
@login_required
def events_edit(id):
    item = Event.query.get_or_404(id)
    return render_template('admin/events_form.html', item=item)


@admin_bp.post('/events/<int:id>/edit')
@login_required
def events_update(id):
    item = Event.query.get_or_404(id)
    f = request.form
    image_url = _save_upload(request.files.get('image'), 'events') or f.get('image_url') or item.image_url
    item.title = f['title']
    item.description = f['description']
    item.title_am = f.get('title_am') or None
    item.title_om = f.get('title_om') or None
    item.description_am = f.get('description_am') or None
    item.description_om = f.get('description_om') or None
    item.location = f['location']
    item.location_am = f.get('location_am') or None
    item.location_om = f.get('location_om') or None
    item.start_date = datetime.fromisoformat(f['start_date'])
    item.end_date = datetime.fromisoformat(f['end_date'])
    item.image_url = image_url
    item.video_url = f.get('video_url') or None
    db.session.commit()
    flash('Event updated.', 'success')
    return redirect(url_for('admin.events_list'))


@admin_bp.post('/events/<int:id>/delete')
@login_required
def events_delete(id):
    db.session.delete(Event.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.events_list'))


# ── Did You Know ──────────────────────────────────────────────────────────────

@admin_bp.get('/did-you-know')
@login_required
def dyk_list():
    items = DidYouKnow.query.order_by(DidYouKnow.id).all()
    return render_template('admin/dyk.html', items=items)


@admin_bp.get('/did-you-know/new')
@login_required
def dyk_new():
    return render_template('admin/dyk_form.html', item=None)


@admin_bp.post('/did-you-know/new')
@login_required
def dyk_create():
    f = request.form
    item = DidYouKnow(
        emoji=f['emoji'], label=f['label'],
        label_am=f.get('label_am') or None,
        label_om=f.get('label_om') or None,
        fact=f['fact'],
        fact_am=f.get('fact_am') or None,
        fact_om=f.get('fact_om') or None,
        detail=f['detail'],
        detail_am=f.get('detail_am') or None,
        detail_om=f.get('detail_om') or None,
        accent_color=f['accent_color'],
        source=f.get('source') or None,
        source_am=f.get('source_am') or None,
        source_om=f.get('source_om') or None,
        category=f['category'],
    )
    db.session.add(item)
    db.session.commit()
    flash('Did You Know entry created.', 'success')
    return redirect(url_for('admin.dyk_list'))


@admin_bp.get('/did-you-know/<int:id>/edit')
@login_required
def dyk_edit(id):
    item = DidYouKnow.query.get_or_404(id)
    return render_template('admin/dyk_form.html', item=item)


@admin_bp.post('/did-you-know/<int:id>/edit')
@login_required
def dyk_update(id):
    item = DidYouKnow.query.get_or_404(id)
    f = request.form
    item.emoji = f['emoji']
    item.label = f['label']
    item.label_am = f.get('label_am') or None
    item.label_om = f.get('label_om') or None
    item.fact = f['fact']
    item.fact_am = f.get('fact_am') or None
    item.fact_om = f.get('fact_om') or None
    item.detail = f['detail']
    item.detail_am = f.get('detail_am') or None
    item.detail_om = f.get('detail_om') or None
    item.accent_color = f['accent_color']
    item.source = f.get('source') or None
    item.source_am = f.get('source_am') or None
    item.source_om = f.get('source_om') or None
    item.category = f['category']
    db.session.commit()
    flash('Did You Know entry updated.', 'success')
    return redirect(url_for('admin.dyk_list'))


@admin_bp.post('/did-you-know/<int:id>/delete')
@login_required
def dyk_delete(id):
    db.session.delete(DidYouKnow.query.get_or_404(id))
    db.session.commit()
    flash('Deleted.', 'success')
    return redirect(url_for('admin.dyk_list'))
