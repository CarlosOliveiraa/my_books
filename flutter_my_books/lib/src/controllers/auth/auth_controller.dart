import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_my_books/src/params/user_params.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/users/user_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthController {
  Future<UserModel> login(
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
      final decodedToken = Jwt.parseJwt(jsonDecode(result.body)['token']);
      return UserModel.fromJson(decodedToken);
    } catch (error) {
      throw error.toString();
    }
  }

  Future<int> signUp({required UserParams params}) async {
    try {
      final body = {
        'name': params.name,
        'email': params.email,
        'password': params.password
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
