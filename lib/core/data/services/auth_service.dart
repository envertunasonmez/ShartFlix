import 'package:dio/dio.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../storage/token_storage.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://caseapi.servicelabs.tech/"),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    final response = await _dio.post("user/register", data: model.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    final response = await _dio.post("user/login", data: model.toJson());
    final loginResponse = LoginResponseModel.fromJson(response.data);
    await TokenStorage.saveToken(loginResponse.token);
    return loginResponse;
  }
}
