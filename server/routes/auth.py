from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token
from werkzeug.security import check_password_hash
from models.models import Admin

auth_bp = Blueprint('auth', __name__)

@auth_bp.post('/login')
def login():
    data = request.get_json()
    admin = Admin.query.filter_by(username=data.get('username')).first()
    if not admin or not check_password_hash(admin.password_hash, data.get('password', '')):
        return jsonify({'error': 'Invalid credentials'}), 401
    token = create_access_token(identity=admin.id)
    return jsonify({'token': token})
