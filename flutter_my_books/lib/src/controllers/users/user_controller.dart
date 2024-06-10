import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/users/user_model.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future<UserModel> fetchUserdata() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final id = Jwt.parseJwt(token!)['id'];
      final result = await http
          .post(Uri.parse('${dotenv.env["BASE_URL"]}/user/userdata/$id'));
      return UserModel.fromJson(
        jsonDecode(result.body),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
