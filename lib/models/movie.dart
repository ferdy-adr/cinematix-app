part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title, overview, posterPath;
  final String? backdropPath;
  final double voteAverage;

  const Movie(
      {required this.id,
      required this.title,
      required this.voteAverage,
      required this.overview,
      required this.posterPath,
      required this.backdropPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path']);
  }

  @override
  List<Object?> get props =>
      [id, title, voteAverage, overview, posterPath, backdropPath];
}
