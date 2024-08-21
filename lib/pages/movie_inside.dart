import 'package:absolute_cinema/api/api.dart';
import 'package:flutter/material.dart';
import 'package:absolute_cinema/model/movie.dart';
import 'package:absolute_cinema/api/constants.dart';
import 'package:absolute_cinema/templates/genre_template.dart';
import 'package:absolute_cinema/model/genre.dart';

class MovieInside extends StatelessWidget{

  final Movie movie;

  const MovieInside({
    super.key,
    required this.movie
  });

  String? nameToId(int id, List<Genre> genreList) {
    for (var genre in genreList) {
      if (genre.id == id) {
        return genre.name;
      }
    }
    return null; // If no genre matches the ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFFAF8F8),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(8)
            ),
            color: Color(0xFF210317),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        "${Constants.imagePath}${movie.posterPath}"
                    ),
                  ),
                  const SizedBox(height: 32),
                  Column(
                    children: [
                      Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "TÍTULO DO FILME",
                            style: TextStyle(
                              color: Color(0xFF530928),
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Color(0xFF210317),
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ]
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "LANÇADO EM",
                        style: TextStyle(
                          color: Color(0xFF530928),
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        movie.releaseDate.toString(),
                        style: const TextStyle(
                          color: Color(0xFF210317),
                          fontSize: 24,
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "SINOPSE",
                        style: TextStyle(
                          color: Color(0xFF530928),
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        movie.overview,
                        style: const TextStyle(
                          color: Color(0xFF210317),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GÊNEROS",
                        style: TextStyle(
                          color: Color(0xFF530928),
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                      FutureBuilder(
                          future: Api().getGenres(),
                          builder: (context, snapshot) {
                            if(snapshot.hasError) {
                              return Center(
                                child: Text(
                                    snapshot.hasError.toString(),
                                ),
                              );
                            }else if(snapshot.hasData) {
                              List<Genre> genres = snapshot.data!;
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      movie.genreIds.length, (index) => GenreTemplate(
                                        genreName: nameToId(movie.genreIds[index], genres)!,
                                        snapshot: snapshot,
                                      )
                                    /*mapIds.length, (index) => GenreTemplate(
                                      genreName: GenreList().genreMap(mapIds.), //(genreIds[index].toString()), pega lista de gêneros genreIds, escolhe o valor de número index e converte para String
                                      snapshot: snapshot,
                                    ),*/
                                  ),
                                ),
                              );
                            }else{
                              return const Center(
                                child: Text(
                                    "Loading..."
                                ),
                              );
                            }
                          }
                      )
                    ],
                  )
                ],
              ),
          ),
          ),
      )
      );
  }

}