from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from extensions import db
from models.models import Dictionary

dictionary_bp = Blueprint('dictionary', __name__)

@dictionary_bp.get('/')
def get_dictionary():
    q = request.args.get('q', '')
    query = Dictionary.query
    if q:
        like = f'%{q}%'
        query = query.filter(
            Dictionary.kebena_word.ilike(like) |
            Dictionary.english_translation.ilike(like) |
            Dictionary.amharic_translation.ilike(like)
        )
    return jsonify([d.to_dict() for d in query.all()])

@dictionary_bp.post('/')
@jwt_required()
def add_word():
    data = request.get_json()
    word = Dictionary(
        kebena_word=data['kebena_word'],
        amharic_translation=data['amharic_translation'],
        english_translation=data['english_translation'],
        audio_url=data.get('audio_url'),
        category=data.get('category'),
    )
    db.session.add(word)
    db.session.commit()
    return jsonify(word.to_dict()), 201
