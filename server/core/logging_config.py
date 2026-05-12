import logging
import time
from flask import request, g
from werkzeug.exceptions import HTTPException

def configure_logging(app):
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s [%(levelname)s] %(name)s: %(message)s',
    )
    app.logger.setLevel(logging.INFO)

    @app.before_request
    def _start_timer():
        g.start_time = time.time()

    @app.after_request
    def _log_request(response):
        duration = round((time.time() - g.get('start_time', time.time())) * 1000, 2)
        app.logger.info(
            '%s %s %s %sms',
            request.method,
            request.path,
            response.status_code,
            duration,
        )
        return response

    @app.errorhandler(HTTPException)
    def _handle_http_exception(e):
        return {'error': e.description}, e.code

    @app.errorhandler(Exception)
    def _handle_exception(e):
        app.logger.exception('Unhandled exception: %s', str(e))
        return {'error': 'Internal server error'}, 500
