import os
import hashlib
from gtts import gTTS

# Audio cache directory — served as static files by Flask
_CACHE_DIR = os.path.join(os.path.dirname(__file__), '..', 'uploads', 'tts')
os.makedirs(_CACHE_DIR, exist_ok=True)

# Language → gTTS locale code
# gTTS uses Google Translate's TTS engine — no API key, no billing.
# Neither Oromo (om) nor Amharic (am) are supported by any free TTS engine.
# Arabic (ar) shares Afroasiatic phonology with both languages and produces
# significantly better pronunciation than English for Ethiopic scripts.
_LANG_MAP = {
    'kebena':  'ar',   # Oromo — closest free phonetic approximation
    'amharic': 'ar',   # Amharic — closest free phonetic approximation
    'english': 'en',
}


def synthesize(text: str, language: str) -> str:
    """
    Synthesize text to speech using gTTS and return the path to the cached MP3.
    Raises ValueError for unknown language.
    """
    if language not in _LANG_MAP:
        raise ValueError(
            f'Unknown language: "{language}". Must be one of {list(_LANG_MAP)}'
        )

    # Cache key: sha256(language:text) — identical requests served from disk
    cache_key = hashlib.sha256(f'{language}:{text}'.encode()).hexdigest()
    cache_path = os.path.join(_CACHE_DIR, f'{cache_key}.mp3')

    if os.path.exists(cache_path):
        return cache_path

    tts = gTTS(text=text, lang=_LANG_MAP[language], slow=False)
    tts.save(cache_path)

    return cache_path
