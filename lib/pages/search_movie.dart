import 'package:absolute_cinema/api/api.dart';
import 'package:flutter/material.dart';
import 'package:absolute_cinema/model/movie.dart';
import 'package:absolute_cinema/templates/search_template.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {

  final controller = TextEditingController();
  Future<List<Movie>>? search;

  @override
  void initState() {
    super.initState();
    search = Api().getPopular();
  }

  List<Movie> sortSearch(List<Movie> movieList){

    movieList.map((movie) {
      return DateTime.parse(movie.releaseDate);
    }).toList();

    movieList.sort((a,b) {
      return a.releaseDate.compareTo(b.releaseDate);
    });

    return movieList;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SizedBox(
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8)
                ),
                color: Color(0xFF210317),
              ),
              child: SafeArea(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: TextField(
                    onChanged: searchMovie,
                    cursorColor: const Color(0xFF210317),
                    controller: controller,
                    style: const TextStyle(
                      color: Color(0xFF210317),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(9),
                      filled: true,
                      fillColor: Color(0xFFFAF8F8),
                      hintText: "Search for a movie name...",
                      labelStyle: TextStyle(
                        color: Color(0xFFFAF8F8),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      )
                    ),
                  ),
                )
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: search,
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.hasError.toString()
                ),
              );
            }else if(snapshot.hasData) {
              List<Movie> movies = snapshot.data!;
              List<Movie> limitedMovies = movies.length > 10 ? movies.sublist(0, 10) : movies; //Creates a list of up to 10 items based on the data received in the snapshot
              limitedMovies.sort((a,b) {
                int balance = b.releaseDate.compareTo(a.releaseDate); //Puts movies in the list in ascending release date order and stores it in the balance variable
                if(balance == 0){
                  balance = a.title.compareTo(b.title); //If release dates are equal, sorts by title
                }
                return balance;
              });
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    limitedMovies.length, (index) => MovieSearchTemplate(movie: limitedMovies[index], snapshot: snapshot),
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
    );
  }

  void searchMovie(String query) async{
    final results = await Api().getSearch(query);
    setState(() {
      search = Future.value(results);
    });
  }
}
