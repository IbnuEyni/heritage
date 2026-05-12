import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/app_constants.dart';
import '../models/api_models.dart';

class ApiClient {
  static const _storage = FlutterSecureStorage();

  static Dio get _dio {
    final dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'jwt_token');
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
    ));
    return dio;
  }

  // News with pagination
  static Future<PaginatedNewsModel> fetchNews({int page = 1}) async {
    final res = await _dio.get('/v1/news/', queryParameters: {
      'page': page,
      'per_page': AppConstants.pageSize,
    });
    return PaginatedNewsModel.fromJson(res.data);
  }

  // Heritage
  static Future<List<HeritageModel>> fetchHeritage() async {
    final res = await _dio.get('/v1/heritage/');
    return (res.data as List).map((e) => HeritageModel.fromJson(e)).toList();
  }

  // Dictionary
  static Future<List<DictionaryModel>> fetchDictionary() async {
    final res = await _dio.get('/v1/dictionary/');
    return (res.data as List).map((e) => DictionaryModel.fromJson(e)).toList();
  }

  // Delta sync — only records changed since last sync
  static Future<Map<String, dynamic>> fetchSync(DateTime? since) async {
    final res = await _dio.get('/v1/sync/', queryParameters:
      since != null ? {'since': since.toIso8601String()} : null);
    return res.data as Map<String, dynamic>;
  }
  static Future<String> login(String username, String password) async {
    final res = await _dio.post('/v1/auth/login', data: {
      'username': username,
      'password': password,
    });
    return res.data['token'];
  }

  static Future<List<HeroModel>> fetchHeroes() async {
    final res = await _dio.get('/v1/heroes/');
    return (res.data as List).map((e) => HeroModel.fromJson(e)).toList();
  }

  static Future<List<DidYouKnowModel>> fetchDidYouKnow() async {
    final res = await _dio.get('/v1/did-you-know/');
    return (res.data as List).map((e) => DidYouKnowModel.fromJson(e)).toList();
  }
}
