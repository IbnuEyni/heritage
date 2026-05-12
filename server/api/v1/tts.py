from flask import Blueprint, request, jsonify, send_file
from extensions import limiter
from services.tts_service import synthesize

tts_bp = Blueprint('tts_v1', __name__)


@tts_bp.post('/')
@limiter.limit('60/minute')
def speak():
    body = request.get_json(silent=True) or {}
    text = (body.get('text') or '').strip()
    language = (body.get('language') or '').strip().lower()

    if not text:
        return jsonify({'error': 'text is required'}), 400
    if not language:
        return jsonify({'error': 'language is required (kebena | amharic | english)'}), 400
    if len(text) > 500:
        return jsonify({'error': 'text must be 500 characters or fewer'}), 400

    try:
        path = synthesize(text, language)
    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        return jsonify({'error': 'TTS synthesis failed', 'detail': str(e)}), 502

    return send_file(path, mimetype='audio/mpeg', as_attachment=False)
