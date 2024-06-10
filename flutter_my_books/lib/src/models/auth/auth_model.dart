class AuthModel {
  final String? token;

  AuthModel({this.token});

  static AuthModel fromJson(Map<String, dynamic> json) {
    return AuthModel(token: json['token']);
  }
}
