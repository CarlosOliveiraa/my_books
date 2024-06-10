class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? imageProfile;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.imageProfile,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageProfile: json['imageProfile'],
    );
  }
}
