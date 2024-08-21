import 'package:flutter/material.dart';
import 'package:absolute_cinema/pages/home.dart';
import 'package:absolute_cinema/pages/loading.dart';
import 'package:absolute_cinema/pages/search_movie.dart';

void main() {

  runApp(MaterialApp(
    initialRoute: "/home",
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => const Home(),
      "/search": (context) => const SearchMovie(),
    },
  ));
}
