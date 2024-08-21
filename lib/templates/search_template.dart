import 'package:flutter/material.dart';
import 'package:absolute_cinema/model/movie.dart';
import 'package:absolute_cinema/api/api.dart';
import 'package:absolute_cinema/pages/movie_inside.dart';

class MovieSearchTemplate extends StatelessWidget{

  const MovieSearchTemplate({
    super.key,
    required this.movie,
    required this.snapshot
  });

  final Movie movie;
  final AsyncSnapshot<List<Movie>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 75,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: FutureBuilder(
            future: Api().getMoviePoster(movie, movie.posterPath),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return const Icon(Icons.image, size: 50);
              }else if(snapshot.hasData) {
                return Image.network(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/dummyImage.png',
                      fit: BoxFit.cover,
                    );
                  },
                );
              }else{
                return const Center(
                  child: Text(
                      "Loading..."
                  ),
                );
              }
            }
          ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(
          movie.releaseDate
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieInside(movie: movie),
      ),
     )
    );
  }

}