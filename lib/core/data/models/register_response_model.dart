class RegisterResponseModel {
  final String token;
  final UserModel user;

  RegisterResponseModel({
    required this.token,
    required this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      token: json["token"],
      user: UserModel.fromJson(json["user"]),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }
}
