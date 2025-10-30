import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'https://flaskapiexample-production.up.railway.app';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      await _storage.write(key: 'jwt', value: token);
      return token;
    }
    return null;
  }

 Future<bool> register(String username, String password) async {
  try {
    final url = Uri.parse('$baseUrl/users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    print('📡 Código: ${response.statusCode}');
    print('📦 Cuerpo: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      final data = jsonDecode(response.body);
      print('⚠️ Mensaje del servidor: ${data['message']}');
      return false;
    }
  } catch (e) {
    print('❌ Excepción en register: $e');
    return false;
  }
}

}