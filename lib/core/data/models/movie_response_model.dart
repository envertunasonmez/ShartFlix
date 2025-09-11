class Movie {
  final String id;
  final String title;
  final String description;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final images = json["Images"] as List<dynamic>?;

    return Movie(
      id: json["_id"] ?? "",
      title: json["Title"] ?? "",
      description: json["Plot"] ?? "",
      posterUrl: (images != null && images.isNotEmpty)
          ? images[0] as String
          : "",
    );
  }
}

class MovieListResponse {
  final List<Movie> movies;
  final int totalPages;
  final int currentPage;

  MovieListResponse({
    required this.movies,
    required this.totalPages,
    required this.currentPage,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"] ?? {};
    final moviesJson = data["movies"];
    List<Movie> moviesList = [];

    if (moviesJson != null && moviesJson is List) {
      moviesList = moviesJson
          .map((e) => Movie.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    }

    return MovieListResponse(
      movies: moviesList,
      totalPages: data["totalPages"] ?? 1,
      currentPage: data["currentPage"] ?? 1,
    );
  }
}
