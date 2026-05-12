from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, get_jwt_identity
from werkzeug.security import check_password_hash
from extensions import limiter
from models.models import Admin

auth_bp = Blueprint('auth_v1', __name__)

@auth_bp.post('/login')
@limiter.limit('5/minute')
def login():
    data  = request.get_json() or {}
    admin = Admin.query.filter_by(username=data.get('username')).first()
    if not admin or not check_password_hash(admin.password_hash, data.get('password', '')):
        return jsonify({'error': 'Invalid credentials'}), 401
    return jsonify({
        'access_token':  create_access_token(identity=str(admin.id)),
        'refresh_token': create_refresh_token(identity=str(admin.id)),
    })

@auth_bp.post('/refresh')
@jwt_required(refresh=True)
def refresh():
    return jsonify({'access_token': create_access_token(identity=get_jwt_identity())})
