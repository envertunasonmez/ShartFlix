import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:jr_case_boilerplate/core/data/services/favorite_service.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_request_model.dart';
import 'package:jr_case_boilerplate/core/data/storage/token_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  Mock classes
class MockDio extends Mock implements Dio {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late FavoriteService favoriteService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDio = MockDio();
    favoriteService = FavoriteService();
  });

  group('FavoriteService - addFavorite', () {
    final favoriteRequest = FavoriteRequestModel(favoriteId: '123');

    test('Başarılı addFavorite', () async {
      // TokenStorage mock
      TokenStorage.saveToken('dummy_token');

      // Dio mock
      when(
        () => mockDio.post(any(), options: any(named: 'options')),
      ).thenAnswer(
        (_) async => Response(
          data: {"id": "123", "favoriteId": "456", "userId": "1"},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    });

    test('addFavorite başarısız (DioError)', () async {
      TokenStorage.saveToken('dummy_token');

      when(() => mockDio.post(any(), options: any(named: 'options'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () async => await favoriteService.addFavorite(favoriteRequest),
        throwsA(isA<DioError>()),
      );
    });
  });

  group('FavoriteService - getFavorites', () {
    test('Başarılı getFavorites', () async {
      TokenStorage.saveToken('dummy_token');

      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (_) async => Response(
          data: {
            "movies": [
              {
                "id": "1",
                "title": "Test Movie",
                "description": "Desc",
                "posterUrl": "url",
              },
            ],
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    });

    test('getFavorites başarısız (DioError)', () async {
      TokenStorage.saveToken('dummy_token');

      when(() => mockDio.get(any(), options: any(named: 'options'))).thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () async => await favoriteService.getFavorites(),
        throwsA(isA<DioError>()),
      );
    });
  });
}
