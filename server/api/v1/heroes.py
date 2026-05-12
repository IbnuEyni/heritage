from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from extensions import db, limiter
from models.models import Hero
from core.schemas import hero_schema

heroes_bp = Blueprint('heroes_v1', __name__)


def _lang():
    return request.args.get('lang', 'en')


@heroes_bp.get('/')
@limiter.limit('60/minute')
def get_heroes():
    lang = _lang()
    category = request.args.get('category')
    query = Hero.query.order_by(Hero.era)
    if category:
        query = query.filter(Hero.category == category)
    return jsonify([h.to_dict(lang) for h in query.all()])


@heroes_bp.get('/<int:id>')
@limiter.limit('60/minute')
def get_hero(id):
    return jsonify(Hero.query.get_or_404(id).to_dict(_lang()))


@heroes_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def create_hero():
    try:
        data = hero_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    hero = Hero(**data)
    db.session.add(hero)
    db.session.commit()
    return jsonify(hero.to_dict()), 201


@heroes_bp.put('/<int:id>')
@jwt_required()
def update_hero(id):
    hero = Hero.query.get_or_404(id)
    try:
        data = hero_schema.load(request.get_json() or {}, partial=True)
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    for k, v in data.items():
        setattr(hero, k, v)
    db.session.commit()
    return jsonify(hero.to_dict())


@heroes_bp.delete('/<int:id>')
@jwt_required()
def delete_hero(id):
    hero = Hero.query.get_or_404(id)
    db.session.delete(hero)
    db.session.commit()
    return '', 204
