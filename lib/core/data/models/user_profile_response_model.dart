class UserProfileResponseModel {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  UserProfileResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return UserProfileResponseModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl};
  }
}
