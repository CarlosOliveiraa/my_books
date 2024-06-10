import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_my_books/src/models/auth/auth_model.dart';
import 'package:flutter_my_books/src/params/user_params.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<AuthModel> login(
      {required String email, required String password}) async {
    try {
      final body = jsonEncode({'email': email, 'password': password});
      final result = await http.post(
        Uri.parse('${dotenv.env["BASE_URL"]}/auth/login'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: body,
      );
      if (result.statusCode == 200) {
        final token = jsonDecode(result.body)['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }

      return AuthModel.fromJson(jsonDecode(result.body));
    } catch (error) {
      throw error.toString();
    }
  }

  Future<int> signUp({required UserParams params}) async {
    try {
      String imageBase64 = base64Encode(params.imageProfile);

      final body = {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'imageProfile': imageBase64,
      };
      final result = await http.post(
          Uri.parse('${dotenv.env["BASE_URL"]}/auth/register'),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(body));
      final id = jsonDecode(result.body);
      return id['id'];
    } catch (error) {
      throw error.toString();
    }
  }
}
