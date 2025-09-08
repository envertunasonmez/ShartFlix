import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    return await _service.register(model);
  }

  Future<LoginResponseModel> login(LoginRequestModel model) async {
    return await _service.login(model);
  }
}
