from flask import Blueprint, request, jsonify
from extensions import limiter
from models.models import Heritage, Dictionary
from datetime import datetime

sync_bp = Blueprint('sync_v1', __name__)


@sync_bp.get('/')
@limiter.limit('30/minute')
def sync():
    since_str = request.args.get('since')
    lang = request.args.get('lang', 'en')

    try:
        since = datetime.fromisoformat(since_str) if since_str else datetime.min
    except ValueError:
        return jsonify({'error': 'Invalid since timestamp. Use ISO format.'}), 400

    heritage   = Heritage.query.filter(Heritage.updated_at > since).all()
    dictionary = Dictionary.query.filter(Dictionary.updated_at > since).all()

    return jsonify({
        'heritage':   [h.to_dict(lang) for h in heritage],
        'dictionary': [d.to_dict(lang) for d in dictionary],
        'synced_at':  datetime.utcnow().isoformat(),
    })
