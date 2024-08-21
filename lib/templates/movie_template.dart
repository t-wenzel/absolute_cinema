import 'package:flutter/material.dart';
import 'package:absolute_cinema/model/movie.dart';
import 'package:absolute_cinema/api/constants.dart';
import 'package:absolute_cinema/pages/movie_inside.dart';

class MovieTemplate extends StatelessWidget {

  const MovieTemplate({
    super.key,
    required this.movie,
    required this.snapshot
  });

  final Movie movie;
  final AsyncSnapshot<List<Movie>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "${Constants.imagePath}${movie.posterPath}",
            ),
          ),
          onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieInside(movie: movie),
          ),
        )
      ),
    );
  }
}