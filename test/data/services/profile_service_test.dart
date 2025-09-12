import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:jr_case_boilerplate/core/data/services/profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

Future<String?> dummyGetToken() async => 'dummy_token';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late ProfileService profileService;

  setUp(() {
    mockDio = MockDio();
    SharedPreferences.setMockInitialValues({"token": "dummy_token"});
    profileService = ProfileService(dio: mockDio);
  });

  group('ProfileService', () {
    final mockProfileData = {
      "data": {
        "id": "1",
        "name": "Test User",
        "email": "test@example.com",
        "photoUrl": "https://example.com/photo.jpg",
      }
    };

    test('getProfile - success', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (_) async => Response(
          data: mockProfileData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      profileService = ProfileService(
        dio: mockDio,
      );

      final result = await profileService.getProfile();

      expect(result.name, "Test User");
      expect(result.email, "test@example.com");
      expect(result.photoUrl, "https://example.com/photo.jpg");

      verify(() => mockDio.get("user/profile", options: any(named: 'options'))).called(1);
    });

    test('updateProfile - success', () async {
      final updateData = {"name": "Updated User"};

      when(() => mockDio.put(any(), data: updateData, options: any(named: 'options')))
          .thenAnswer(
        (_) async => Response(
          data: {
            "data": {
              "id": "1",
              "name": "Updated User",
              "email": "test@example.com",
              "photoUrl": "https://example.com/photo.jpg",
            }
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await profileService.updateProfile(updateData);

      expect(result.name, "Updated User");
      expect(result.email, "test@example.com");
      expect(result.photoUrl, "https://example.com/photo.jpg");

      verify(() => mockDio.put("user/profile", data: updateData, options: any(named: 'options'))).called(1);
    });
  });
}
