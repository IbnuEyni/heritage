import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final _player = AudioPlayer();
  final _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    responseType: ResponseType.bytes,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Stream<bool> get playingStream => _player.playingStream;
  bool get isPlaying => _player.playing;

  Future<void> speak(String text, String language) async {
    await _player.stop();
    final file = await _cacheFile(text, language);
    if (!file.existsSync()) {
      await _fetchAndCache(text, language, file);
    }
    await _player.setFilePath(file.path);
    await _player.seek(Duration.zero);
    await _player.setSpeed(1.0);
    await _player.play();
  }

  Future<void> stop() => _player.stop();

  Future<File> _cacheFile(String text, String language) async {
    final dir = await getApplicationCacheDirectory();
    final ttsDir = Directory('${dir.path}/tts');
    await ttsDir.create(recursive: true);
    final key = md5.convert(utf8.encode('$language:$text')).toString();
    return File('${ttsDir.path}/$key.mp3');
  }

  Future<void> _fetchAndCache(String text, String language, File dest) async {
    final response = await _dio.post<List<int>>(
      '/v1/tts/',
      data: {'text': text, 'language': language},
    );
    await dest.writeAsBytes(response.data!);
  }
}
