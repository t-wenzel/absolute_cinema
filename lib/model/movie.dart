class Movie {

  String title;
  String overview;
  String posterPath;
  String backdropPath;
  String releaseDate;
  List<dynamic> genreIds;

  Movie({

    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.genreIds,

  });

  factory Movie.fromMap(Map<String, dynamic> map) {

    return Movie(
        title: map['title'] ?? "Movie Title",
        overview: map['overview'] ?? "Movie Overview",
        posterPath: map['poster_path'] ?? "Movie Poster Path",
        backdropPath: map['backdrop_path'] ?? "Movie Poster Path",
        releaseDate: map['release_date'] ?? "Movie Release Date",
        genreIds: map['genre_ids'] ?? "Genre IDs",
    );

  }

}