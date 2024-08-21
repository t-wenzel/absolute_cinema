import 'package:flutter/material.dart';

class GenreTemplate extends StatelessWidget {

  const GenreTemplate({
    super.key,
    required this.genreName,
    required this.snapshot,
  });

  final String genreName;
  final AsyncSnapshot<List<dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        genreName,
        style: const TextStyle(
          fontSize: 16,
      ),
      ),
    );
  }

}