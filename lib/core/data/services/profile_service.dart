import 'package:dio/dio.dart';
import '../models/user_profile_response_model.dart';
import '../storage/token_storage.dart';

class ProfileService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://caseapi.servicelabs.tech/"),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<UserProfileResponseModel> getProfile() async {
    final token = await TokenStorage.getToken();
    final response = await _dio.get(
      "user/profile",
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );
    print('ProfileService.getProfile response:');
    print(response.data);
    return UserProfileResponseModel.fromJson(response.data);
  }

  Future<UserProfileResponseModel> updateProfile(
    Map<String, dynamic> data,
  ) async {
    final token = await TokenStorage.getToken();
    final response = await _dio.put(
      "user/profile",
      data: data,
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );
    return UserProfileResponseModel.fromJson(response.data);
  }
}
