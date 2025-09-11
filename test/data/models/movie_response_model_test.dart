import 'package:flutter_test/flutter_test.dart';
import 'package:jr_case_boilerplate/core/data/models/movie_response_model.dart';

void main() {
  group('MovieListResponse fromJson', () {
    test('başarılı: doğru JSON ile model oluşturulmalı', () {
      final json = {
        "data": {
          "movies": [
            {
              "_id": "movie_1",
              "Title": "Inception",
              "Plot": "A mind-bending thriller",
              "Images": ["https://example.com/inception.jpg"]
            },
            {
              "_id": "movie_2",
              "Title": "Interstellar",
              "Plot": "Journey through space",
              "Images": ["https://example.com/interstellar.jpg"]
            },
          ],
          "totalPages": 5,
          "currentPage": 1,
        }
      };

      final response = MovieListResponse.fromJson(json);

      expect(response.movies.length, 2);
      expect(response.movies[0].id, "movie_1");
      expect(response.movies[0].title, "Inception");
      expect(response.movies[0].description, "A mind-bending thriller");
      expect(response.movies[0].posterUrl, "https://example.com/inception.jpg");

      expect(response.totalPages, 5);
      expect(response.currentPage, 1);
    });

    test('başarısız: eksik alanlar ile default değerler alınmalı', () {
      final json = {
        "data": {
          "movies": [
            {
              "_id": null,
              "Title": null,
              "Plot": null,
              "Images": []
            },
            {}
          ],
          "totalPages": null,
          "currentPage": null,
        }
      };

      final response = MovieListResponse.fromJson(json);

      expect(response.movies.length, 2);

      expect(response.movies[0].id, "");
      expect(response.movies[0].title, "");
      expect(response.movies[0].description, "");
      expect(response.movies[0].posterUrl, "");

      expect(response.movies[1].id, "");
      expect(response.movies[1].title, "");
      expect(response.movies[1].description, "");
      expect(response.movies[1].posterUrl, "");

      expect(response.totalPages, 1);
      expect(response.currentPage, 1);
    });
  });
}
