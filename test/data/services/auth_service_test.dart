import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/login_request_model.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';
import 'package:jr_case_boilerplate/core/data/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late AuthService authService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    mockDio = MockDio();
    authService = AuthService(dio: mockDio); 
  });

  group('AuthService - Register', () {
    final registerRequest = RegisterRequestModel(
      email: 'test@mail.com',
      name: 'Test User',
      password: 'password123',
    );

    final registerResponseData = {
      "token": "dummy_token",
      "user": {"id": "1", "name": "Test User", "email": "test@mail.com"},
    };

    test('register - success', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          data: registerResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await authService.register(registerRequest);

      expect(result.token, 'dummy_token');
      expect(result.user.name, 'Test User');
    });

    test('register - failure (DioError)', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () async => await authService.register(registerRequest),
        throwsA(isA<DioError>()),
      );
    });
  });

  group('AuthService - Login', () {
    final loginRequest = LoginRequestModel(
      email: 'test@mail.com',
      password: 'password123',
    );

    final loginResponseData = {
      "data": {
        "token": "dummy_token",
        "id": "1",
        "name": "Test User",
        "email": "test@mail.com",
      },
    };

    test('login - success', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          data: loginResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await authService.login(loginRequest);

      expect(result.token, 'dummy_token');
      expect(result.user.name, 'Test User');
    });

    test('login - failure (DioError)', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () async => await authService.login(loginRequest),
        throwsA(isA<DioError>()),
      );
    });
  });
}
