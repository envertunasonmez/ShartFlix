import 'package:dio/dio.dart';
import 'package:jr_case_boilerplate/core/network/dio_client.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../storage/token_storage.dart';

class AuthService {
  final Dio _dio = DioClient.instance;

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
