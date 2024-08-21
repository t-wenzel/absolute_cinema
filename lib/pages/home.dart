import 'package:absolute_cinema/api/api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:absolute_cinema/model/movie.dart';
import 'package:absolute_cinema/api/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absolute_cinema/pages/movie_inside.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    super.initState();

    upcomingMovies = Api().getUpcoming();
    popularMovies = Api().getPopular();
    topRatedMovies = Api().getTopRated();
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
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Center(
                                child: Text(
                                  "Absolute Cinema",
                                  style: TextStyle(
                                    color: Color(0xFFFAF8F8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/search");
                              },
                              shape: const CircleBorder(),
                              backgroundColor: const Color(0xFFFAF8F8),
                              child: const Icon(
                                Icons.search,
                                color: Color(0xFF210317),
                                weight: 2,
                               ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  "FILMES POPULARES",
                  style: TextStyle(
                    color: Color(0xFF530928),
                  fontSize: 16,
                  letterSpacing: 2,
                 ),
                ),
              ),
              FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}"
                        ),
                      );
                    }else if(snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;
                      List<Movie> limitedMovies = movies.length > 10 ? movies.sublist(0, 10) : movies;
                      return SizedBox(
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: limitedMovies.length,
                          options: CarouselOptions(
                            viewportFraction: 0.3,
                            height: 150,
                          ),
                          itemBuilder: (context, itemIndex, pageViewIndex){
                            return InkWell(
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              onTap: () => Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MovieInside(movie: snapshot.data![itemIndex]),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                child: SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Image.network(
                                    "${Constants.imagePath}${snapshot.data?[itemIndex].posterPath}",
                                  ),
                                ),
                              ),
                            );
                          },
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
                  ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  "EM BREVE",
                  style: TextStyle(
                    color: Color(0xFF530928),
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ),
              FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(
                            "Error: ${snapshot.error}"
                        ),
                      );
                    }else if(snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;
                      List<Movie> limitedMovies = movies.length > 10 ? movies.sublist(0, 10) : movies;
                      return SizedBox(
                        width: double.infinity,
                        child: CarouselSlider.builder(
                            itemCount: limitedMovies.length,
                            options: CarouselOptions(
                              viewportFraction: 0.3,
                              height: 150,
                            ),
                            itemBuilder: (context, itemIndex, pageViewIndex){
                              return InkWell(
                                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                                onTap: () => Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MovieInside(movie: snapshot.data![itemIndex]),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: Image.network(
                                      "${Constants.imagePath}${snapshot.data?[itemIndex].posterPath}", //Encontra link da imagem para instância de filme
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
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
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  "MELHORES AVALIADOS",
                  style: TextStyle(
                    color: Color(0xFF530928),
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ),
              FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      return Center(
                        child: Text(
                            "Error: ${snapshot.error}"
                        ),
                      );
                    }else if(snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;
                      List<Movie> limitedMovies = movies.length > 10 ? movies.sublist(0, 10) : movies;
                      return SizedBox(
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: limitedMovies.length,
                          options: CarouselOptions(
                            viewportFraction: 0.3,
                            height: 150,
                          ),
                          itemBuilder: (context, itemIndex, pageViewIndex){
                            return InkWell(
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              onTap: () => Navigator.push(context, MaterialPageRoute(
                                builder: (context) => MovieInside(movie: snapshot.data![itemIndex]),
                              ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                child: SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Image.network(
                                    "${Constants.imagePath}${snapshot.data?[itemIndex].posterPath}",
                                  ),
                                ),
                              ),
                            );
                          },
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
              ),
              ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: IntrinsicHeight(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8)
              ),
              color: Color(0xFF210317),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                        "Powered by",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFAF8F8),
                        ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: SvgPicture.asset(
                        "assets/tmdb.svg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}