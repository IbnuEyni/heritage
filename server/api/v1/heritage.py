import os
import socket
from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required
from marshmallow import ValidationError
from werkzeug.utils import secure_filename
from extensions import db, limiter
from models.models import Heritage
from core.schemas import heritage_schema

heritage_bp = Blueprint('heritage_v1', __name__)

ALLOWED = {'png', 'jpg', 'jpeg', 'webp', 'gif', 'bmp', 'tiff', 'heic'}


def _allowed(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED


def _lang():
    return request.args.get('lang', 'en')


@heritage_bp.get('/')
@limiter.limit('60/minute')
def get_heritage():
    lang = _lang()
    return jsonify([h.to_dict(lang) for h in Heritage.query.order_by(Heritage.era).all()])


@heritage_bp.post('/')
@jwt_required()
@limiter.limit('30/minute')
def create_heritage():
    try:
        data = heritage_schema.load(request.get_json() or {})
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    article = Heritage(**data)
    db.session.add(article)
    db.session.commit()
    return jsonify(article.to_dict()), 201


@heritage_bp.put('/<int:id>')
@jwt_required()
def update_heritage(id):
    article = Heritage.query.get_or_404(id)
    try:
        data = heritage_schema.load(request.get_json() or {}, partial=True)
    except ValidationError as e:
        return jsonify({'errors': e.messages}), 422
    for k, v in data.items():
        setattr(article, k, v)
    db.session.commit()
    return jsonify(article.to_dict())


@heritage_bp.delete('/<int:id>')
@jwt_required()
def delete_heritage(id):
    article = Heritage.query.get_or_404(id)
    db.session.delete(article)
    db.session.commit()
    return '', 204


@heritage_bp.post('/<int:id>/upload-image')
@jwt_required()
def upload_image(id):
    article = Heritage.query.get_or_404(id)
    if 'image' not in request.files:
        return jsonify({'error': 'No image file provided'}), 400
    file = request.files['image']
    if not file.filename or not _allowed(file.filename):
        return jsonify({'error': 'Invalid file type. Use jpg, png, or webp'}), 400

    upload_dir = os.path.join(current_app.root_path, 'uploads', 'heritage')
    os.makedirs(upload_dir, exist_ok=True)

    filename = f"{id}_{secure_filename(file.filename)}"
    file.save(os.path.join(upload_dir, filename))

    lan_ip = socket.gethostbyname(socket.gethostname())
    host = request.host_url.rstrip('/').replace('localhost', lan_ip).replace('127.0.0.1', lan_ip)
    image_url = f"{host}/uploads/heritage/{filename}"

    article.image_url = image_url
    db.session.commit()
    return jsonify({'image_url': image_url}), 200
