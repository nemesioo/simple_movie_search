// import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_movie_search/bloc/movies/bloc/movies_bloc.dart';
import 'package:simple_movie_search/models/movies_model.dart';
import 'package:simple_movie_search/movie_info.dart';
import 'package:simple_movie_search/utils/misc.dart';
import 'package:simple_movie_search/utils/strings.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  MoviesBloc _moviesBloc;
  MoviesState _state;
  TextEditingController _searchQuery;
  // Timer _debounce;

  @override
  void initState() {
    super.initState();
    _moviesBloc = MoviesBloc();
    _moviesBloc.add(GetMovies());
    _searchQuery = TextEditingController();
    // _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _moviesBloc.close();
    // _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    super.dispose();
  }

  // void _onSearchChanged() {
  //   if (_debounce?.isActive ?? false) _debounce.cancel();
  //   _debounce = Timer(
  //     Duration(milliseconds: 500),
  //     () {
  //       _moviesBloc.add(
  //         SearchMovies(query: _searchQuery.text),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesBloc,
      child: Scaffold(
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            this._state = state;
            return state.loading
                ? Misc.loader()
                : state.error
                    ? Misc.reload(func: () {
                        _moviesBloc.add(GetMovies());
                      })
                    : _movies();
          },
        ),
      ),
    );
  }

  Widget _movies() {
    Widget _searchBar() {
      return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            _state.switchToSearchList == true
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _moviesBloc.add(SwitchToHome());
                    })
                : SizedBox(),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff707070),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  fillColor: Color(0xffF2F2F2),
                  filled: true,
                  hintText: "$SEARCH_HINT",
                ),
                onSubmitted: (query) {
                  _moviesBloc.add(SearchMovies(query: query));
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget _movies({String title, List<Result> results}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "$title",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: results.map((movie) {
                String _releaseDate;
                _releaseDate = movie.releaseDate != null
                    ? DateFormat("MMM dd, yyyy").format(movie.releaseDate)
                    : "";
                return Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieInfo(
                                movie: movie,
                              )));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 150.0,
                          height: 200,
                          child: Image.network(
                              "$IMAGE_BASE_URL${movie.posterPath}"),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          "${movie.title}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Release Date: $_releaseDate",
                          style: TextStyle(color: Colors.grey[500]),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget _searchMovies() {
      return Column(
        children: _state.searchMovies.results.map((movie) {
          String _releaseDate;
          _releaseDate = movie.releaseDate != null
              ? DateFormat("MMM dd, yyyy").format(movie.releaseDate)
              : "";
          return Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieInfo(
                          movie: movie,
                        )));
              },
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.0,
                        height: 200,
                        child: movie.posterPath != null
                            ? Image.network(
                                "$IMAGE_BASE_URL${movie.posterPath}")
                            : Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${movie.title}",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Release Date: $_releaseDate",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Overview",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${movie.overview != "" ? movie.overview : EMPTY_OVERVIEW}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          _searchBar(),
          Expanded(
            child: _state.loadSearch == true
                ? Center(
                    child: Misc.loader(),
                  )
                : _state.switchToSearchList == true
                    ? _state.searchMovies.results.isEmpty
                        ? Misc.empty(message: "No Results found")
                        : SingleChildScrollView(
                            child: _searchMovies(),
                          )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            _movies(
                                title: "What's Popular",
                                results: _state.popular.results),
                            _movies(
                                title: "Top Rated",
                                results: _state.topRated.results),
                            _movies(
                                title: "Upcoming",
                                results: _state.upcoming.results),
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
