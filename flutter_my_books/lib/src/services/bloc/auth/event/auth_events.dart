import 'package:flutter_my_books/src/params/user_params.dart';

abstract class AuthEvent {}

class FetchUserEvent extends AuthEvent {
  final String email;
  final String password;

  FetchUserEvent({required this.email, required this.password});
}

class SignUpUserEvent extends AuthEvent {
  final UserParams params;

  SignUpUserEvent({required this.params});
}
