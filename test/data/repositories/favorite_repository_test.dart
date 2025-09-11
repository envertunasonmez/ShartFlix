import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_movie_list_response_model.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_request_model.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_response_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/favorite_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/favorite_service.dart';
import 'package:mocktail/mocktail.dart';

// Mock FavoriteService
class MockFavoriteService extends Mock implements FavoriteService {}

void main() {
  late MockFavoriteService mockService;
  late FavoriteRepository repository;

  setUp(() {
    mockService = MockFavoriteService();
    repository = FavoriteRepository(mockService);
  });

  group('FavoriteRepository addFavorite', () {
    final request = FavoriteRequestModel(favoriteId: 'movie_1');
    final response = FavoriteResponseModel(success: true, message: 'Added');

    test('başarılı: addFavorite servisi doğru dönüyor', () async {
      when(() => mockService.addFavorite(request))
          .thenAnswer((_) async => response);

      final result = await repository.addFavorite(request);

      expect(result.success, true);
      expect(result.message, 'Added');
      verify(() => mockService.addFavorite(request)).called(1);
    });

    test('başarısız: addFavorite servisi hata fırlatıyor', () async {
      when(() => mockService.addFavorite(request))
          .thenThrow(Exception('Add failed'));

      expect(() => repository.addFavorite(request), throwsA(isA<Exception>()));
      verify(() => mockService.addFavorite(request)).called(1);
    });
  });

  group('FavoriteRepository getFavorites', () {
    final movieList = FavoriteMovieListResponseModel(movies: [
      FavoriteMovie(
          id: '1',
          title: 'Movie 1',
          description: 'Description',
          posterUrl: 'https://image.com/movie1.jpg')
    ]);

    test('başarılı: getFavorites servisi doğru dönüyor', () async {
      when(() => mockService.getFavorites())
          .thenAnswer((_) async => movieList);

      final result = await repository.getFavorites();

      expect(result.movies.length, 1);
      expect(result.movies[0].title, 'Movie 1');
      verify(() => mockService.getFavorites()).called(1);
    });

    test('başarısız: getFavorites servisi hata fırlatıyor', () async {
      when(() => mockService.getFavorites())
          .thenThrow(Exception('Fetch failed'));

      expect(() => repository.getFavorites(), throwsA(isA<Exception>()));
      verify(() => mockService.getFavorites()).called(1);
    });
  });
}
