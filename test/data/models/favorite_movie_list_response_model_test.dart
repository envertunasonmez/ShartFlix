import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/favorite_movie_list_response_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteMovieService extends Mock {}

void main() {
  group('FavoriteMovieListResponseModel', () {
    test('fromJson - başarılı parse', () {
      final json = {
        "data": [
          {
            "id": "1",
            "Title": "Inception",
            "Plot": "A mind-bending thriller",
            "Poster": "http://image.url/inception.jpg",
          },
          {
            "id": "2",
            "Title": "Interstellar",
            "Plot": "Space exploration story",
            "Poster": "http://image.url/interstellar.jpg",
          },
        ],
      };

      final response = FavoriteMovieListResponseModel.fromJson(json);

      expect(response.movies.length, 2);
      expect(response.movies[0].title, "Inception");
      expect(response.movies[0].posterUrl.startsWith('https://'), true);
      expect(response.movies[1].description, "Space exploration story");
    });

    test('fromJson - başarısız parse (data null)', () {
      final json = {"data": null};

      final response = FavoriteMovieListResponseModel.fromJson(json);

      expect(response.movies.isEmpty, true);
    });

    test('fromJson - başarısız parse (data key yok)', () {
      final json = {"otherKey": []};

      final response = FavoriteMovieListResponseModel.fromJson(json);

      expect(response.movies.isEmpty, true);
    });

    test('FavoriteMovie fromJson - eksik alanlar', () {
      final json = {"id": "3", "Poster": null};

      final movie = FavoriteMovie.fromJson(json);

      expect(movie.id, "3");
      expect(movie.title, "");
      expect(movie.description, "");
      expect(movie.posterUrl, "https://");
    });
  });
}
