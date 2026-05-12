from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from extensions import db, limiter
from models.models import News
from core.schemas import news_schema
from services.fcm_service import send_news_notification

news_bp = Blueprint('news_v1', __name__)

@news_bp.get('/')
@limiter.limit('60/minute')
def get_news():
    page     = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 10, type=int)
    category = request.args.get('category')

    query = News.query.order_by(News.timestamp.desc())
    if category:
        query = query.filter(News.category == category)

    paginated = query.paginate(page=page, per_page=per_page, error_out=False)
    return jsonify({
        'items':  [n.to_dict() for n in paginated.items],
        'total':  paginated.total,
        'pages':  paginated.pages,
        'page':   page,
    })

@news_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def create_news():
    try:
        data = news_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    article = News(**data)
    db.session.add(article)
    db.session.commit()
    send_news_notification(article)
    return jsonify(article.to_dict()), 201

@news_bp.put('/<int:id>')
@jwt_required()
def update_news(id):
    article = News.query.get_or_404(id)
    try:
        data = news_schema.load(request.get_json() or {}, partial=True)
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    for k, v in data.items():
        setattr(article, k, v)
    db.session.commit()
    return jsonify(article.to_dict())

@news_bp.delete('/<int:id>')
@jwt_required()
def delete_news(id):
    article = News.query.get_or_404(id)
    db.session.delete(article)
    db.session.commit()
    return '', 204
