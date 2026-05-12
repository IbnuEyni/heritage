from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from extensions import db, limiter
from models.models import Event
from core.schemas import event_schema

events_bp = Blueprint('events_v1', __name__)

@events_bp.get('/')
@limiter.limit('60/minute')
def get_events():
    return jsonify([e.to_dict() for e in Event.query.order_by(Event.start_date).all()])

@events_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def create_event():
    try:
        data = event_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    event = Event(**data)
    db.session.add(event)
    db.session.commit()
    return jsonify(event.to_dict()), 201

@events_bp.delete('/<int:id>')
@jwt_required()
def delete_event(id):
    event = Event.query.get_or_404(id)
    db.session.delete(event)
    db.session.commit()
    return '', 204
