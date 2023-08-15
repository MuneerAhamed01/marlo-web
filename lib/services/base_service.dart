import 'package:dio/dio.dart';
import 'package:sample/services/token_service.dart';

class BaseService {
  BaseService._();
  static BaseService get instance => BaseService._();
  final TokenService _tokenService = TokenService.instance;
  final Dio _dio = Dio();

  Future<Response<dynamic>> get(String url) async {
    try {
      final token = await _tokenService.getToken();

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'authToken': token,
          },
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
