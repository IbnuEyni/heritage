from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from extensions import db
from models.models import Heritage

heritage_bp = Blueprint('heritage', __name__)

@heritage_bp.get('/')
def get_heritage():
    return jsonify([h.to_dict() for h in Heritage.query.order_by(Heritage.era).all()])

@heritage_bp.post('/')
@jwt_required()
def create_heritage():
    data = request.get_json()
    article = Heritage(**{k: data[k] for k in ('title', 'content', 'era') if k in data},
                       image_url=data.get('image_url'))
    db.session.add(article)
    db.session.commit()
    return jsonify(article.to_dict()), 201
