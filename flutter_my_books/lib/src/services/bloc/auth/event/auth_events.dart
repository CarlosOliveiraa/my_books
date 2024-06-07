abstract class AuthEvent {}

class FetchUserEvent extends AuthEvent {
  final String email;
  final String password;

  FetchUserEvent({required this.email, required this.password});
}
