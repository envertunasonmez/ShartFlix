import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/login_request_model.dart';
import 'package:jr_case_boilerplate/core/data/models/login_response_model.dart';
import 'package:jr_case_boilerplate/core/data/models/register_request_model.dart';
import 'package:jr_case_boilerplate/core/data/models/register_response_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/auth_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockService;
  late AuthRepository repository;

  setUp(() {
    mockService = MockAuthService();
    repository = AuthRepository(mockService);
  });

  group('AuthRepository register', () {
    final registerRequest = RegisterRequestModel(
      email: 'enver@example.com',
      name: 'Enver',
      password: '123456',
    );

    final registerResponse = RegisterResponseModel(
      token: 'token123',
      user: UserModel(id: '1', name: 'Enver', email: 'enver@example.com'),
    );

    test('başarılı: register servisi doğru döndürüyor', () async {
      when(
        () => mockService.register(registerRequest),
      ).thenAnswer((_) async => registerResponse);

      final result = await repository.register(registerRequest);

      expect(result.token, 'token123');
      expect(result.user.name, 'Enver');
      verify(() => mockService.register(registerRequest)).called(1);
    });

    test('başarısız: register servisi hata fırlatıyor', () async {
      when(
        () => mockService.register(registerRequest),
      ).thenThrow(Exception('Register failed'));

      expect(
        () => repository.register(registerRequest),
        throwsA(isA<Exception>()),
      );
      verify(() => mockService.register(registerRequest)).called(1);
    });
  });

  group('AuthRepository login', () {
    final loginRequest = LoginRequestModel(
      email: 'enver@example.com',
      password: '123456',
    );

    final loginResponse = LoginResponseModel(
      token: 'token456',
      user: UserData(id: '1', name: 'Enver', email: 'enver@example.com'),
    );

    test('başarılı: login servisi doğru döndürüyor', () async {
      when(
        () => mockService.login(loginRequest),
      ).thenAnswer((_) async => loginResponse);

      final result = await repository.login(loginRequest);

      expect(result.token, 'token456');
      expect(result.user.email, 'enver@example.com');
      verify(() => mockService.login(loginRequest)).called(1);
    });

    test('başarısız: login servisi hata fırlatıyor', () async {
      when(
        () => mockService.login(loginRequest),
      ).thenThrow(Exception('Login failed'));

      expect(() => repository.login(loginRequest), throwsA(isA<Exception>()));
      verify(() => mockService.login(loginRequest)).called(1);
    });
  });
}
