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

  static Future<PaginatedNewsModel> fetchNews({int page = 1, String lang = 'en'}) async {
    final res = await _dio.get('/v1/news/', queryParameters: {
      'page': page,
      'per_page': AppConstants.pageSize,
      'lang': lang,
    });
    return PaginatedNewsModel.fromJson(res.data);
  }

  static Future<List<HeritageModel>> fetchHeritage({String lang = 'en'}) async {
    final res = await _dio.get('/v1/heritage/', queryParameters: {'lang': lang});
    return (res.data as List).map((e) => HeritageModel.fromJson(e)).toList();
  }

  static Future<List<DictionaryModel>> fetchDictionary({String lang = 'en'}) async {
    final res = await _dio.get('/v1/dictionary/', queryParameters: {'lang': lang});
    return (res.data as List).map((e) => DictionaryModel.fromJson(e)).toList();
  }

  static Future<Map<String, dynamic>> fetchSync(DateTime? since, {String lang = 'en'}) async {
    final params = <String, dynamic>{'lang': lang};
    if (since != null) params['since'] = since.toIso8601String();
    final res = await _dio.get('/v1/sync/', queryParameters: params);
    return res.data as Map<String, dynamic>;
  }

  static Future<String> login(String username, String password) async {
    final res = await _dio.post('/v1/auth/login', data: {
      'username': username,
      'password': password,
    });
    return res.data['token'];
  }

  static Future<List<HeroModel>> fetchHeroes({String lang = 'en'}) async {
    final res = await _dio.get('/v1/heroes/', queryParameters: {'lang': lang});
    return (res.data as List).map((e) => HeroModel.fromJson(e)).toList();
  }

  static Future<List<DidYouKnowModel>> fetchDidYouKnow({String lang = 'en'}) async {
    final res = await _dio.get('/v1/did-you-know/', queryParameters: {'lang': lang});
    return (res.data as List).map((e) => DidYouKnowModel.fromJson(e)).toList();
  }
}
