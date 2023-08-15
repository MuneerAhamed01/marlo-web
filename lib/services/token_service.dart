import 'package:dio/dio.dart';

class TokenService {
  TokenService._();
  String? _token;
  DateTime _tokenExpiration = DateTime.now();
  static TokenService get instance => TokenService._();
  final Dio _dio = Dio();

  Future<String> _fetchToken() async {
    try {
      final response = await _dio.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBFiEDfEaaK6lBtIdxLXspmxGux1TGsCmg',
        data: {
          "email": "geethumahi38+2@gmail.com",
          "password": "Marlo@123",
          "returnSecureToken": true
        },
      );
      return response.data['idToken'];
    } catch (e) {
      print(e);
      throw Exception('Token Generation failed');
    }
  }

  Future<String> getToken() async {
    try {
      if (_token == null || DateTime.now().isAfter(_tokenExpiration)) {
        _token = await _fetchToken();
        _tokenExpiration = DateTime.now().add(const Duration(hours: 1));
      }

      return _token!;
    } catch (e) {
      rethrow;
    }
  }
}
