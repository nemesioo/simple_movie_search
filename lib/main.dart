import 'package:flutter/material.dart';
import 'package:simple_movie_search/movies.dart';
import 'package:simple_movie_search/utils/colors.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: PRIMARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoviesScreen(),
    );
  }
}
