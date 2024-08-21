import 'dart:convert';
import '../model/movie.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:absolute_cinema/model/genre.dart';

class Api{

  final upcomingApiUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}&language=pt-BR';
  final popularApiUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}&language=pt-BR';
  final topRatedApiUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}&language=pt-BR';

  Future<List<Movie>> getUpcoming() async{

    final response = await http.get(Uri.parse(upcomingApiUrl));

    if(response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) ['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception("Falha em carregar filmes");
    }

  }

  Future<List<Movie>> getPopular() async{

    final response = await http.get(Uri.parse(popularApiUrl));

    if(response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) ['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception("Falha em carregar filmes");
    }

  }

  Future<List<Movie>> getTopRated() async{

    final response = await http.get(Uri.parse(topRatedApiUrl));

    if(response.statusCode == 200) {
      final List<dynamic> decodedData = jsonDecode(response.body) ['results'];
      List<Movie> movies = decodedData.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception("Falha em carregar filmes");
    }

  }

  Future<List<Movie>> getSearch(String titleSearch) async{

    final searchApiUrl = "https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&query=$titleSearch&include_adult=false&language=pt-BR&page=1";
    final response = await http.get(Uri.parse(searchApiUrl));

    if(response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) ['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    }else{
      throw Exception("Falha em carregar lista de busca");
    }

  }

  Future<String> getMoviePoster(Movie movie, String posterPath) async {

    final imageApiUrl = "${Constants.imagePath}${movie.posterPath}";
    return imageApiUrl;

  }

  Future<List<Genre>> getGenres() async{

    const searchApiUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.apiKey}&language=pt-BR";
    final response = await http.get(Uri.parse(searchApiUrl));

    if(response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['genres'];
      List<Genre> genres = data.map((genre) => Genre.fromMap(genre)).toList();
      return genres;
    }else{
      throw Exception("Falha em carregar lista de gêneros");
    }

  }

}