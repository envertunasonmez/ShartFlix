class FavoriteMovieListResponseModel {
  final List<FavoriteMovie> movies;

  FavoriteMovieListResponseModel({required this.movies});

  factory FavoriteMovieListResponseModel.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List? ?? [];
    return FavoriteMovieListResponseModel(
      movies: dataList.map((e) => FavoriteMovie.fromJson(e)).toList(),
    );
  }
}

class FavoriteMovie {
  final String id;
  final String title;
  final String description;
  final String posterUrl;

  FavoriteMovie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
  });

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      id: json['id'] ?? '',
      title: json['Title'] ?? '',
      description: json['Plot'] ?? '',
      posterUrl: (json['Poster'] ?? '').toString().replaceFirst(
        'http://',
        'https://',
      ),
    );
  }
}
