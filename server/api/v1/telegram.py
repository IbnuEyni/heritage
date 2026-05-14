import os
import logging
from flask import Blueprint, request, jsonify
from services.telegram_service import process_channel_post, setup_webhook, remove_webhook
from flask_jwt_extended import jwt_required

logger = logging.getLogger(__name__)

telegram_bp = Blueprint('telegram_v1', __name__)

WEBHOOK_SECRET = os.getenv('TELEGRAM_WEBHOOK_SECRET', '')


@telegram_bp.post('/webhook')
def telegram_webhook():
    """Receive updates from Telegram Bot API."""
    # Optional: verify secret token header
    if WEBHOOK_SECRET:
        token = request.headers.get('X-Telegram-Bot-Api-Secret-Token', '')
        if token != WEBHOOK_SECRET:
            logger.warning('Webhook secret mismatch, rejecting request')
            return '', 403

    update = request.get_json(silent=True) or {}
    logger.info(f'Telegram update received: {update}')

    result = process_channel_post(update)
    if result:
        logger.info(f'News created: {result.title}')
    else:
        logger.warning('No news created from update')

    return '', 200


@telegram_bp.post('/setup-webhook')
@jwt_required()
def register_webhook():
    """Admin endpoint to register the Telegram webhook."""
    app_url = request.json.get('app_url')
    if not app_url:
        return jsonify({'error': 'app_url is required'}), 400
    result = setup_webhook(app_url)
    return jsonify(result)


@telegram_bp.delete('/webhook')
@jwt_required()
def unregister_webhook():
    """Admin endpoint to remove the Telegram webhook."""
    result = remove_webhook()
    return jsonify(result)
