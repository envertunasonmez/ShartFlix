import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jr_case_boilerplate/core/data/services/movie_service.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late MovieService movieService;

  setUp(() {
    mockDio = MockDio();
    movieService = MovieService(dio: mockDio);

    SharedPreferences.setMockInitialValues({"token": "dummy_token"});
  });

  group('MovieService - getMovies', () {
    final movieListResponseData = {
      "data": {
        "movies": [
          {
            "_id": "1",
            "Title": "Movie 1",
            "Plot": "Description 1",
            "Images": ["http://url1"],
          },
          {
            "_id": "2",
            "Title": "Movie 2",
            "Plot": "Description 2",
            "Images": ["http://url2"],
          },
        ],
        "totalPages": 1,
        "currentPage": 1,
      },
    };

    test('getMovies - success', () async {
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenAnswer(
        (_) async => Response(
          data: movieListResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await movieService.getMovies(page: 1);

      expect(result.movies.length, 2);
      expect(result.movies.first.title, 'Movie 1');
      expect(result.movies.first.posterUrl, 'https://url1');
    });

    test('getMovies - failure (DioError)', () async {
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters'),
              options: any(named: 'options')))
          .thenThrow(
        DioError(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(
        () async => await movieService.getMovies(page: 1),
        throwsA(isA<DioError>()),
      );
    });
  });
}
