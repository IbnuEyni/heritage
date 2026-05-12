from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from extensions import db, limiter
from models.models import DidYouKnow
from core.schemas import dyk_schema

dyk_bp = Blueprint('dyk_v1', __name__)


def _lang():
    return request.args.get('lang', 'en')


@dyk_bp.get('/')
@limiter.limit('60/minute')
def get_dyk():
    lang = _lang()
    return jsonify([d.to_dict(lang) for d in DidYouKnow.query.order_by(DidYouKnow.id).all()])


@dyk_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def create_dyk():
    try:
        data = dyk_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    entry = DidYouKnow(**data)
    db.session.add(entry)
    db.session.commit()
    return jsonify(entry.to_dict()), 201


@dyk_bp.put('/<int:id>')
@jwt_required()
def update_dyk(id):
    entry = DidYouKnow.query.get_or_404(id)
    try:
        data = dyk_schema.load(request.get_json() or {}, partial=True)
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    for k, v in data.items():
        setattr(entry, k, v)
    db.session.commit()
    return jsonify(entry.to_dict())


@dyk_bp.delete('/<int:id>')
@jwt_required()
def delete_dyk(id):
    entry = DidYouKnow.query.get_or_404(id)
    db.session.delete(entry)
    db.session.commit()
    return '', 204
