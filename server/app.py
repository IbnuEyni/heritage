import os
from flask import Flask, jsonify, send_from_directory
from datetime import timedelta
from dotenv import load_dotenv
from extensions import db, jwt, migrate, limiter
from core.logging_config import configure_logging
import os

load_dotenv()

def create_app():
    app = Flask(__name__)
    app.config.update(
        SQLALCHEMY_DATABASE_URI=os.getenv('DATABASE_URL', 'postgresql://user:pass@localhost/kebena'),
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
        JWT_SECRET_KEY=os.getenv('JWT_SECRET_KEY', 'change-me-in-production'),
        JWT_ACCESS_TOKEN_EXPIRES=timedelta(minutes=15),
        JWT_REFRESH_TOKEN_EXPIRES=timedelta(days=30),
        RATELIMIT_STORAGE_URI=os.getenv('REDIS_URL', 'memory://'),
        SECRET_KEY=os.getenv('SECRET_KEY', 'admin-secret-change-me'),
    )

    db.init_app(app)
    jwt.init_app(app)
    migrate.init_app(app, db)
    limiter.init_app(app)
    configure_logging(app)

    # Register v1 blueprints
    from api.v1.heritage   import heritage_bp
    from api.v1.dictionary import dictionary_bp
    from api.v1.news       import news_bp
    from api.v1.auth       import auth_bp
    from api.v1.events     import events_bp
    from api.v1.sync       import sync_bp
    from api.v1.heroes     import heroes_bp
    from api.v1.did_you_know import dyk_bp
    from api.v1.tts import tts_bp
    from api.v1.telegram import telegram_bp
    from admin import admin_bp

    app.register_blueprint(heritage_bp,   url_prefix='/api/v1/heritage')
    app.register_blueprint(dictionary_bp, url_prefix='/api/v1/dictionary')
    app.register_blueprint(news_bp,       url_prefix='/api/v1/news')
    app.register_blueprint(auth_bp,       url_prefix='/api/v1/auth')
    app.register_blueprint(events_bp,     url_prefix='/api/v1/events')
    app.register_blueprint(sync_bp,       url_prefix='/api/v1/sync')
    app.register_blueprint(heroes_bp,     url_prefix='/api/v1/heroes')
    app.register_blueprint(dyk_bp,        url_prefix='/api/v1/did-you-know')
    app.register_blueprint(tts_bp,        url_prefix='/api/v1/tts')
    app.register_blueprint(telegram_bp,   url_prefix='/api/v1/telegram')
    app.register_blueprint(admin_bp)

    # Health check
    @app.get('/health')
    def health():
        try:
            db.session.execute(db.text('SELECT 1'))
            db_status = 'ok'
        except Exception:
            db_status = 'error'
        return jsonify({
            'status':  'ok' if db_status == 'ok' else 'degraded',
            'db':      db_status,
            'version': '1.0.0',
        })

    # Serve uploaded images
    @app.get('/uploads/<path:filename>')
    def serve_upload(filename):
        upload_dir = os.path.join(app.root_path, 'uploads')
        return send_from_directory(upload_dir, filename)

    with app.app_context():
        db.create_all()

    return app

if __name__ == '__main__':
    create_app().run(host='0.0.0.0', port=8001, debug=True)
