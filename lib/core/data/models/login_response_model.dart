class LoginResponseModel {
  final String token;
  final UserData user;

  LoginResponseModel({required this.token, required this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['data']['token'] ?? '',
      user: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;

  UserData({required this.id, required this.name, required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
