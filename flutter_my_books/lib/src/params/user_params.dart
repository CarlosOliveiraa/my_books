import 'dart:typed_data';

class UserParams {
  final String name;
  final String email;
  final String password;
  final Uint8List imageProfile;

  UserParams({
    required this.name,
    required this.email,
    required this.password,
    required this.imageProfile,
  });
}
