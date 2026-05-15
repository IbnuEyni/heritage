"""
Cloudflare R2 Storage Service
──────────────────────────────
Handles file uploads to Cloudflare R2 (S3-compatible).
"""
import os
import logging
import boto3
from botocore.config import Config

logger = logging.getLogger(__name__)

_client = None


def _get_client():
    global _client
    if _client is None:
        _client = boto3.client(
            's3',
            endpoint_url=os.getenv('R2_ENDPOINT_URL'),
            aws_access_key_id=os.getenv('R2_ACCESS_KEY_ID'),
            aws_secret_access_key=os.getenv('R2_SECRET_ACCESS_KEY'),
            config=Config(signature_version='s3v4'),
            region_name='auto',
        )
    return _client


def upload_file(file_bytes: bytes, filename: str, content_type: str = 'image/jpeg') -> str | None:
    """
    Upload file bytes to R2 and return the public URL.
    Returns None if upload fails or R2 is not configured.
    """
    bucket = os.getenv('R2_BUCKET_NAME')
    public_url = os.getenv('R2_PUBLIC_URL', '').rstrip('/')

    if not bucket or not public_url:
        logger.warning('R2 not configured, skipping upload')
        return None

    try:
        client = _get_client()
        key = f'news/{filename}'
        client.put_object(
            Bucket=bucket,
            Key=key,
            Body=file_bytes,
            ContentType=content_type,
        )
        url = f'{public_url}/{key}'
        logger.info(f'Uploaded to R2: {url}')
        return url
    except Exception as e:
        logger.error(f'R2 upload failed: {e}')
        return None
