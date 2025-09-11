import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/movie_response_model.dart';
import 'package:jr_case_boilerplate/core/data/repositories/movie_repository.dart';
import 'package:jr_case_boilerplate/core/data/services/movie_service.dart';
import 'package:mocktail/mocktail.dart';

// Mock sınıf
class MockMovieService extends Mock implements MovieService {}

void main() {
  late MockMovieService mockService;
  late MovieRepository repository;

  setUp(() {
    mockService = MockMovieService();
    repository = MovieRepository(mockService);
  });

  final movieListResponse = MovieListResponse(
    movies: [
      Movie(
        id: '1',
        title: 'Movie 1',
        description: 'Description 1',
        posterUrl: 'https://image.com/1.jpg',
      ),
    ],
    totalPages: 1,
    currentPage: 1,
  );

  test('başarılı: getMovies servisi doğru dönüyor', () async {
    when(
      () => mockService.getMovies(page: 1),
    ).thenAnswer((_) async => movieListResponse);

    final result = await repository.getMovies(page: 1);

    expect(result.movies.length, 1);
    expect(result.movies[0].title, 'Movie 1');
    verify(() => mockService.getMovies(page: 1)).called(1);
  });

  test('başarısız: getMovies servisi hata fırlatıyor', () async {
    when(
      () => mockService.getMovies(page: 1),
    ).thenThrow(Exception('Fetch failed'));

    expect(() => repository.getMovies(page: 1), throwsA(isA<Exception>()));
    verify(() => mockService.getMovies(page: 1)).called(1);
  });
}
