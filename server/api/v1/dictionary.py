from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from extensions import db, limiter
from models.models import Dictionary
from core.schemas import dictionary_schema

dictionary_bp = Blueprint('dictionary_v1', __name__)

@dictionary_bp.get('/')
@limiter.limit('60/minute')
def get_dictionary():
    q = request.args.get('q', '').strip()
    query = Dictionary.query
    if q:
        like = f'%{q}%'
        query = query.filter(
            Dictionary.kebena_word.ilike(like) |
            Dictionary.english_translation.ilike(like) |
            Dictionary.amharic_translation.ilike(like)
        )
    return jsonify([d.to_dict() for d in query.order_by(Dictionary.kebena_word).all()])

@dictionary_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def add_word():
    try:
        data = dictionary_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    word = Dictionary(**data)
    db.session.add(word)
    db.session.commit()
    return jsonify(word.to_dict()), 201

@dictionary_bp.put('/<int:id>')
@jwt_required()
def update_word(id):
    word = Dictionary.query.get_or_404(id)
    try:
        data = dictionary_schema.load(request.get_json() or {}, partial=True)
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    for k, v in data.items():
        setattr(word, k, v)
    db.session.commit()
    return jsonify(word.to_dict())

@dictionary_bp.delete('/<int:id>')
@jwt_required()
def delete_word(id):
    word = Dictionary.query.get_or_404(id)
    db.session.delete(word)
    db.session.commit()
    return '', 204
