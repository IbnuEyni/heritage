import os
from functools import wraps
from datetime import datetime

from flask import (Blueprint, render_template, request, redirect,
                   url_for, session, flash)
from werkzeug.security import check_password_hash
from werkzeug.utils import secure_filename

from extensions import db
from models.models import Admin, Heritage, News, Hero, Dictionary, Event, DidYouKnow

admin_bp = Blueprint('admin', __name__,
                     template_folder='templates',
                     url_prefix='/admin')

ALLOWED = {'png', 'jpg', 'jpeg', 'webp', 'gif'}


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
        birth_year=f.get('birth_year') or None,
        death_year=f.get('death_year') or None,
        short_bio=f['short_bio'], full_story=f['full_story'],
        legacy=f['legacy'],
        bravery_quote=f.get('bravery_quote') or None,
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
    item.birth_year = f.get('birth_year') or None
    item.death_year = f.get('death_year') or None
    item.short_bio = f['short_bio']
    item.full_story = f['full_story']
    item.legacy = f['legacy']
    item.bravery_quote = f.get('bravery_quote') or None
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
        category=f.get('category') or None,
        audio_url=f.get('audio_url') or None,
        image_url=f.get('image_url') or None,
        examples=[l.strip() for l in f.get('examples', '').splitlines() if l.strip()],
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
    item.category = f.get('category') or None
    item.audio_url = f.get('audio_url') or None
    item.image_url = f.get('image_url') or None
    item.examples = [l.strip() for l in f.get('examples', '').splitlines() if l.strip()]
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
        location=f['location'],
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
    item.location = f['location']
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
        fact=f['fact'], detail=f['detail'],
        accent_color=f['accent_color'],
        source=f.get('source') or None,
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
    item.fact = f['fact']
    item.detail = f['detail']
    item.accent_color = f['accent_color']
    item.source = f.get('source') or None
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
