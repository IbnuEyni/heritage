from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from extensions import db
from models.models import News
from services.fcm_service import send_news_notification

news_bp = Blueprint('news', __name__)

@news_bp.get('/')
def get_news():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 10, type=int)
    paginated = News.query.order_by(News.timestamp.desc()).paginate(
        page=page, per_page=per_page, error_out=False
    )
    return jsonify({
        'items': [n.to_dict() for n in paginated.items],
        'total': paginated.total,
        'pages': paginated.pages,
        'page': page,
    })

@news_bp.post('/')
@jwt_required()
def create_news():
    data = request.get_json()
    article = News(
        title=data['title'],
        content=data['content'],
        image_url=data.get('image_url'),
        category=data.get('category', 'News'),
    )
    db.session.add(article)
    db.session.commit()
    send_news_notification(article)
    return jsonify(article.to_dict()), 201
